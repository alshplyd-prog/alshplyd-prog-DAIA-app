import React, { useState, useEffect } from 'react';
import {
  ShieldCheck,
  UserCheck,
  Lock,
  Globe,
  CheckCircle2,
  AlertCircle,
  Settings,
  ChevronLeft,
  X,
  Server,
  Sparkles,
  ArrowRight,
  Eye,
  EyeOff
} from 'lucide-react';
import { SalesRepresentative, Language } from '../types';
import { getBaseApiUrl, setCustomServerUrl, checkServerHealth, CLOUD_SERVER_URL } from '../lib/apiConfig';

const KNOWN_DEFAULT_REPS: SalesRepresentative[] = [
  {
    id: 'rep-1',
    name: 'ضياء المحاسب',
    phone: '07801112233',
    code: '4444',
    role: 'admin',
    canEdit: true,
    canDelete: true,
    canMoveCustomer: true,
    canSell: true,
    allowedListIds: ['all'],
  },
  {
    id: 'rep_1790325874814_0njii',
    name: 'زيد',
    phone: '0780',
    code: '4555',
    role: 'rep',
    canEdit: true,
    canDelete: false,
    canMoveCustomer: true,
    canSell: true,
    allowedListIds: ['all'],
  },
  {
    id: 'rep_1790075504995_4y79u',
    name: 'ماهر',
    phone: '',
    code: '4545',
    role: 'supervisor',
    canEdit: true,
    canDelete: false,
    canMoveCustomer: true,
    canSell: false,
    allowedListIds: ['all'],
  },
];

interface LoginViewProps {
  reps?: SalesRepresentative[];
  lang?: Language;
  onLogin: (rep: SalesRepresentative) => void | Promise<void>;
  onViewSplash?: () => void;
}

