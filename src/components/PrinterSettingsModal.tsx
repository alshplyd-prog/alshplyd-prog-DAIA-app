import React, { useState, useEffect } from 'react';
import {
  X,
  Printer,
  Bluetooth,
  CheckCircle2,
  RefreshCw,
  Trash2,
  AlertCircle,
  ShieldCheck,
  Lock,
  Settings,
  Wifi,
  Bell,
  Server,
  Globe,
  Database,
  Sparkles,
  FileText,
  Zap,
  Power,
  Radio,
  Layers,
  Smartphone,
  ExternalLink,
  Eye,
} from 'lucide-react';
import { Language } from '../types';
import {
  getSavedPrinterConfig,
  savePrinterConfig,
  scanAndSaveBluetoothPrinter,
  listPairedBluetoothDevices,
  requestWebBluetoothDevice,
  requestAndroidBluetoothPermissions,
  ensureBluetoothEnabled,
  BluetoothDevice,
  directPrintReceipt,
  ThermalReceiptData,
  PrinterConfig,
  PrintMethod,
  getSavedPrintersList,
  removePrinterProfile,
  switchActivePrinter,
  SavedPrinterProfile,
  openNativeBluetoothSettings,
} from '../lib/bluetoothPrinter';
import { initCapacitorPush } from '../lib/capacitorPush';
import {
  flushPendingQueue,
  requestAllBackgroundAndSyncPermissions,
  setFieldKeepAliveMode,
  isKeepAliveModeEnabled,
  requestDisplayOverAppsPermission,
  openBatteryOptimizationSettings,
  openAutoStartSettings,
} from '../lib/offlineQueue.ts';
import { checkServerHealth } from '../lib/apiConfig';
import { forceRefreshAllDataFromPostgres, reconcileAllLocalWithDatabase } from '../lib/postgresClient';

interface PrinterSettingsModalProps {
  isOpen: boolean;
  onClose: () => void;
  lang: Language;
  onOpenServerQueries?: () => void;
  currentRep?: any;
  isAdmin?: boolean;
}

