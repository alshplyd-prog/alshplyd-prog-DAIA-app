import React, { useState, useEffect } from 'react';
import {
  X,
  MapPin,
  Navigation,
  RefreshCw,
  CheckCircle2,
  AlertCircle,
  ExternalLink,
  User,
  Compass,
  Search,
  Copy
} from 'lucide-react';
import { SalesRepresentative, Language } from '../types';

const MAPS_API_KEY = 'AIzaSyBRW3e45-1MK7jySdSQChQOm31enB5p8Wc';

interface RepLocationModalProps {
  isOpen: boolean;
  onClose: () => void;
  rep: SalesRepresentative | null;
  onUpdateRep: (id: string, data: Partial<SalesRepresentative>) => Promise<void>;
  lang: Language;
}

export const RepLocationModal: React.FC<RepLocationModalProps> = ({
  isOpen,
  onClose,
  rep,
  onUpdateRep,
  lang,
}) => {
  const isAr = lang === 'ar';

  const [lat, setLat] = useState<number | null>(null);
  const [lng, setLng] = useState<number | null>(null);
  const [address, setAddress] = useState<string>('');
  const [isLocating, setIsLocating] = useState<boolean>(false);
  const [isSaving, setIsSaving] = useState<boolean>(false);
  const [statusMessage, setStatusMessage] = useState<{ text: string; type: 'success' | 'error' | 'info' } | null>(null);

  useEffect(() => {
    if (rep) {
      setLat(rep.latitude || 33.3152); // Default Baghdad lat if none
      setLng(rep.longitude || 44.3661); // Default Baghdad lng if none
      setAddress(rep.address || '');
    }
  }, [rep]);

  if (!isOpen || !rep) return null;

  // Get current GPS position from browser/device
  const handleGetGPSLocation = () => {
    if (!navigator.geolocation) {
      setStatusMessage({
        text: isAr ? 'خاصية التحديد الجغرافي غير مدعومة في هذا الجهاز' : 'Geolocation not supported',
        type: 'error',
      });
      return;
    }

    setIsLocating(true);
    setStatusMessage({
      text: isAr ? 'جاري تحديد موقعك الحالي بالدقة العالية عبر الـ GPS...' : 'Acquiring high-accuracy GPS coordinates...',
      type: 'info',
    });

    navigator.geolocation.getCurrentPosition(
      async (position) => {
        const currentLat = Number(position.coords.latitude.toFixed(6));
        const currentLng = Number(position.coords.longitude.toFixed(6));
        setLat(currentLat);
        setLng(currentLng);

        // Reverse geocoding attempt via Google Maps Geocoding API
        try {
          const res = await fetch(
            `https://maps.googleapis.com/maps/api/geocode/json?latlng=${currentLat},${currentLng}&key=${MAPS_API_KEY}&language=ar`
          );
          if (res.ok) {
            const data = await res.json();
            if (data.results && data.results[0]) {
              setAddress(data.results[0].formatted_address);
            }
          }
        } catch (e) {
          // ignore geocoding fallback
        }

        setIsLocating(false);
        setStatusMessage({
          text: isAr ? 'تم التقاط الموقع الحالي بنجاح! اضغط حفظ لاقتطاع الموقع.' : 'Current GPS location acquired successfully!',
          type: 'success',
        });
      },
      (err) => {
        setIsLocating(false);
        let errorMsg = isAr ? 'تعذر تحديد الموقع الجغرافي' : 'Failed to get location';
        if (err.code === err.PERMISSION_DENIED) {
          errorMsg = isAr ? 'يرجى السماح بصلاحية الموقع (GPS) في إعدادات الهاتف' : 'Location permission denied';
        } else if (err.code === err.POSITION_UNAVAILABLE) {
          errorMsg = isAr ? 'إشارة الـ GPS غير متوفرة حالياً' : 'GPS position unavailable';
        } else if (err.code === err.TIMEOUT) {
          errorMsg = isAr ? 'انتهت مهلة انتظار إشارة الـ GPS' : 'GPS request timed out';
        }
        setStatusMessage({ text: errorMsg, type: 'error' });
      },
      {
        enableHighAccuracy: true,
        timeout: 15000,
        maximumAge: 0,
      }
    );
  };

  // Save updated location
  const handleSaveLocation = async () => {
    if (lat === null || lng === null) {
      setStatusMessage({
        text: isAr ? 'يرجى تحديد إحداثيات الموقع أولاً' : 'Please specify location coordinates first',
        type: 'error',
      });
      return;
    }

    try {
      setIsSaving(true);
      await onUpdateRep(rep.id, {
        latitude: lat,
        longitude: lng,
        address: address || undefined,
        locationUpdatedAt: new Date().toISOString(),
      });

      setStatusMessage({
        text: isAr ? 'تم حفظ وتحديث موقع المندوب بنجاح' : 'Representative location updated successfully',
        type: 'success',
      });

      setTimeout(() => {
        onClose();
      }, 1000);
    } catch (e) {
      setStatusMessage({
        text: isAr ? 'حدث خطأ أثناء حفظ بيانات الموقع' : 'Failed to save location data',
        type: 'error',
      });
    } finally {
      setIsSaving(false);
    }
  };

  // Google Maps navigation link
  const navUrl = lat && lng ? `https://www.google.com/maps/dir/?api=1&destination=${lat},${lng}` : '#';
  const embedMapUrl = lat && lng
    ? `https://www.google.com/maps/embed/v1/place?key=${MAPS_API_KEY}&q=${lat},${lng}&zoom=15&language=ar`
    : '';

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-2 sm:p-4 bg-slate-950/80 backdrop-blur-md animate-in fade-in duration-200 dir-rtl">
      <div
        className="bg-white dark:bg-slate-900 rounded-3xl w-full max-w-2xl shadow-2xl border border-slate-200 dark:border-slate-800 overflow-hidden flex flex-col max-h-[92vh]"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header */}
        <div className="p-4 sm:p-5 bg-gradient-to-r from-teal-800 via-teal-700 to-emerald-800 text-white flex items-center justify-between shadow-md">
          <div className="flex items-center gap-3">
            <div className="relative">
              {rep.avatarUrl ? (
                <img
                  src={rep.avatarUrl}
                  alt={rep.name}
                  className="w-10 h-10 rounded-2xl object-cover border-2 border-white/40 shadow-sm"
                />
              ) : (
                <div className="w-10 h-10 rounded-2xl bg-white/15 border border-white/20 flex items-center justify-center font-black text-white text-base">
                  {rep.name.substring(0, 1)}
                </div>
              )}
              <div className="absolute -bottom-1 -right-1 p-1 bg-emerald-500 rounded-full border border-white">
                <MapPin className="w-2.5 h-2.5 text-white" />
              </div>
            </div>

            <div>
              <h2 className="text-base sm:text-lg font-black text-white tracking-wide">
                {isAr ? `موقع المندوب: ${rep.name}` : `Location: ${rep.name}`}
              </h2>
              <p className="text-xs text-teal-100 font-bold flex items-center gap-1.5">
                <span>{rep.phone || 'بدون رقم هاتف'}</span>
                {rep.locationUpdatedAt && (
                  <span className="opacity-80">
                    • {isAr ? 'آخر تحديث:' : 'Updated:'} {new Date(rep.locationUpdatedAt).toLocaleTimeString('ar-IQ', { hour: '2-digit', minute: '2-digit' })}
                  </span>
                )}
              </p>
            </div>
          </div>

          <button
            type="button"
            onClick={onClose}
            className="p-2 rounded-2xl text-white/80 hover:text-white hover:bg-white/15 transition-all cursor-pointer active:scale-95"
            title={isAr ? 'إغلاق' : 'Close'}
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Content Body */}
        <div className="p-4 sm:p-6 space-y-4 overflow-y-auto max-h-[calc(92vh-130px)]">
          {/* Alert Status Banner */}
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

          {/* Quick Action Buttons */}
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-2.5">
            <button
              type="button"
              onClick={handleGetGPSLocation}
              disabled={isLocating}
              className="py-3 px-4 rounded-2xl bg-teal-600 hover:bg-teal-700 active:scale-98 text-white font-black text-xs sm:text-sm shadow-md transition-all flex items-center justify-center gap-2 cursor-pointer disabled:opacity-50"
            >
              {isLocating ? (
                <RefreshCw className="w-4 h-4 animate-spin" />
              ) : (
                <Compass className="w-4 h-4" />
              )}
              <span>
                {isLocating
                  ? (isAr ? 'جاري تحديد الموقع بواسطة GPS...' : 'Locating...')
                  : (isAr ? '🎯 التقاط الموقع الحالي عبر GPS' : 'Capture Current GPS Location')}
              </span>
            </button>

            {lat && lng ? (
              <a
                href={navUrl}
                target="_blank"
                rel="noopener noreferrer"
                className="py-3 px-4 rounded-2xl bg-indigo-600 hover:bg-indigo-700 active:scale-98 text-white font-black text-xs sm:text-sm shadow-md transition-all flex items-center justify-center gap-2 cursor-pointer"
              >
                <Navigation className="w-4 h-4" />
                <span>{isAr ? 'التوجيه والمسار في خرائط جوجل' : 'Navigate in Google Maps'}</span>
                <ExternalLink className="w-3.5 h-3.5 opacity-80" />
              </a>
            ) : (
              <div className="py-3 px-4 rounded-2xl bg-slate-100 dark:bg-slate-800 text-slate-400 font-bold text-xs flex items-center justify-center gap-1.5">
                <MapPin className="w-4 h-4 opacity-50" />
                <span>{isAr ? 'الموقع غير محدد بعد' : 'No location specified'}</span>
              </div>
            )}
          </div>

          {/* Google Maps Viewport */}
          <div className="relative w-full h-64 sm:h-80 rounded-2xl overflow-hidden border border-slate-200 dark:border-slate-700 shadow-inner bg-slate-100 dark:bg-slate-800">
            {lat && lng ? (
              <iframe
                title="Google Maps Representative Location"
                width="100%"
                height="100%"
                style={{ border: 0 }}
                loading="lazy"
                allowFullScreen
                src={embedMapUrl}
              />
            ) : (
              <div className="absolute inset-0 flex flex-col items-center justify-center p-6 text-center text-slate-400">
                <MapPin className="w-12 h-12 text-slate-300 dark:text-slate-600 mb-2 animate-bounce" />
                <p className="text-sm font-black text-slate-600 dark:text-slate-300">
                  {isAr ? 'لا يوجد موقع مسجل لهذا المندوب' : 'No location recorded yet'}
                </p>
                <p className="text-xs text-slate-400 mt-1 max-w-xs">
                  {isAr ? 'اضغط على زر "التقاط الموقع الحالي عبر GPS" أو أدخل الإحداثيات يدوياً أدناه.' : 'Tap "Capture Current GPS Location" or enter coordinates below.'}
                </p>
              </div>
            )}
          </div>

          {/* Coordinates & Address Inputs */}
          <div className="p-4 bg-slate-50 dark:bg-slate-800/80 rounded-2xl border border-slate-200 dark:border-slate-700/80 space-y-3">
            <h3 className="text-xs font-black text-slate-800 dark:text-slate-200 flex items-center gap-1.5">
              <MapPin className="w-4 h-4 text-teal-600 dark:text-teal-400" />
              <span>{isAr ? 'تفاصيل وإحداثيات موقع المندوب' : 'Location Details & Coordinates'}</span>
            </h3>

            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
              <div>
                <label className="block text-[11px] font-black text-slate-600 dark:text-slate-400 mb-1">
                  {isAr ? 'خط العرض (Latitude):' : 'Latitude:'}
                </label>
                <input
                  type="number"
                  step="any"
                  value={lat !== null ? lat : ''}
                  onChange={(e) => setLat(e.target.value ? parseFloat(e.target.value) : null)}
                  placeholder="33.3152"
                  className="w-full px-3 py-2 rounded-xl border border-slate-300 dark:border-slate-600 bg-white dark:bg-slate-900 text-slate-900 dark:text-slate-100 text-xs font-mono font-bold focus:ring-2 focus:ring-teal-500 focus:outline-none"
                />
              </div>

              <div>
                <label className="block text-[11px] font-black text-slate-600 dark:text-slate-400 mb-1">
                  {isAr ? 'خط الطول (Longitude):' : 'Longitude:'}
                </label>
                <input
                  type="number"
                  step="any"
                  value={lng !== null ? lng : ''}
                  onChange={(e) => setLng(e.target.value ? parseFloat(e.target.value) : null)}
                  placeholder="44.3661"
                  className="w-full px-3 py-2 rounded-xl border border-slate-300 dark:border-slate-600 bg-white dark:bg-slate-900 text-slate-900 dark:text-slate-100 text-xs font-mono font-bold focus:ring-2 focus:ring-teal-500 focus:outline-none"
                />
              </div>
            </div>

            <div>
              <label className="block text-[11px] font-black text-slate-600 dark:text-slate-400 mb-1">
                {isAr ? 'العنوان / المنطقة الوصفية:' : 'Address Description:'}
              </label>
              <input
                type="text"
                value={address}
                onChange={(e) => setAddress(e.target.value)}
                placeholder={isAr ? 'مثال: بغداد - شارع فلسطين - قرب المجمع السكني' : 'e.g. Baghdad, District 4'}
                className="w-full px-3 py-2 rounded-xl border border-slate-300 dark:border-slate-600 bg-white dark:bg-slate-900 text-slate-900 dark:text-slate-100 text-xs font-bold focus:ring-2 focus:ring-teal-500 focus:outline-none"
              />
            </div>
          </div>
        </div>

        {/* Footer Actions */}
        <div className="p-4 bg-slate-50 dark:bg-slate-800/90 border-t border-slate-200 dark:border-slate-700 flex items-center justify-end gap-2.5">
          <button
            type="button"
            onClick={onClose}
            className="px-4 py-2.5 rounded-xl border border-slate-300 dark:border-slate-600 hover:bg-slate-200 dark:hover:bg-slate-700 text-slate-700 dark:text-slate-200 text-xs font-black cursor-pointer transition-all active:scale-95"
          >
            {isAr ? 'إلغاء' : 'Cancel'}
          </button>

          <button
            type="button"
            onClick={handleSaveLocation}
            disabled={isSaving}
            className="px-6 py-2.5 rounded-xl bg-teal-600 hover:bg-teal-700 active:scale-95 text-white text-xs font-black shadow-md cursor-pointer transition-all flex items-center gap-2 disabled:opacity-50"
          >
            {isSaving ? <RefreshCw className="w-4 h-4 animate-spin" /> : <CheckCircle2 className="w-4 h-4" />}
            <span>{isAr ? 'حفظ موقع المندوب' : 'Save Location'}</span>
          </button>
        </div>
      </div>
    </div>
  );
};
