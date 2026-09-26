import React, { useState, useEffect } from 'react';
import { motion, AnimatePresence } from 'motion/react';
import { Language } from '../types';

interface SplashScreenProps {
  onComplete: () => void;
  lang?: Language;
  forceShow?: boolean;
}

export const SplashScreen: React.FC<SplashScreenProps> = ({
  onComplete,
  lang = 'ar',
  forceShow = false,
}) => {
  const isAr = lang === 'ar';
  const [progress, setProgress] = useState(0);
  const [statusText, setStatusText] = useState(
    isAr ? 'جاري تهيئة النظام المالي...' : 'Initializing financial system...'
  );
  const [isClosing, setIsClosing] = useState(false);

  useEffect(() => {
    if (!forceShow) {
      try {
        const hasShown = sessionStorage.getItem('sami_splash_shown_v2');
        if (hasShown === 'true') {
          onComplete();
          return;
        }
      } catch (e) {
        // ignore
      }
    }

    const interval = setInterval(() => {
      setProgress((prev) => {
        const next = prev + Math.floor(Math.random() * 18) + 12;
        if (next >= 100) {
          clearInterval(interval);
          setStatusText(isAr ? 'مرحباً بكم في نظام الكرار' : 'Welcome to Al-Karrar');
          setTimeout(() => {
            handleDismiss();
          }, 400);
          return 100;
        }
        if (next > 65) {
          setStatusText(isAr ? 'التحقق من الاتصال والمزامنة الحية...' : 'Verifying sync and live connection...');
        } else if (next > 30) {
          setStatusText(isAr ? 'تحميل المحافظ وصناديق الأقساط...' : 'Loading installment funds & ledger...');
        }
        return next;
      });
    }, 150);

    return () => clearInterval(interval);
  }, [forceShow]);

  const handleDismiss = () => {
    setIsClosing(true);
    try {
      sessionStorage.setItem('sami_splash_shown_v2', 'true');
    } catch (e) {}
    setTimeout(() => {
      onComplete();
    }, 350);
  };

  return (
    <AnimatePresence>
      {!isClosing && (
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          exit={{ opacity: 0 }}
          transition={{ duration: 0.4, ease: 'easeInOut' }}
          onClick={handleDismiss}
          className="fixed inset-0 z-[9999] flex flex-col items-center justify-end bg-slate-950 text-slate-100 overflow-hidden select-none dir-rtl cursor-pointer"
        >
          {/* Background Gradient */}
          <div className="absolute inset-0 w-full h-full overflow-hidden bg-gradient-to-br from-slate-950 via-slate-900 to-indigo-950 flex items-center justify-center">
            {/* Ambient glows */}
            <div className="absolute top-1/4 -right-20 w-96 h-96 bg-emerald-500/10 rounded-full blur-3xl pointer-events-none" />
            <div className="absolute bottom-1/4 -left-20 w-96 h-96 bg-cyan-500/10 rounded-full blur-3xl pointer-events-none" />
          </div>

          {/* Bottom Content Area */}
          <div className="relative z-10 w-full max-w-xl px-6 pb-12 pt-8 flex flex-col items-center text-center">
            {/* Title */}
            <motion.h1
              initial={{ y: 20, opacity: 0 }}
              animate={{ y: 0, opacity: 1 }}
              transition={{ delay: 0.1, duration: 0.4 }}
              className="text-2xl sm:text-3xl font-black text-white tracking-wide mb-2 drop-shadow-md"
            >
              {isAr ? 'الكرار للتقسيط للموبايل' : 'Al-Karrar Installment'}
            </motion.h1>

            <motion.p
              initial={{ y: 15, opacity: 0 }}
              animate={{ y: 0, opacity: 1 }}
              transition={{ delay: 0.2, duration: 0.4 }}
              className="text-xs sm:text-sm font-bold text-teal-300 mb-6 tracking-wider uppercase drop-shadow"
            >
              Taqseetak Financial Solutions
            </motion.p>

            {/* Loading Bar & Progress */}
            <motion.div
              initial={{ y: 10, opacity: 0 }}
              animate={{ y: 0, opacity: 1 }}
              transition={{ delay: 0.3, duration: 0.4 }}
              className="w-full max-w-md space-y-2 mb-6"
            >
              <div className="flex items-center justify-between text-xs text-slate-300 font-bold px-1">
                <span className="truncate">{statusText}</span>
                <span className="text-teal-400 font-mono font-black">{Math.min(100, progress)}%</span>
              </div>
              <div className="h-2 w-full bg-slate-900/80 rounded-full overflow-hidden p-0.5 border border-white/20 shadow-inner backdrop-blur-md">
                <motion.div
                  className="h-full bg-gradient-to-r from-teal-500 via-emerald-400 to-cyan-400 rounded-full shadow-lg"
                  style={{ width: `${Math.min(100, progress)}%` }}
                  transition={{ ease: 'easeOut', duration: 0.2 }}
                />
              </div>
            </motion.div>

            {/* Skip / Tap to Enter Hint */}
            <motion.span
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ delay: 0.4, duration: 0.4 }}
              className="text-[11px] text-slate-400 font-medium tracking-wide animate-pulse"
            >
              {isAr ? 'انقر في أي مكان للمتابعة...' : 'Tap anywhere to continue...'}
            </motion.span>
          </div>
        </motion.div>
      )}
    </AnimatePresence>
  );
};
