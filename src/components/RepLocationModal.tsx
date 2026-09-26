import React, { useState, useEffect } from 'react';
import { X, MapPin, Navigation, RefreshCw, CheckCircle, ExternalLink, Globe } from 'lucide-react';
import { SalesRepresentative, Language } from '../types';

interface RepLocationModalProps {
  isOpen: boolean;
  onClose: () => void;
  rep: SalesRepresentative | null;
  onUpdateRep: (rep: SalesRepresentative) => Promise<void>;
  lang?: Language;
}

export const RepLocationModal: React.FC<RepLocationModalProps> = ({
  isOpen,
  onClose,
  rep,
  onUpdateRep,
  lang = 'ar',
}) => {
  const isAr = lang === 'ar';
  const [lat, setLat] = useState<number | undefined>(rep?.latitude);
  const [lng, setLng] = useState<number | undefined>(rep?.longitude);
  const [address, setAddress] = useState<string>(rep?.address || '');
  const [isGettingGps, setIsGettingGps] = useState(false);
  const [isSaving, setIsSaving] = useState(false);
  const [statusMsg, setStatusMsg] = useState<string | null>(null);
  const [errorMsg, setErrorMsg] = useState<string | null>(null);

  useEffect(() => {
    if (rep) {
      setLat(rep.latitude);
      setLng(rep.longitude);
      setAddress(rep.address || '');
      setStatusMsg(null);
      setErrorMsg(null);
    }
  }, [rep, isOpen]);

  if (!isOpen || !rep) return null;

  const handleGetGpsLocation = () => {
    if (!navigator.geolocation) {
      setErrorMsg(isAr ? 'متصفحك أو جهازك لا يدعم خاصية الـ GPS' : 'Geolocation is not supported');
      return;
    }
    setIsGettingGps(true);
    setErrorMsg(null);
    setStatusMsg(null);

    navigator.geolocation.getCurrentPosition(
      async (position) => {
        const latitude = position.coords.latitude;
        const longitude = position.coords.longitude;
        setLat(latitude);
        setLng(longitude);
        setIsGettingGps(false);
        setStatusMsg(isAr ? 'تم تحديد إحداثيات الـ GPS بنجاح!' : 'GPS coordinates retrieved!');

        // Try reverse geocoding via Google Maps API
        try {
          const res = await fetch(
            `https://maps.googleapis.com/maps/api/geocode/json?latlng=${latitude},${longitude}&language=ar`
          );
          if (res.ok) {
            const data = await res.json();
            if (data.results && data.results[0]) {
              setAddress(data.results[0].formatted_address);
            }
          }
        } catch (e) {
          // ignore network geocode fallback
        }
      },
      (err) => {
        setIsGettingGps(false);
        setErrorMsg(isAr ? 'فشل جلب الموقع الجغرافي. يرجى تفعيل الـ GPS في جهازك' : 'Failed to retrieve GPS location');
      },
      { enableHighAccuracy: true, timeout: 12000 }
    );
  };

  const handleSaveLocation = async () => {
    setIsSaving(true);
    setErrorMsg(null);
    try {
      const updatedRep: SalesRepresentative = {
        ...rep,
        latitude: lat,
        longitude: lng,
        address: address.trim(),
        locationUpdatedAt: new Date().toISOString(),
      };
      await onUpdateRep(updatedRep);
      setIsSaving(false);
      setStatusMsg(isAr ? 'تم حفظ موقع المندوب بنجاح!' : 'Location saved successfully!');
      setTimeout(() => {
        onClose();
      }, 800);
    } catch (err) {
      setIsSaving(false);
      setErrorMsg(isAr ? 'حدث خطأ أثناء حفظ الموقع' : 'Error saving location');
    }
  };

  const googleMapsUrl = lat && lng ? `https://www.google.com/maps/search/?api=1&query=${lat},${lng}` : null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-3 bg-slate-950/80 backdrop-blur-md animate-in fade-in duration-200 dir-rtl">
      <div className="bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-3xl shadow-2xl w-full max-w-lg overflow-hidden flex flex-col max-h-[92vh]">
        {/* Header */}
        <div className="px-5 py-4 bg-gradient-to-r from-teal-600 to-indigo-600 text-white flex items-center justify-between shadow-md">
          <div className="flex items-center gap-3">
            <div className="p-2 rounded-2xl bg-white/10 backdrop-blur-md border border-white/20">
              <MapPin className="w-6 h-6 text-teal-200" />
            </div>
            <div>
              <h3 className="font-black text-base leading-tight">
                {isAr ? `الموقع الجغرافي للمندوب: ${rep.name}` : `Location: ${rep.name}`}
              </h3>
              <p className="text-[11px] text-teal-100 font-medium">
                {isAr ? 'تحديد وتتبع موقع المندوب على الخريطة' : 'Set and view representative location'}
              </p>
            </div>
          </div>
          <button
            onClick={onClose}
            className="p-2 rounded-xl bg-white/10 hover:bg-white/20 text-white transition-all cursor-pointer"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Content */}
        <div className="p-5 overflow-y-auto space-y-4">
          {/* Status / Error Notifications */}
          {statusMsg && (
            <div className="p-3 rounded-2xl bg-teal-50 dark:bg-teal-950/60 border border-teal-200 dark:border-teal-800 text-teal-800 dark:text-teal-200 text-xs font-bold flex items-center gap-2">
              <CheckCircle className="w-4 h-4 text-teal-600 shrink-0" />
              <span>{statusMsg}</span>
            </div>
          )}
          {errorMsg && (
            <div className="p-3 rounded-2xl bg-rose-50 dark:bg-rose-950/60 border border-rose-200 dark:border-rose-800 text-rose-800 dark:text-rose-200 text-xs font-bold flex items-center gap-2">
              <X className="w-4 h-4 text-rose-600 shrink-0" />
              <span>{errorMsg}</span>
            </div>
          )}

          {/* Quick GPS Grabber */}
          <div className="p-4 rounded-2xl bg-slate-50 dark:bg-slate-800/50 border border-slate-200 dark:border-slate-700/70 flex flex-col sm:flex-row items-center justify-between gap-3">
            <div>
              <h4 className="font-black text-xs text-slate-800 dark:text-slate-100 flex items-center gap-1.5">
                <Navigation className="w-4 h-4 text-indigo-600 dark:text-indigo-400" />
                <span>{isAr ? 'التقاط الإحداثيات الحالية عبر GPS' : 'Get Current GPS Location'}</span>
              </h4>
              <p className="text-[10px] text-slate-500 dark:text-slate-400 mt-0.5">
                {isAr ? 'يجلب موقع الجهاز بدقة متناهية فورياً' : 'Retrieves exact device coordinates'}
              </p>
            </div>
            <button
              type="button"
              onClick={handleGetGpsLocation}
              disabled={isGettingGps}
              className="w-full sm:w-auto px-4 py-2.5 rounded-xl bg-indigo-600 hover:bg-indigo-700 text-white text-xs font-black flex items-center justify-center gap-2 shadow-md transition-all active:scale-95 disabled:opacity-50 cursor-pointer shrink-0"
            >
              {isGettingGps ? (
                <>
                  <RefreshCw className="w-4 h-4 animate-spin" />
                  <span>{isAr ? 'جاري التحديد...' : 'Retrieving...'}</span>
                </>
              ) : (
                <>
                  <MapPin className="w-4 h-4" />
                  <span>{isAr ? '📍 تحديث موقعي الحالي' : 'Get GPS Location'}</span>
                </>
              )}
            </button>
          </div>

          {/* Address Note Input */}
          <div>
            <label className="block font-bold text-slate-700 dark:text-slate-300 mb-1 text-xs">
              {isAr ? 'اسم المنطقة / العنوان / الملاحظة الجغرافية' : 'Address / Note'}
            </label>
            <input
              type="text"
              value={address}
              onChange={(e) => setAddress(e.target.value)}
              placeholder={isAr ? 'مثال: بغداد، الكرادة، قرب الساحة الرئيسية' : 'e.g. Baghdad, Karada'}
              className="w-full px-3.5 py-2.5 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-900 text-xs font-bold text-slate-900 dark:text-slate-100 focus:ring-2 focus:ring-teal-500"
            />
          </div>

          {/* Lat & Long manual inputs */}
          <div className="grid grid-cols-2 gap-3">
            <div>
              <label className="block font-bold text-slate-600 dark:text-slate-400 mb-1 text-[11px]">
                {isAr ? 'خط العرض (Latitude)' : 'Latitude'}
              </label>
              <input
                type="number"
                step="any"
                value={lat !== undefined ? lat : ''}
                onChange={(e) => setLat(e.target.value ? parseFloat(e.target.value) : undefined)}
                placeholder="33.315"
                className="w-full px-3 py-2 rounded-xl border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-900 text-xs font-mono dir-ltr text-right font-bold"
              />
            </div>
            <div>
              <label className="block font-bold text-slate-600 dark:text-slate-400 mb-1 text-[11px]">
                {isAr ? 'خط الطول (Longitude)' : 'Longitude'}
              </label>
              <input
                type="number"
                step="any"
                value={lng !== undefined ? lng : ''}
                onChange={(e) => setLng(e.target.value ? parseFloat(e.target.value) : undefined)}
                placeholder="44.361"
                className="w-full px-3 py-2 rounded-xl border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-900 text-xs font-mono dir-ltr text-right font-bold"
              />
            </div>
          </div>

          {/* Interactive Map Link / Preview */}
          {lat !== undefined && lng !== undefined ? (
            <div className="p-3 rounded-2xl bg-teal-50/60 dark:bg-teal-950/40 border border-teal-200/80 dark:border-teal-800/80 space-y-2">
              <div className="flex items-center justify-between">
                <span className="text-xs font-black text-teal-900 dark:text-teal-200 flex items-center gap-1">
                  <Globe className="w-3.5 h-3.5 text-teal-600" />
                  {isAr ? 'الخريطة جاهزة للتصفح' : 'Map Ready'}
                </span>
                {googleMapsUrl && (
                  <a
                    href={googleMapsUrl}
                    target="_blank"
                    rel="noreferrer"
                    className="px-3 py-1.5 rounded-xl bg-teal-600 hover:bg-teal-700 text-white text-[11px] font-black flex items-center gap-1 shadow-xs transition-all"
                  >
                    <span>{isAr ? 'فتح في خرائط جوجل' : 'Open in Google Maps'}</span>
                    <ExternalLink className="w-3 h-3" />
                  </a>
                )}
              </div>
              <div className="rounded-xl overflow-hidden border border-teal-200 dark:border-teal-800/60 h-44 relative bg-slate-100 dark:bg-slate-800">
                <iframe
                  title="Representative Map"
                  src={`https://www.google.com/maps/embed/v1/place?key=AIzaSyBRW3e45-1MK7jySdSQChQOm31enB5p8Wc&q=${lat},${lng}&zoom=15&language=ar`}
                  className="w-full h-full border-0"
                  allowFullScreen
                  loading="lazy"
                  referrerPolicy="no-referrer-when-downgrade"
                ></iframe>
              </div>
            </div>
          ) : (
            <div className="p-6 rounded-2xl border border-dashed border-slate-300 dark:border-slate-700 text-center space-y-1">
              <MapPin className="w-8 h-8 text-slate-400 mx-auto" />
              <p className="text-xs font-bold text-slate-500">
                {isAr ? 'لم يتم تحديد موقع المندوب بعد' : 'No location set yet'}
              </p>
              <p className="text-[10px] text-slate-400">
                {isAr ? 'اضغط زر "تحديث موقعي الحالي" لالتقاط الإحداثيات فورياً' : 'Click "Get GPS Location" to capture coordinates'}
              </p>
            </div>
          )}
        </div>

        {/* Footer Actions */}
        <div className="p-4 bg-slate-50 dark:bg-slate-900 border-t border-slate-200 dark:border-slate-800 flex items-center justify-end gap-2">
          <button
            type="button"
            onClick={onClose}
            className="px-4 py-2.5 rounded-xl bg-slate-200 dark:bg-slate-800 hover:bg-slate-300 dark:hover:bg-slate-700 text-slate-800 dark:text-slate-200 text-xs font-black transition-all cursor-pointer"
          >
            {isAr ? 'إلغاء' : 'Cancel'}
          </button>
          <button
            type="button"
            onClick={handleSaveLocation}
            disabled={isSaving}
            className="px-5 py-2.5 rounded-xl bg-gradient-to-r from-teal-600 to-indigo-600 hover:from-teal-700 hover:to-indigo-700 text-white text-xs font-black shadow-md transition-all active:scale-95 disabled:opacity-50 cursor-pointer flex items-center gap-2"
          >
            {isSaving ? (
              <>
                <RefreshCw className="w-4 h-4 animate-spin" />
                <span>{isAr ? 'جاري الحفظ...' : 'Saving...'}</span>
              </>
            ) : (
              <>
                <CheckCircle className="w-4 h-4" />
                <span>{isAr ? 'حفظ موقع المندوب' : 'Save Location'}</span>
              </>
            )}
          </button>
        </div>
      </div>
    </div>
  );
};