export const PrinterSettingsModal: React.FC<PrinterSettingsModalProps> = ({
  isOpen,
  onClose,
  lang,
  onOpenServerQueries,
  currentRep,
  isAdmin,
}) => {
  const isAr = lang === 'ar';
  const [config, setConfig] = useState<PrinterConfig>({
    deviceId: null,
    deviceName: null,
    autoPrintOnPayment: true,
    printMethod: 'direct_bluetooth',
    networkIp: '',
    networkPort: 9100,
  });
  const [printerProfiles, setPrinterProfiles] = useState<SavedPrinterProfile[]>([]);
  const [isScanning, setIsScanning] = useState(false);
  const [isTesting, setIsTesting] = useState(false);
  const [isRequestingPerms, setIsRequestingPerms] = useState(false);
  const [isEnablingBackground, setIsEnablingBackground] = useState(false);
  const [pairedDevices, setPairedDevices] = useState<BluetoothDevice[] | null>(null);
  const [showDevicePicker, setShowDevicePicker] = useState<boolean>(false);

  // Keep-Alive & Anti-Sleep states
  const [isKeepAliveOn, setIsKeepAliveOn] = useState<boolean>(false);
  const [isTogglingKeepAlive, setIsTogglingKeepAlive] = useState<boolean>(false);
  const [isRequestingOverlay, setIsRequestingOverlay] = useState<boolean>(false);
  const [isRequestingBattery, setIsRequestingBattery] = useState<boolean>(false);
  const [isRequestingAutoStart, setIsRequestingAutoStart] = useState<boolean>(false);
  const [showLockGuide, setShowLockGuide] = useState<boolean>(false);

  // Server & Database connection state
  const [isTestingServer, setIsTestingServer] = useState<boolean>(false);
  const [isReconciling, setIsReconciling] = useState<boolean>(false);
  const [reconcileResult, setReconcileResult] = useState<{ success: boolean; message: string; count?: number } | null>(null);
  const [serverHealth, setServerHealth] = useState<{
    tested: boolean;
    ok: boolean;
    latencyMs?: number;
    message?: string;
  } | null>(null);

  const [statusMessage, setStatusMessage] = useState<{ text: string; type: 'success' | 'error' | 'info' } | null>(null);

  // Modal Active Sub-Tab
  const [activeTab, setActiveTab] = useState<'printer' | 'sync' | 'android'>('printer');

  const handleRunReconciliation = async () => {
    setIsReconciling(true);
    setReconcileResult(null);
    try {
      const res = await reconcileAllLocalWithDatabase({ force: true, forcePushAll: true });
      setReconcileResult({
        success: res.success,
        message: res.message,
        count: res.totalInserted,
      });
      setStatusMessage({ text: res.message, type: res.success ? 'success' : 'error' });
    } catch (e: any) {
      setReconcileResult({
        success: false,
        message: e?.message || 'حدث خطأ أثناء مطابقة قاعدة البيانات',
      });
      setStatusMessage({ text: e?.message || 'خطأ أثناء المطابقة', type: 'error' });
    } finally {
      setIsReconciling(false);
    }
  };

  const loadSavedData = () => {
    const saved = getSavedPrinterConfig();
    setConfig(saved);
    setPrinterProfiles(getSavedPrintersList());
    setIsKeepAliveOn(isKeepAliveModeEnabled());
  };

  const handleToggleKeepAlive = async () => {
    setIsTogglingKeepAlive(true);
    try {
      const next = !isKeepAliveOn;
      await setFieldKeepAliveMode(next);
      setIsKeepAliveOn(next);
      setStatusMessage({
        text: isAr
          ? next
            ? '⚡ تم تفعيل وضع العمل الميداني المستمر (مانع النوم + النبض الصامت + إبقاء الشاشة حية) بنجاح!'
            : 'تم إيقاف وضع العمل الميداني المستمر.'
          : next
            ? 'Field Keep-Alive mode activated!'
            : 'Field Keep-Alive mode deactivated.',
        type: 'success',
      });
    } catch (e: any) {
      setStatusMessage({ text: e?.message || 'خطأ في تفعيل وضع البقاء مستيقظاً', type: 'error' });
    } finally {
      setIsTogglingKeepAlive(false);
    }
  };

  const handleRequestOverlay = async () => {
    setIsRequestingOverlay(true);
    try {
      const res = await requestDisplayOverAppsPermission();
      setStatusMessage({ text: res.message, type: res.success ? 'success' : 'error' });
    } catch (e: any) {
      setStatusMessage({ text: e?.message || 'خطأ أثناء طلب صلاحية الظهور فوق التطبيقات', type: 'error' });
    } finally {
      setIsRequestingOverlay(false);
    }
  };

  const handleOpenBattery = async () => {
    setIsRequestingBattery(true);
    try {
      const res = await openBatteryOptimizationSettings();
      setStatusMessage({ text: res.message, type: res.success ? 'success' : 'error' });
    } catch (e: any) {
      setStatusMessage({ text: e?.message || 'خطأ أثناء فتح إعدادات البطارية', type: 'error' });
    } finally {
      setIsRequestingBattery(false);
    }
  };

  const handleOpenAutoStart = async () => {
    setIsRequestingAutoStart(true);
    try {
      const res = await openAutoStartSettings();
      setStatusMessage({ text: res.message, type: res.success ? 'success' : 'error' });
    } catch (e: any) {
      setStatusMessage({ text: e?.message || 'خطأ أثناء فتح إعدادات التشغيل التلقائي', type: 'error' });
    } finally {
      setIsRequestingAutoStart(false);
    }
  };

  useEffect(() => {
    if (isOpen) {
      loadSavedData();
      flushPendingQueue().catch(() => {});
      setStatusMessage(null);
      setPairedDevices(null);
      setShowDevicePicker(false);
      setServerHealth(null);
    }
  }, [isOpen]);

  const handleTestServerConnection = async () => {
    setIsTestingServer(true);
    setServerHealth(null);
    try {
      const res = await checkServerHealth();
      if (res.ok) {
        setServerHealth({
          tested: true,
          ok: true,
          latencyMs: res.latencyMs,
          message: isAr
            ? `متصل بنجاح بقاعدة بيانات السيرفر (${res.latencyMs}ms)`
            : `Connected to Cloud PostgreSQL DB (${res.latencyMs}ms)`,
        });
        // Also trigger fresh data pull
        await forceRefreshAllDataFromPostgres().catch(() => {});
      } else {
        setServerHealth({
          tested: true,
          ok: false,
          latencyMs: res.latencyMs,
          message: res.error || (isAr ? 'تعذر الاتصال بالخادم' : 'Failed to connect to server'),
        });
      }
    } catch (e: any) {
      setServerHealth({
        tested: true,
        ok: false,
        message: e?.message || (isAr ? 'خطأ في الاتصال' : 'Connection error'),
      });
    } finally {
      setIsTestingServer(false);
    }
  };


  if (!isOpen) return null;

  const handleSwitchPrinter = (profile: SavedPrinterProfile) => {
    const updated = switchActivePrinter(profile);
    setConfig(updated);
    setPrinterProfiles(getSavedPrintersList());
    setStatusMessage({
      text: isAr ? `تم تغيير الطابعة بنجاح إلى: ${profile.name}` : `Switched printer to: ${profile.name}`,
      type: 'success',
    });
  };

  const handleSavePrinter = (nameToSave: string, idToSave: string, method?: PrintMethod) => {
    const cleanName = (nameToSave || 'طابعة البلوتوث').trim();
    const cleanId = (idToSave || cleanName).trim();

    const updated = savePrinterConfig({
      deviceId: cleanId,
      deviceName: cleanName,
      printMethod: method || 'direct_bluetooth',
      autoPrintOnPayment: true,
    });

    if (updated) {
      setConfig(updated);
      setPrinterProfiles(getSavedPrintersList());
      setShowDevicePicker(false);
      setStatusMessage({
        text: isAr ? `تم الاتصال واعتماد الطابعة: ${cleanName}` : `Connected and set printer: ${cleanName}`,
        type: 'success',
      });
    }
  };

  const handleRequestAllPermissions = async (e?: React.MouseEvent) => {
    if (e) {
      e.preventDefault();
      e.stopPropagation();
    }
    setIsRequestingPerms(true);
    setStatusMessage({
      text: isAr ? 'جاري فحص وتفعيل اتصال البلوتوث والمزامنة في الخلفية...' : 'Requesting Bluetooth & background sync...',
      type: 'info',
    });

    try {
      // Trigger native Android bridge & background permissions
      const androidBridge = (window as any).AndroidPrinter || (window as any).AndroidInterface || (window as any).Android;
      if (androidBridge && typeof androidBridge.requestPermissions === 'function') {
        androidBridge.requestPermissions();
      }

      await requestAllBackgroundAndSyncPermissions();
      await requestAndroidBluetoothPermissions();
      await ensureBluetoothEnabled();
      await flushPendingQueue();
    } catch (e) {
      console.warn('Permissions check error:', e);
    }

    try {
      await initCapacitorPush();
    } catch (e) {}

    try {
      localStorage.setItem('alkarrar_all_perms_granted', 'true');
      localStorage.setItem('sami_app_pin_unlocked', 'true');
      sessionStorage.setItem('sami_app_pin_unlocked', 'true');
    } catch (e) {}

    setIsRequestingPerms(false);
    setStatusMessage({
      text: isAr
        ? 'تم تفعيل اتصال البلوتوث والمزامنة الحية في الخلفية بنجاح.'
        : 'Bluetooth & background live sync enabled successfully.',
      type: 'success',
    });
  };

  const handleScanAndSave = async () => {
    setIsScanning(true);
    setStatusMessage({
      text: isAr ? 'جاري البحث عن طابعات البلوتوث المقترنة والمحيطة...' : 'Scanning for Bluetooth printers...',
      type: 'info',
    });

    try {
      // 1. Native paired devices list (Android APK or bridge)
      const devices = await listPairedBluetoothDevices();

      if (devices && devices.length > 0) {
        setIsScanning(false);
        setPairedDevices(devices);
        setShowDevicePicker(true);
        setStatusMessage({
          text: isAr ? `تم العثور على ${devices.length} جهاز بلوتوث. اضغط للاعتماد:` : `Found ${devices.length} Bluetooth devices. Select one:`,
          type: 'info',
        });
        return;
      }

      // 2. Web Bluetooth Dialog (Web browser on mobile or desktop)
      if (typeof window !== 'undefined' && 'bluetooth' in navigator) {
        const webRes = await requestWebBluetoothDevice();
        setIsScanning(false);
        if (webRes.success && webRes.deviceName) {
          const updated = getSavedPrinterConfig();
          setConfig(updated);
          setPrinterProfiles(getSavedPrintersList());
          setStatusMessage({
            text: isAr ? `تم الاتصال بنجاح مع: ${webRes.deviceName}` : `Connected to: ${webRes.deviceName}`,
            type: 'success',
          });
          return;
        } else if (webRes.message && !webRes.message.includes('غير مدعومة')) {
          setStatusMessage({
            text: webRes.message,
            type: 'info',
          });
          return;
        }
      }

      // 3. Fallback scan via serial / bridge
      const res = await scanAndSaveBluetoothPrinter();
      setIsScanning(false);

      if (res.success && res.deviceName) {
        const updated = getSavedPrinterConfig();
        setConfig(updated);
        setPrinterProfiles(getSavedPrintersList());
        setStatusMessage({
          text: isAr ? `تم الاقتران بالطابعة: ${res.deviceName}` : `Connected to: ${res.deviceName}`,
          type: 'success',
        });
      } else {
        setStatusMessage({
          text: isAr
            ? 'لم يتم العثور على طابعة مقترنة. يرجى الاقتران بالطابعة من إعدادات بلوتوث الهاتف ثم الضغط على بحث مجدداً.'
            : 'No paired printer found. Please pair in phone settings and scan again.',
          type: 'info',
        });
      }
    } catch (err: any) {
      setIsScanning(false);
      setStatusMessage({
        text: isAr ? `تنبيه: ${err.message || 'يرجى التأكد من تشغيل البلوتوث واقتران الطابعة.'}` : `Notice: ${err.message || 'Please check Bluetooth.'}`,
        type: 'info',
      });
    }
  };

  const handleSelectDevice = (dev: BluetoothDevice) => {
    const deviceId = dev.address || dev.id || dev.name;
    const deviceName = dev.name || 'طابعة البلوتوث';
    handleSavePrinter(deviceName, deviceId);
  };

  const handleOpenPhoneBluetooth = () => {
    const opened = openNativeBluetoothSettings();
    if (opened) {
      setStatusMessage({
        text: isAr ? 'تم فتح إعدادات البلوتوث للهاتف. قم باقتران الطابعة ثم عد للتطبيق.' : 'Bluetooth settings opened. Pair your printer and return.',
        type: 'info',
      });
    } else {
      setStatusMessage({
        text: isAr ? 'يرجى فتح تطبيق "الإعدادات" في هاتفك ثم البلوتوث للاقتران بالطابعة.' : 'Please open Phone Settings -> Bluetooth to pair your printer.',
        type: 'info',
      });
    }
  };

  const handleTestPrint = async () => {
    setIsTesting(true);
    const targetPrinterName = config.deviceName || 'طابعة البلوتوث';

    setStatusMessage({
      text: isAr ? `جاري إرسال وصل الفحص إلى ${targetPrinterName}...` : `Testing print to ${targetPrinterName}...`,
      type: 'info',
    });

    const now = new Date();
    const testData: ThermalReceiptData = {
      shopTitle: 'الكرار للموبايل',
      receiptNo: '0000',
      customerName: 'فحص الطابعة المباشرة',
      itemName: 'وصل اختبار النظام المباشر',
      totalPrice: 100000,
      totalPaid: 100000,
      remainingBalance: 0,
      paidAmount: 100000,
      amountInWords: 'مائة ألف دينار عراقي لا غير',
      dateStr: `${String(now.getDate()).padStart(2, '0')}-${String(now.getMonth() + 1).padStart(2, '0')}-${now.getFullYear()}`,
      timeStr: now.toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit', hour12: true }),
      template: 'template_1',
    };

    const res = await directPrintReceipt(testData, (progressMsg) => {
      setStatusMessage({
        text: progressMsg,
        type: 'info',
      });
    });

    setIsTesting(false);

    if (res.success) {
      setStatusMessage({
        text: isAr ? 'تم إرسال الطباعة المباشرة بنجاح' : 'Direct print sent successfully',
        type: 'success',
      });
    } else {
      setStatusMessage({
        text: res.message || (isAr ? 'تعذر إرسال وصل الفحص' : 'Test print failed'),
        type: 'error',
      });
    }
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-2 sm:p-4 bg-slate-950/80 backdrop-blur-md animate-in fade-in duration-200 dir-rtl">
      <div
        className="bg-slate-50 dark:bg-slate-900 rounded-3xl w-full max-w-3xl lg:max-w-4xl shadow-2xl border border-slate-200 dark:border-slate-800 overflow-hidden flex flex-col max-h-[92vh]"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header */}
        <div className="p-4 sm:p-5 bg-gradient-to-r from-teal-800 via-teal-700 to-emerald-800 text-white flex items-center justify-between shadow-md">
          <div className="flex items-center gap-3">
            <div className="p-2.5 bg-white/15 rounded-2xl backdrop-blur-sm border border-white/20 shadow-inner">
              <Settings className="w-5 h-5 text-teal-100" />
            </div>
            <div>
              <h2 className="text-base sm:text-lg font-black text-white tracking-wide">
                {isAr ? 'لوحة إعدادات النظام والضبط' : 'System Settings & Controls'}
              </h2>
              <p className="text-xs text-teal-100/90 font-bold">
                {isAr ? 'إدارة الطابعة الحرارية، المزامنة السحابية، وخيارات العمل الميداني' : 'Manage thermal printer, cloud sync & background permissions'}
              </p>
            </div>
          </div>
          <button
            onClick={onClose}
            className="p-2 rounded-2xl text-white/80 hover:text-white hover:bg-white/15 transition-all cursor-pointer active:scale-95"
            title={isAr ? 'إغلاق' : 'Close'}
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Navigation Tabs Header */}
        <div className="px-4 pt-3 pb-2 bg-white dark:bg-slate-800/90 border-b border-slate-200 dark:border-slate-700/80 flex items-center gap-2 overflow-x-auto no-scrollbar">
          <button
            type="button"
            onClick={() => setActiveTab('printer')}
            className={`py-2 px-3.5 sm:px-4 rounded-xl text-xs font-black flex items-center gap-2 transition-all cursor-pointer whitespace-nowrap shrink-0 ${
              activeTab === 'printer'
                ? 'bg-teal-600 text-white shadow-md shadow-teal-600/20 scale-102'
                : 'bg-slate-100 dark:bg-slate-700/60 text-slate-600 dark:text-slate-300 hover:bg-slate-200 dark:hover:bg-slate-700'
            }`}
          >
            <Printer className="w-4 h-4" />
            <span>{isAr ? 'طابعة البلوتوث والطباعة' : 'Thermal Printer'}</span>
          </button>

          <button
            type="button"
            onClick={() => setActiveTab('sync')}
            className={`py-2 px-3.5 sm:px-4 rounded-xl text-xs font-black flex items-center gap-2 transition-all cursor-pointer whitespace-nowrap shrink-0 ${
              activeTab === 'sync'
                ? 'bg-emerald-600 text-white shadow-md shadow-emerald-600/20 scale-102'
                : 'bg-slate-100 dark:bg-slate-700/60 text-slate-600 dark:text-slate-300 hover:bg-slate-200 dark:hover:bg-slate-700'
            }`}
          >
            <Database className="w-4 h-4" />
            <span>{isAr ? 'المزامنة والسيرفر السحابي' : 'Cloud Database & Sync'}</span>
          </button>

          <button
            type="button"
            onClick={() => setActiveTab('android')}
            className={`py-2 px-3.5 sm:px-4 rounded-xl text-xs font-black flex items-center gap-2 transition-all cursor-pointer whitespace-nowrap shrink-0 ${
              activeTab === 'android'
                ? 'bg-indigo-600 text-white shadow-md shadow-indigo-600/20 scale-102'
                : 'bg-slate-100 dark:bg-slate-700/60 text-slate-600 dark:text-slate-300 hover:bg-slate-200 dark:hover:bg-slate-700'
            }`}
          >
            <Zap className="w-4 h-4" />
            <span>{isAr ? 'العمل الميداني والصلاحيات' : 'Field Permissions'}</span>
          </button>
        </div>

        {/* Content Body */}
        <div className="p-4 sm:p-6 space-y-4 overflow-y-auto max-h-[calc(92vh-130px)]">
          {/* Status Alert Banner */}
          {statusMessage && (
            <div
              className={`p-3.5 rounded-2xl border text-xs font-bold flex items-center justify-between gap-3 shadow-xs animate-in slide-in-from-top-1 duration-200 ${
                statusMessage.type === 'success'
                  ? 'bg-emerald-50 text-emerald-900 border-emerald-200 dark:bg-emerald-950/70 dark:text-emerald-200 dark:border-emerald-800'
                  : statusMessage.type === 'error'
                  ? 'bg-rose-50 text-rose-900 border-rose-200 dark:bg-rose-950/70 dark:text-rose-200 dark:border-rose-800'
                  : 'bg-sky-50 text-sky-900 border-sky-200 dark:bg-sky-950/70 dark:text-sky-200 dark:border-sky-800'
              }`}
            >
              <div className="flex items-center gap-2.5 min-w-0">
                {statusMessage.type === 'success' ? (
                  <CheckCircle2 className="w-4 h-4 text-emerald-600 dark:text-emerald-400 shrink-0" />
                ) : statusMessage.type === 'error' ? (
                  <AlertCircle className="w-4 h-4 text-rose-600 dark:text-rose-400 shrink-0" />
                ) : (
                  <RefreshCw className="w-4 h-4 text-sky-600 dark:text-sky-400 animate-spin shrink-0" />
                )}
                <span className="truncate">{statusMessage.text}</span>
              </div>
              <button
                type="button"
                onClick={() => setStatusMessage(null)}
                className="text-slate-400 hover:text-slate-600 dark:hover:text-slate-200 cursor-pointer p-0.5"
              >
                <X className="w-3.5 h-3.5" />
              </button>
            </div>
          )}

          {/* TAB 1: PRINTER SETTINGS */}
          {activeTab === 'printer' && (
            <div className="space-y-4 animate-in fade-in duration-200">
              {/* Active Printer Card */}
              <div className="p-4 bg-white dark:bg-slate-800 rounded-2xl border border-slate-200 dark:border-slate-700/80 shadow-xs space-y-3.5">
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-3">
                    <div className="p-2.5 bg-teal-100 dark:bg-teal-950 text-teal-700 dark:text-teal-300 rounded-2xl border border-teal-200 dark:border-teal-800">
                      <Bluetooth className="w-5 h-5" />
                    </div>
                    <div>
                      <span className="text-[11px] font-bold text-slate-500 dark:text-slate-400 block">
                        {isAr ? 'الطابعة الحرارية المعتمدة حالياً:' : 'Active Connected Printer:'}
                      </span>
                      <span className="text-sm sm:text-base font-black text-slate-900 dark:text-slate-100">
                        {config.deviceName || (isAr ? 'طابعة البلوتوث المباشرة' : 'Direct Bluetooth Printer')}
                      </span>
                      {config.deviceId && (
                        <span className="text-[10px] font-mono text-slate-400 block dir-ltr text-right">
                          ID / MAC: {config.deviceId}
                        </span>
                      )}
                    </div>
                  </div>

                  <span className="inline-flex items-center gap-1.5 text-xs font-black px-3 py-1.5 rounded-xl bg-emerald-100 text-emerald-800 dark:bg-emerald-950 dark:text-emerald-300 border border-emerald-300 dark:border-emerald-800 shadow-2xs">
                    <CheckCircle2 className="w-3.5 h-3.5 text-emerald-600 dark:text-emerald-400" />
                    {isAr ? 'معتمدة للطباعة' : 'Active'}
                  </span>
                </div>

                {/* Print Method Selector */}
                <div className="pt-3 border-t border-slate-100 dark:border-slate-700/60">
                  <span className="text-xs font-black text-slate-700 dark:text-slate-300 block mb-2">
                    {isAr ? '🎯 اختيار نمط إرسال الوصل للطباعة:' : 'Print Output Method:'}
                  </span>
                  <div className="grid grid-cols-1 sm:grid-cols-3 gap-2">
                    <button
                      type="button"
                      onClick={() => {
                        const updated = savePrinterConfig({ printMethod: 'direct_bluetooth' });
                        if (updated) {
                          setConfig(updated);
                          setStatusMessage({
                            text: isAr ? 'تم تفعيل نمط الطباعة المباشرة عبر البلوتوث (ESC/POS)' : 'Switched to Direct Bluetooth ESC/POS',
                            type: 'success',
                          });
                        }
                      }}
                      className={`p-2.5 rounded-xl border text-xs font-black flex items-center justify-center gap-2 transition-all cursor-pointer ${
                        config.printMethod === 'direct_bluetooth' || !config.printMethod
                          ? 'bg-teal-600 text-white border-teal-700 shadow-sm'
                          : 'bg-slate-50 dark:bg-slate-900 text-slate-700 dark:text-slate-300 border-slate-200 dark:border-slate-700 hover:border-teal-400'
                      }`}
                    >
                      <Bluetooth className="w-4 h-4 shrink-0" />
                      <span>{isAr ? 'بلوتوث مباشر' : 'Direct BT'}</span>
                    </button>

                    <button
                      type="button"
                      onClick={() => {
                        const updated = savePrinterConfig({ printMethod: 'rawbt', deviceName: 'تطبيق RawBT للأندرويد' });
                        if (updated) {
                          setConfig(updated);
                          setStatusMessage({
                            text: isAr ? 'تم تفعيل الطباعة عبر تطبيق RawBT للأندرويد' : 'Switched to RawBT Android App',
                            type: 'success',
                          });
                        }
                      }}
                      className={`p-2.5 rounded-xl border text-xs font-black flex items-center justify-center gap-2 transition-all cursor-pointer ${
                        config.printMethod === 'rawbt'
                          ? 'bg-indigo-600 text-white border-indigo-700 shadow-sm'
                          : 'bg-slate-50 dark:bg-slate-900 text-slate-700 dark:text-slate-300 border-slate-200 dark:border-slate-700 hover:border-indigo-400'
                      }`}
                    >
                      <Printer className="w-4 h-4 shrink-0" />
                      <span>{isAr ? 'تطبيق RawBT' : 'RawBT App'}</span>
                    </button>

                    <button
                      type="button"
                      onClick={() => {
                        const updated = savePrinterConfig({ printMethod: 'system_default', deviceName: 'طابعة النظام الافتراضية' });
                        if (updated) {
                          setConfig(updated);
                          setStatusMessage({
                            text: isAr ? 'تم تفعيل طابعة النظام الافتراضية / نافذة الطباعة' : 'Switched to System Default Printer',
                            type: 'success',
                          });
                        }
                      }}
                      className={`p-2.5 rounded-xl border text-xs font-black flex items-center justify-center gap-2 transition-all cursor-pointer ${
                        config.printMethod === 'system_default'
                          ? 'bg-sky-600 text-white border-sky-700 shadow-sm'
                          : 'bg-slate-50 dark:bg-slate-900 text-slate-700 dark:text-slate-300 border-slate-200 dark:border-slate-700 hover:border-sky-400'
                      }`}
                    >
                      <FileText className="w-4 h-4 shrink-0" />
                      <span>{isAr ? 'طابعة النظام' : 'System Print'}</span>
                    </button>
                  </div>
                </div>

                {/* Saved Printers List */}
                {printerProfiles && printerProfiles.length > 0 && (
                  <div className="pt-3 border-t border-slate-100 dark:border-slate-700/60 space-y-2">
                    <span className="text-xs font-black text-slate-700 dark:text-slate-300 block">
                      {isAr ? '📋 الطابعات المحفوظة (اضغط للتبديل الفوري):' : 'Saved Printers (Tap to switch):'}
                    </span>
                    <div className="grid grid-cols-1 gap-2">
                      {printerProfiles.map((p) => {
                        const isActive =
                          (config.deviceId && p.address === config.deviceId) ||
                          (config.deviceName && p.name === config.deviceName);

                        return (
                          <div
                            key={p.id}
                            className={`p-3 rounded-xl border flex items-center justify-between transition-all ${
                              isActive
                                ? 'bg-teal-50 dark:bg-teal-950/60 border-teal-400 dark:border-teal-700 shadow-2xs'
                                : 'bg-slate-50 dark:bg-slate-900/60 border-slate-200 dark:border-slate-700/80 hover:border-slate-300'
                            }`}
                          >
                            <div className="flex items-center gap-2.5">
                              <Printer className={`w-4 h-4 ${isActive ? 'text-teal-600 dark:text-teal-400' : 'text-slate-400'}`} />
                              <div>
                                <span className="text-xs font-black text-slate-800 dark:text-slate-200 block">
                                  {p.name}
                                </span>
                                {p.address && (
                                  <span className="text-[10px] text-slate-400 font-mono block">
                                    {p.address}
                                  </span>
                                )}
                              </div>
                            </div>

                            <div className="flex items-center gap-2">
                              {isActive ? (
                                <span className="text-[10px] font-black px-2.5 py-1 rounded-lg bg-teal-600 text-white flex items-center gap-1">
                                  <CheckCircle2 className="w-3 h-3" />
                                  {isAr ? 'الحالية' : 'Current'}
                                </span>
                              ) : (
                                <button
                                  type="button"
                                  onClick={() => handleSwitchPrinter(p)}
                                  className="px-3 py-1 rounded-lg bg-teal-600 hover:bg-teal-700 text-white text-[11px] font-bold cursor-pointer transition-all shadow-xs active:scale-95"
                                >
                                  {isAr ? 'تغيير واعتماد' : 'Switch'}
                                </button>
                              )}

                              {printerProfiles.length > 1 && (
                                <button
                                  type="button"
                                  onClick={() => {
                                    removePrinterProfile(p.id);
                                    setPrinterProfiles(getSavedPrintersList());
                                  }}
                                  className="p-1.5 rounded-lg text-slate-400 hover:text-rose-600 hover:bg-rose-50 dark:hover:bg-rose-950 transition-colors cursor-pointer"
                                  title={isAr ? 'حذف من القائمة' : 'Delete'}
                                >
                                  <X className="w-4 h-4" />
                                </button>
                              )}
                            </div>
                          </div>
                        );
                      })}
                    </div>
                  </div>
                )}

                {/* Scan & Bluetooth Actions */}
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-2 pt-2 border-t border-slate-100 dark:border-slate-700/60">
                  <button
                    type="button"
                    onClick={handleScanAndSave}
                    disabled={isScanning}
                    className="py-3 px-4 rounded-xl bg-teal-600 hover:bg-teal-700 active:scale-98 text-white font-black text-xs sm:text-sm shadow-md transition-all flex items-center justify-center gap-2 cursor-pointer disabled:opacity-50"
                  >
                    {isScanning ? (
                      <RefreshCw className="w-4 h-4 animate-spin" />
                    ) : (
                      <Bluetooth className="w-4 h-4" />
                    )}
                    <span>
                      {isScanning
                        ? (isAr ? 'جاري فحص وبحث البلوتوث...' : 'Scanning...')
                        : (isAr ? '🔍 البحث عن طابعة البلوتوث' : 'Search for Bluetooth')}
                    </span>
                  </button>

                  <button
                    type="button"
                    onClick={handleOpenPhoneBluetooth}
                    className="py-3 px-4 rounded-xl bg-slate-100 dark:bg-slate-700 hover:bg-slate-200 dark:hover:bg-slate-600 active:scale-98 text-slate-800 dark:text-slate-100 font-black text-xs sm:text-sm border border-slate-300 dark:border-slate-600 transition-all flex items-center justify-center gap-2 cursor-pointer"
                  >
                    <Settings className="w-4 h-4 text-teal-600 dark:text-teal-400" />
                    <span>{isAr ? 'إعدادات بلوتوث الهاتف' : 'Phone BT Settings'}</span>
                  </button>
                </div>

                {/* Paired devices picker */}
                {showDevicePicker && pairedDevices && pairedDevices.length > 0 && (
                  <div className="p-4 bg-teal-50/90 dark:bg-slate-900/90 rounded-2xl border-2 border-teal-300 dark:border-teal-800 space-y-3">
                    <div className="flex items-center justify-between pb-2 border-b border-teal-200 dark:border-teal-800">
                      <span className="text-xs font-black text-teal-900 dark:text-teal-200 flex items-center gap-1.5">
                        <Bluetooth className="w-4 h-4 text-teal-600" />
                        {isAr ? 'الأجهزة المتاحة (اضغط للاختيار):' : 'Available Devices:'}
                      </span>
                      <button
                        type="button"
                        onClick={() => setShowDevicePicker(false)}
                        className="text-[11px] font-bold text-slate-500 hover:text-slate-800 dark:text-slate-400 dark:hover:text-slate-200 cursor-pointer"
                      >
                        {isAr ? 'إغلاق' : 'Close'}
                      </button>
                    </div>

                    <div className="space-y-2 max-h-52 overflow-y-auto">
                      {pairedDevices.map((dev, idx) => {
                        const devMac = dev.address || dev.id || '';
                        const isSelected =
                          config.deviceId === devMac ||
                          (config.deviceName && dev.name && config.deviceName.toLowerCase() === dev.name.toLowerCase());

                        return (
                          <button
                            key={devMac || idx}
                            type="button"
                            onClick={() => handleSelectDevice(dev)}
                            className={`w-full p-3 rounded-xl border transition-all text-right flex items-center justify-between cursor-pointer ${
                              isSelected
                                ? 'bg-teal-600 text-white border-teal-700 shadow-sm'
                                : 'bg-white dark:bg-slate-800 text-slate-800 dark:text-slate-200 border-slate-200 dark:border-slate-700 hover:border-teal-500'
                            }`}
                          >
                            <div className="flex items-center gap-2.5">
                              <Printer className={`w-4 h-4 shrink-0 ${isSelected ? 'text-white' : 'text-teal-600'}`} />
                              <div>
                                <div className="text-xs font-black">{dev.name || 'طابعة البلوتوث'}</div>
                                {devMac && (
                                  <div className={`text-[10px] font-mono dir-ltr text-right ${isSelected ? 'text-teal-100' : 'text-slate-400'}`}>
                                    MAC: {devMac}
                                  </div>
                                )}
                              </div>
                            </div>

                            {isSelected ? (
                              <span className="text-[10px] font-extrabold px-2 py-0.5 rounded-lg bg-white/20 text-white flex items-center gap-1">
                                <CheckCircle2 className="w-3 h-3" />
                                {isAr ? 'معتمدة' : 'Active'}
                              </span>
                            ) : (
                              <span className="text-[11px] font-extrabold text-teal-600 dark:text-teal-400">
                                {isAr ? 'تغيير واعتماد' : 'Select'}
                              </span>
                            )}
                          </button>
                        );
                      })}
                    </div>
                  </div>
                )}

                {/* Test Print Button */}
                <button
                  type="button"
                  onClick={handleTestPrint}
                  disabled={isTesting}
                  className="w-full py-3 px-4 rounded-xl bg-teal-600 hover:bg-teal-700 active:scale-98 text-white font-black text-xs sm:text-sm shadow-sm transition-all flex items-center justify-center gap-2 cursor-pointer disabled:opacity-50"
                >
                  {isTesting ? <RefreshCw className="w-4 h-4 animate-spin" /> : <Printer className="w-4 h-4" />}
                  <span>{isAr ? '⚡ اختبار طباعة وصل تجريبي الآن' : 'Test Print Receipt Now'}</span>
                </button>
              </div>
            </div>
          )}

          {/* TAB 2: CLOUD SYNC & DATABASE */}
          {activeTab === 'sync' && (
            <div className="space-y-4 animate-in fade-in duration-200">
              {/* Cloud Database Connection Status */}
              <div className="p-4 bg-white dark:bg-slate-800 rounded-2xl border border-slate-200 dark:border-slate-700/80 shadow-xs space-y-3.5">
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-3">
                    <div className="p-2.5 bg-emerald-100 dark:bg-emerald-950 text-emerald-700 dark:text-emerald-300 rounded-2xl border border-emerald-200 dark:border-emerald-800">
                      <Database className="w-5 h-5" />
                    </div>
                    <div>
                      <h3 className="text-sm sm:text-base font-black text-slate-900 dark:text-slate-100">
                        {isAr ? 'قاعدة البيانات السحابية الحية (PostgreSQL)' : 'Live Cloud Database (PostgreSQL)'}
                      </h3>
                      <p className="text-[11px] font-bold text-slate-500 dark:text-slate-400">
                        {isAr ? 'مزامنة حية فورية ومطابقة لكافة الجداول والقيود' : 'Live instantaneous sync across all device ledgers'}
                      </p>
                    </div>
                  </div>

                  <button
                    type="button"
                    onClick={handleTestServerConnection}
                    disabled={isTestingServer}
                    className="px-3 py-2 rounded-xl bg-emerald-600 hover:bg-emerald-700 active:scale-95 text-white text-xs font-black flex items-center gap-1.5 cursor-pointer transition-all shadow-xs disabled:opacity-50"
                  >
                    {isTestingServer ? <RefreshCw className="w-3.5 h-3.5 animate-spin" /> : <Globe className="w-3.5 h-3.5" />}
                    <span>{isAr ? 'فحص الاتصال' : 'Check Sync'}</span>
                  </button>
                </div>

                {serverHealth && (
                  <div className={`p-3 rounded-xl text-xs font-bold flex items-center gap-2.5 ${
                    serverHealth.ok
                      ? 'bg-emerald-50 text-emerald-800 border border-emerald-200 dark:bg-emerald-950/60 dark:text-emerald-300 dark:border-emerald-800'
                      : 'bg-rose-50 text-rose-800 border border-rose-200 dark:bg-rose-950/60 dark:text-rose-300 dark:border-rose-800'
                  }`}>
                    {serverHealth.ok ? <CheckCircle2 className="w-4 h-4 text-emerald-600 shrink-0" /> : <AlertCircle className="w-4 h-4 text-rose-600 shrink-0" />}
                    <span>{serverHealth.message}</span>
                  </div>
                )}

                {/* Reconcile Action Card */}
                <div className="pt-3 border-t border-slate-100 dark:border-slate-700/60 space-y-2.5">
                  <div className="flex items-center justify-between">
                    <div>
                      <span className="text-xs font-black text-slate-800 dark:text-slate-200 block">
                        {isAr ? 'مطابقة ومزامنة شاملة لكل البيانات:' : 'Full Database Audit & Reconcile:'}
                      </span>
                      <span className="text-[10px] text-slate-500 dark:text-slate-400 font-bold block">
                        {isAr ? 'رفع وحفظ أية قيود أوفلاين معلقة ومطابقتها مع السيرفر' : 'Flush pending offline queue and reconcile with server'}
                      </span>
                    </div>

                    <button
                      type="button"
                      onClick={handleRunReconciliation}
                      disabled={isReconciling}
                      className="px-4 py-2 rounded-xl bg-teal-600 hover:bg-teal-700 active:scale-95 text-white text-xs font-black flex items-center gap-1.5 cursor-pointer transition-all shadow-xs disabled:opacity-50"
                    >
                      {isReconciling ? <RefreshCw className="w-3.5 h-3.5 animate-spin" /> : <RefreshCw className="w-3.5 h-3.5" />}
                      <span>{isAr ? 'تشغيل المطابقة والمزامنة' : 'Run Audit'}</span>
                    </button>
                  </div>

                  {reconcileResult && (
                    <div className={`p-3 rounded-xl text-xs font-medium ${
                      reconcileResult.success
                        ? 'bg-emerald-50 dark:bg-emerald-950/60 text-emerald-800 dark:text-emerald-300 border border-emerald-200 dark:border-emerald-800'
                        : 'bg-rose-50 dark:bg-rose-950/60 text-rose-800 dark:text-rose-300 border border-rose-200 dark:border-rose-800'
                    }`}>
                      <p className="font-bold">{reconcileResult.message}</p>
                      {reconcileResult.count !== undefined && reconcileResult.count > 0 && (
                        <p className="text-[11px] mt-0.5 opacity-90">
                          {isAr ? `تم إدراج ومزامنة ${reconcileResult.count} سجل جديد` : `Reconciled ${reconcileResult.count} records`}
                        </p>
                      )}
                    </div>
                  )}
                </div>

                {/* Admin Direct Server Queries */}
                {((currentRep ? currentRep.role === 'admin' : true) || isAdmin) && onOpenServerQueries && (
                  <div className="pt-3 border-t border-slate-100 dark:border-slate-700/60">
                    <div className="p-3.5 rounded-2xl bg-gradient-to-r from-emerald-900/10 via-teal-900/10 to-indigo-900/10 border border-emerald-300 dark:border-emerald-800 flex flex-col sm:flex-row sm:items-center justify-between gap-3 shadow-2xs">
                      <div className="flex items-center gap-2.5 min-w-0">
                        <div className="p-2 rounded-xl bg-emerald-600 text-white shadow-xs shrink-0">
                          <Database className="w-4 h-4 animate-pulse" />
                        </div>
                        <div className="min-w-0">
                          <div className="flex items-center gap-1.5">
                            <span className="text-xs font-black text-slate-900 dark:text-slate-100">
                              {isAr ? 'استعلامات السيرفر المباشرة' : 'Direct Server Queries'}
                            </span>
                            <span className="text-[9px] font-black bg-emerald-100 dark:bg-emerald-950 text-emerald-800 dark:text-emerald-300 px-2 py-0.5 rounded-full border border-emerald-300 dark:border-emerald-700">
                              {isAr ? 'خاص بالمدير' : 'Admin'}
                            </span>
                          </div>
                          <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400 mt-0.5">
                            {isAr ? 'استعراض الحسابات والمجاميع الحية من داتابيز السيرفر' : 'Inspect live server DB tables'}
                          </p>
                        </div>
                      </div>
                      <button
                        type="button"
                        onClick={() => {
                          onClose();
                          onOpenServerQueries();
                        }}
                        className="px-4 py-2 rounded-xl bg-emerald-600 hover:bg-emerald-700 active:scale-95 text-white text-xs font-black inline-flex items-center justify-center gap-1.5 shadow-xs cursor-pointer transition-all"
                      >
                        <Database className="w-3.5 h-3.5" />
                        <span>{isAr ? 'فتح الاستعلامات' : 'Open Queries'}</span>
                      </button>
                    </div>
                  </div>
                )}
              </div>
            </div>
          )}

          {/* TAB 3: FIELD WORK & ANDROID PERMISSIONS */}
          {activeTab === 'android' && (
            <div className="space-y-4 animate-in fade-in duration-200">
              {/* Keep-Alive Card */}
              <div className="p-4 bg-white dark:bg-slate-800 rounded-2xl border border-slate-200 dark:border-slate-700/80 shadow-xs space-y-3.5">
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-3">
                    <div className="p-2.5 bg-indigo-100 dark:bg-indigo-950 text-indigo-700 dark:text-indigo-300 rounded-2xl border border-indigo-200 dark:border-indigo-800">
                      <Zap className="w-5 h-5" />
                    </div>
                    <div>
                      <h3 className="text-sm sm:text-base font-black text-slate-900 dark:text-slate-100">
                        {isAr ? 'وضع العمل الميداني المستمر (مانع النوم)' : 'Field Work Keep-Alive Mode'}
                      </h3>
                      <p className="text-[11px] font-bold text-slate-500 dark:text-slate-400">
                        {isAr ? 'إبقاء الشاشة حية ومنع توقف المزامنة أثناء جولات المندوبين' : 'Prevents display sleep & background throttling'}
                      </p>
                    </div>
                  </div>

                  <button
                    type="button"
                    onClick={handleToggleKeepAlive}
                    disabled={isTogglingKeepAlive}
                    className={`px-3.5 py-1.5 rounded-xl text-xs font-black flex items-center gap-1.5 cursor-pointer transition-all shadow-xs ${
                      isKeepAliveOn
                        ? 'bg-amber-500 hover:bg-amber-600 text-white'
                        : 'bg-slate-100 dark:bg-slate-700 text-slate-700 dark:text-slate-300 hover:bg-slate-200'
                    }`}
                  >
                    {isKeepAliveOn ? <Zap className="w-3.5 h-3.5 fill-current" /> : <Power className="w-3.5 h-3.5" />}
                    <span>{isKeepAliveOn ? (isAr ? 'مفعل' : 'Active') : (isAr ? 'تفعيل' : 'Enable')}</span>
                  </button>
                </div>

                {/* All Permissions Action Card */}
                <div className="pt-3 border-t border-slate-100 dark:border-slate-700/60 space-y-3">
                  <div className="flex items-center justify-between">
                    <div>
                      <span className="text-xs font-black text-slate-800 dark:text-slate-200 block">
                        {isAr ? 'تفعيل ومنح كافة الصلاحيات بضغطة واحدة:' : 'Grant All Android Permissions:'}
                      </span>
                      <span className="text-[10px] text-slate-500 dark:text-slate-400 font-bold block">
                        {isAr ? 'البلوتوث، المزامنة، والإشعارات الميدانية' : 'Bluetooth, storage, background sync'}
                      </span>
                    </div>

                    <button
                      type="button"
                      onClick={handleRequestAllPermissions}
                      disabled={isRequestingPerms}
                      className="px-4 py-2 rounded-xl bg-indigo-600 hover:bg-indigo-700 active:scale-95 text-white text-xs font-black flex items-center gap-1.5 cursor-pointer transition-all shadow-xs disabled:opacity-50"
                    >
                      {isRequestingPerms ? <RefreshCw className="w-3.5 h-3.5 animate-spin" /> : <ShieldCheck className="w-3.5 h-3.5" />}
                      <span>{isAr ? 'تفعيل الصلاحيات' : 'Grant All'}</span>
                    </button>
                  </div>

                  <div className="grid grid-cols-1 sm:grid-cols-3 gap-2">
                    <button
                      type="button"
                      onClick={openBatteryOptimizationSettings}
                      className="p-2.5 rounded-xl bg-slate-50 dark:bg-slate-900/60 border border-slate-200 dark:border-slate-700 text-xs font-bold text-slate-700 dark:text-slate-300 hover:border-indigo-400 flex items-center justify-center gap-2 cursor-pointer transition-all"
                    >
                      <Zap className="w-4 h-4 text-amber-500 shrink-0" />
                      <span>{isAr ? 'استثناء البطارية' : 'No Saver'}</span>
                    </button>

                    <button
                      type="button"
                      onClick={openAutoStartSettings}
                      className="p-2.5 rounded-xl bg-slate-50 dark:bg-slate-900/60 border border-slate-200 dark:border-slate-700 text-xs font-bold text-slate-700 dark:text-slate-300 hover:border-indigo-400 flex items-center justify-center gap-2 cursor-pointer transition-all"
                    >
                      <Power className="w-4 h-4 text-emerald-500 shrink-0" />
                      <span>{isAr ? 'التشغيل التلقائي' : 'Auto-Start'}</span>
                    </button>

                    <button
                      type="button"
                      onClick={requestDisplayOverAppsPermission}
                      className="p-2.5 rounded-xl bg-slate-50 dark:bg-slate-900/60 border border-slate-200 dark:border-slate-700 text-xs font-bold text-slate-700 dark:text-slate-300 hover:border-indigo-400 flex items-center justify-center gap-2 cursor-pointer transition-all"
                    >
                      <ExternalLink className="w-4 h-4 text-blue-500 shrink-0" />
                      <span>{isAr ? 'الظهور بالأعلى' : 'Overlay'}</span>
                    </button>
                  </div>
                </div>
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