export const LoginView: React.FC<LoginViewProps> = ({
  reps = [],
  lang = 'ar',
  onLogin,
  onViewSplash,
}) => {
  const isAr = lang === 'ar';

  // Merge known reps with passed reps
  const combinedReps: SalesRepresentative[] = React.useMemo(() => {
    const list = [...KNOWN_DEFAULT_REPS];
    (reps || []).forEach((r) => {
      if (!list.some((existing) => existing.id === r.id || existing.name === r.name)) {
        list.push(r);
      }
    });
    return list;
  }, [reps]);

  const [selectedRep, setSelectedRep] = useState<SalesRepresentative>(() => {
    return combinedReps[0] || KNOWN_DEFAULT_REPS[0];
  });

  const [pinCode, setPinCode] = useState<string>('');
  const [errorMessage, setErrorMessage] = useState<string>('');
  const [isServerHealthy, setIsServerHealthy] = useState<boolean | null>(null);
  const [isCheckingServer, setIsCheckingServer] = useState<boolean>(false);
  const [showServerModal, setShowServerModal] = useState<boolean>(false);
  const [serverUrlInput, setServerUrlInput] = useState<string>(() => getBaseApiUrl());
  const [isLoggingIn, setIsLoggingIn] = useState<boolean>(false);

  // Check server health on load
  const verifyServer = async () => {
    setIsCheckingServer(true);
    try {
      const ok = await checkServerHealth();
      setIsServerHealthy(ok);
    } catch {
      setIsServerHealthy(false);
    } finally {
      setIsCheckingServer(false);
    }
  };

  useEffect(() => {
    verifyServer();
  }, []);

  const handleKeypadPress = (digit: string) => {
    if (pinCode.length < 8) {
      const newPin = pinCode + digit;
      setPinCode(newPin);
      setErrorMessage('');

      // Auto check if pin matches selected rep
      if (selectedRep && (selectedRep.code === newPin || newPin === '1234' || newPin === '4444')) {
        executeLogin(selectedRep);
      }
    }
  };

  const handleBackspace = () => {
    setPinCode((prev) => prev.slice(0, -1));
    setErrorMessage('');
  };

  const handleClear = () => {
    setPinCode('');
    setErrorMessage('');
  };

  const executeLogin = async (rep: SalesRepresentative) => {
    setIsLoggingIn(true);
    setErrorMessage('');
    try {
      if (typeof onLogin === 'function') {
        await onLogin(rep);
      }
    } catch (err: any) {
      setErrorMessage(err?.message || (isAr ? 'فشل تسجيل الدخول' : 'Login failed'));
      setIsLoggingIn(false);
    }
  };

  const handleSubmitPin = () => {
    if (!selectedRep) {
      setErrorMessage(isAr ? 'يرجى اختيار المندوب أولاً' : 'Please select representative');
      return;
    }

    const expectedCode = selectedRep.code?.trim();
    const entered = pinCode.trim();

    // Allow correct rep code, or master code 4444 / 1234
    if (
      (expectedCode && entered === expectedCode) ||
      entered === '4444' ||
      entered === '1234' ||
      selectedRep.role === 'admin'
    ) {
      executeLogin(selectedRep);
    } else {
      setErrorMessage(isAr ? 'رمز الدخول (PIN) غير صحيح!' : 'Incorrect PIN code!');
    }
  };

  const handleInstantAdminLogin = () => {
    const adminRep =
      combinedReps.find((r) => r.role === 'admin' || r.id === 'rep-1') ||
      KNOWN_DEFAULT_REPS[0];
    executeLogin(adminRep);
  };

  const handleSaveServerUrl = () => {
    setCustomServerUrl(serverUrlInput);
    setShowServerModal(false);
    verifyServer();
  };

  return (
    <div
      className="min-h-screen w-full bg-gradient-to-b from-slate-950 via-slate-900 to-slate-950 text-white flex flex-col justify-between p-4 sm:p-6 font-sans select-none"
      dir={isAr ? 'rtl' : 'ltr'}
    >
      {/* Header bar */}
      <div className="flex items-center justify-between w-full max-w-md mx-auto pt-2">
        <div className="flex items-center gap-2">
          <div className="w-10 h-10 rounded-2xl bg-indigo-600/20 border border-indigo-500/30 flex items-center justify-center text-indigo-400 shadow-inner">
            <ShieldCheck className="w-6 h-6" />
          </div>
          <div>
            <h1 className="font-black text-sm tracking-wide text-slate-100">
              {isAr ? 'نظام الكرار لإدارة الأقساط' : 'Alkarrar Installment System'}
            </h1>
            <p className="text-[10px] text-slate-400">
              {isAr ? 'نسخة الموبايل المزامنة 2026' : 'Mobile Sync Edition 2026'}
            </p>
          </div>
        </div>

        <div className="flex items-center gap-1.5">
          <button
            onClick={() => setShowServerModal(true)}
            className={`px-2.5 py-1.5 rounded-xl border flex items-center gap-1.5 text-[11px] font-bold transition-all ${
              isServerHealthy === true
                ? 'bg-emerald-950/40 border-emerald-500/30 text-emerald-400'
                : isServerHealthy === false
                ? 'bg-rose-950/40 border-rose-500/30 text-rose-400'
                : 'bg-slate-800 border-slate-700 text-slate-400'
            }`}
            title={isAr ? 'إعدادات ربط الخادم' : 'Server Settings'}
          >
            <Server className="w-3.5 h-3.5" />
            <span>
              {isCheckingServer
                ? isAr ? 'فحص...' : 'Checking...'
                : isServerHealthy
                ? isAr ? 'متصل' : 'Connected'
                : isAr ? 'سيرفر' : 'Server'}
            </span>
          </button>
        </div>
      </div>

      {/* Main card */}
      <div className="w-full max-w-md mx-auto my-auto py-4">
        <div className="bg-slate-900/90 border border-slate-800 rounded-3xl p-5 sm:p-6 shadow-2xl backdrop-blur-xl">
          <div className="text-center mb-5">
            <h2 className="text-base font-black text-slate-100">
              {isAr ? 'تسجيل الدخول إلى النظام' : 'Sign in to System'}
            </h2>
            <p className="text-xs text-slate-400 mt-0.5">
              {isAr ? 'اختر حسابك وأدخل الرمز السري للمتابعة' : 'Select user and enter PIN code'}
            </p>
          </div>

          {/* Rep Selection list */}
          <div className="space-y-2 mb-4">
            <label className="text-[11px] font-bold text-slate-400 block px-1">
              {isAr ? 'الحساب / المستخدم:' : 'Account / User:'}
            </label>
            <div className="grid grid-cols-1 gap-2">
              {combinedReps.map((rep) => {
                const isSelected = selectedRep.id === rep.id;
                const isAdminRep = rep.role === 'admin' || rep.id === 'rep-1';
                return (
                  <button
                    key={rep.id}
                    onClick={() => {
                      setSelectedRep(rep);
                      setPinCode('');
                      setErrorMessage('');
                    }}
                    type="button"
                    className={`w-full p-3 rounded-2xl border flex items-center justify-between text-right transition-all ${
                      isSelected
                        ? 'bg-indigo-600 border-indigo-500 text-white shadow-lg shadow-indigo-600/30'
                        : 'bg-slate-800/80 border-slate-700/60 hover:bg-slate-800 text-slate-200'
                    }`}
                  >
                    <div className="flex items-center gap-3">
                      <div
                        className={`w-9 h-9 rounded-xl flex items-center justify-center font-black text-sm ${
                          isSelected
                            ? 'bg-white/20 text-white'
                            : 'bg-slate-700 text-indigo-400'
                        }`}
                      >
                        {rep.name.slice(0, 1)}
                      </div>
                      <div>
                        <div className="font-extrabold text-xs flex items-center gap-1.5">
                          <span>{rep.name}</span>
                          {isAdminRep && (
                            <span
                              className={`text-[9px] px-1.5 py-0.5 rounded-md font-black ${
                                isSelected
                                  ? 'bg-amber-400 text-slate-900'
                                  : 'bg-amber-500/20 text-amber-300'
                              }`}
                            >
                              {isAr ? 'مدير' : 'Admin'}
                            </span>
                          )}
                        </div>
                        <p
                          className={`text-[10px] mt-0.5 ${
                            isSelected ? 'text-indigo-100' : 'text-slate-400'
                          }`}
                        >
                          {rep.role === 'admin'
                            ? isAr ? 'صلاحيات كاملة شاملة' : 'Full Permissions'
                            : rep.role === 'supervisor'
                            ? isAr ? 'مشرف ميداني' : 'Field Supervisor'
                            : isAr ? 'مندوب تحصيل ومبيعات' : 'Sales & Collection Rep'}
                        </p>
                      </div>
                    </div>
                    {isSelected && <CheckCircle2 className="w-5 h-5 text-white shrink-0" />}
                  </button>
                );
              })}
            </div>
          </div>

          {/* PIN Input Display */}
          <div className="mb-4">
            <div className="flex items-center justify-between px-1 mb-1.5">
              <span className="text-[11px] font-bold text-slate-400">
                {isAr ? 'رمز الدخول (PIN):' : 'PIN Code:'}
              </span>
              <span className="text-[10px] text-slate-500">
                {isAr ? '(افتراضي 4444 أو 1234)' : '(default 4444 or 1234)'}
              </span>
            </div>
            <div className="flex items-center justify-center gap-2 py-3 bg-slate-950/60 border border-slate-800 rounded-2xl">
              {[0, 1, 2, 3].map((index) => {
                const filled = pinCode.length > index;
                return (
                  <div
                    key={index}
                    className={`w-3.5 h-3.5 rounded-full transition-all duration-150 ${
                      filled
                        ? 'bg-indigo-500 shadow-md shadow-indigo-500/50 scale-110'
                        : 'bg-slate-700/60'
                    }`}
                  />
                );
              })}
            </div>
          </div>

          {/* Error Message */}
          {errorMessage && (
            <div className="mb-3 p-2.5 rounded-xl bg-rose-950/40 border border-rose-500/30 text-rose-300 text-xs flex items-center gap-2">
              <AlertCircle className="w-4 h-4 shrink-0" />
              <span>{errorMessage}</span>
            </div>
          )}

          {/* Numeric Keypad */}
          <div className="grid grid-cols-3 gap-2 mb-4">
            {['1', '2', '3', '4', '5', '6', '7', '8', '9'].map((digit) => (
              <button
                key={digit}
                type="button"
                onClick={() => handleKeypadPress(digit)}
                className="py-3 rounded-2xl bg-slate-800 hover:bg-slate-700 active:bg-indigo-600 active:text-white border border-slate-700/60 font-black text-base text-slate-100 transition-colors shadow-sm"
              >
                {digit}
              </button>
            ))}
            <button
              type="button"
              onClick={handleClear}
              className="py-3 rounded-2xl bg-slate-800/60 hover:bg-slate-800 border border-slate-700/60 font-bold text-xs text-slate-400 transition-colors"
            >
              {isAr ? 'مسح' : 'Clear'}
            </button>
            <button
              type="button"
              onClick={() => handleKeypadPress('0')}
              className="py-3 rounded-2xl bg-slate-800 hover:bg-slate-700 active:bg-indigo-600 active:text-white border border-slate-700/60 font-black text-base text-slate-100 transition-colors shadow-sm"
            >
              0
            </button>
            <button
              type="button"
              onClick={handleBackspace}
              className="py-3 rounded-2xl bg-slate-800/60 hover:bg-slate-800 border border-slate-700/60 font-bold text-xs text-slate-400 transition-colors flex items-center justify-center"
            >
              ⌫
            </button>
          </div>

          {/* Submit button */}
          <div className="space-y-2">
            <button
              type="button"
              disabled={isLoggingIn}
              onClick={handleSubmitPin}
              className="w-full py-3.5 px-4 rounded-2xl bg-indigo-600 hover:bg-indigo-500 active:bg-indigo-700 text-white font-black text-xs flex items-center justify-center gap-2 shadow-lg shadow-indigo-600/30 transition-all disabled:opacity-50"
            >
              <Lock className="w-4 h-4" />
              <span>{isLoggingIn ? (isAr ? 'جاري الدخول...' : 'Logging in...') : (isAr ? 'تسجيل الدخول' : 'Sign In')}</span>
            </button>

            {/* Instant Admin Bypass Button */}
            <button
              type="button"
              disabled={isLoggingIn}
              onClick={handleInstantAdminLogin}
              className="w-full py-2.5 px-3 rounded-2xl bg-slate-800 hover:bg-slate-700 text-indigo-300 font-extrabold text-[11px] flex items-center justify-center gap-1.5 border border-indigo-500/20 transition-all"
            >
              <Sparkles className="w-3.5 h-3.5 text-indigo-400" />
              <span>{isAr ? 'دخول فوري مباشر كمدير (تجاوز الرمز)' : 'Direct Admin Instant Access'}</span>
            </button>
          </div>
        </div>
      </div>

      {/* Footer info */}
      <div className="w-full max-w-md mx-auto pb-2 text-center text-[10px] text-slate-500 flex items-center justify-between px-2">
        <span>{isAr ? 'السيرفر: ' : 'Server: '}{getBaseApiUrl().replace(/^https?:\/\//, '').slice(0, 24)}...</span>
        <button
          onClick={() => setShowServerModal(true)}
          className="text-indigo-400 hover:underline font-bold"
        >
          {isAr ? 'تغيير السيرفر' : 'Change Server'}
        </button>
      </div>

      {/* Server Settings Modal */}
      {showServerModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-950/80 backdrop-blur-md">
          <div className="bg-slate-900 border border-slate-800 rounded-3xl p-5 max-w-sm w-full space-y-4 shadow-2xl">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-2">
                <Server className="w-5 h-5 text-indigo-400" />
                <h3 className="font-extrabold text-sm text-slate-100">
                  {isAr ? 'إعداد رابط السيرفر السحابي' : 'Server Connection URL'}
                </h3>
              </div>
              <button
                onClick={() => setShowServerModal(false)}
                className="p-1 rounded-xl bg-slate-800 text-slate-400 hover:text-white"
              >
                <X className="w-4 h-4" />
              </button>
            </div>

            <p className="text-xs text-slate-400 leading-relaxed">
              {isAr
                ? 'يرجى التأكد من ربط التطبيق برابط السيرفر السحابي الصحيح لمزامنة العقود والزبائن والدفعات الحية.'
                : 'Configure the cloud backend API URL to sync contracts, payments, and customers.'}
            </p>

            <div className="space-y-1.5">
              <label className="text-[11px] font-bold text-slate-300 block">
                {isAr ? 'عنوان السيرفر (URL):' : 'Server URL:'}
              </label>
              <input
                type="text"
                value={serverUrlInput}
                onChange={(e) => setServerUrlInput(e.target.value)}
                placeholder="https://..."
                className="w-full px-3.5 py-2.5 rounded-xl bg-slate-950 border border-slate-800 text-xs text-slate-100 focus:outline-none focus:border-indigo-500 font-mono"
                dir="ltr"
              />
            </div>

            <div className="flex gap-2">
              <button
                type="button"
                onClick={() => setServerUrlInput(CLOUD_SERVER_URL)}
                className="flex-1 py-2 rounded-xl bg-slate-800 hover:bg-slate-700 text-slate-300 text-xs font-bold transition-all"
              >
                {isAr ? 'الرابط السحابي الافتراضي' : 'Default Cloud'}
              </button>
              <button
                type="button"
                onClick={verifyServer}
                className="px-3 py-2 rounded-xl bg-slate-800 hover:bg-slate-700 text-indigo-400 text-xs font-bold transition-all"
              >
                {isAr ? 'فحص الاتصال' : 'Test'}
              </button>
            </div>

            <div className="flex gap-2 pt-2 border-t border-slate-800">
              <button
                type="button"
                onClick={handleSaveServerUrl}
                className="flex-1 py-2.5 rounded-xl bg-indigo-600 hover:bg-indigo-500 text-white font-black text-xs transition-all shadow-md"
              >
                {isAr ? 'حفظ وتطبيق' : 'Save & Apply'}
              </button>
              <button
                type="button"
                onClick={() => setShowServerModal(false)}
                className="px-4 py-2.5 rounded-xl bg-slate-800 text-slate-300 font-bold text-xs"
              >
                {isAr ? 'إلغاء' : 'Cancel'}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};
