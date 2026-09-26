/**
 * Returns a date string formatted as YYYY-MM-DD in the local device timezone using 'en-CA' locale.
 * Prevents UTC offset shifts (e.g. late night payments showing as previous day).
 */
export function getLocalDateString(input?: Date | string | number): string {
  if (!input) {
    return new Date().toLocaleDateString('en-CA');
  }
  if (typeof input === 'string') {
    const trimmed = input.trim();
    if (/^\d{4}-\d{2}-\d{2}$/.test(trimmed)) {
      return trimmed;
    }
  }
  const d = input instanceof Date ? input : new Date(input);
  if (isNaN(d.getTime())) {
    return new Date().toLocaleDateString('en-CA');
  }
  return d.toLocaleDateString('en-CA');
}

/**
 * Robustly checks if two date strings represent the same calendar day
 * regardless of formatting (e.g. '26/09/2026' vs '2026-09-26' vs '2026/09/26').
 */
export function isSameCalendarDate(date1Str?: string, date2Str?: string): boolean {
  if (!date1Str || !date2Str) return false;
  const clean1 = date1Str.trim();
  const clean2 = date2Str.trim();
  if (clean1 === clean2) return true;

  const toNormalizedIsoDay = (str: string) => {
    const parts = str.split(/[\/-]/);
    if (parts.length === 3) {
      if (parts[0].length === 4) {
        // YYYY-MM-DD or YYYY/MM/DD
        return `${parts[0]}-${parts[1].padStart(2, '0')}-${parts[2].padStart(2, '0')}`;
      } else if (parts[2].length === 4) {
        // DD-MM-YYYY or DD/MM/YYYY
        return `${parts[2]}-${parts[1].padStart(2, '0')}-${parts[0].padStart(2, '0')}`;
      }
    }
    return str;
  };

  return toNormalizedIsoDay(clean1) === toNormalizedIsoDay(clean2);
}

/**
 * Returns an ISO-like timestamp string adjusted for the device's local time zone
 * preventing UTC shift bugs (e.g. 3:00 AM offset issues).
 */
export function getLocalIsoString(date = new Date()): string {
  const d = date instanceof Date ? date : new Date(date);
  if (isNaN(d.getTime())) {
    return new Date().toISOString();
  }
  const offsetMs = d.getTimezoneOffset() * 60 * 1000;
  const localDate = new Date(d.getTime() - offsetMs);
  return localDate.toISOString();
}

/**
 * Formats a payment's date & time string accurately using the device/phone's local time.
 * Resolves the issue where Date("YYYY-MM-DD") parsed as UTC midnight turns into 3:00 AM (3:00 ص) in UTC+3.
 */
export function formatPaymentDateTime(
  paymentOrDate: { paymentDate?: string; createdAt?: string; updatedAt?: string } | string | Date | undefined | null,
  isAr = true
): string {
  if (!paymentOrDate) return '-';

  if (paymentOrDate instanceof Date) {
    if (isNaN(paymentOrDate.getTime())) return '-';
    const dStr = paymentOrDate.toLocaleDateString('en-US', {
      year: 'numeric',
      month: '2-digit',
      day: '2-digit',
    });
    const tStr = paymentOrDate.toLocaleTimeString('en-US', {
      hour: 'numeric',
      minute: '2-digit',
      hour12: true,
    });
    return `${dStr} ${tStr}`;
  }

  if (typeof paymentOrDate === 'string') {
    const trimmed = paymentOrDate.trim();
    if (/^\d{4}-\d{2}-\d{2}$/.test(trimmed)) {
      const parts = trimmed.split('-');
      return `${parts[0]}/${parts[1]}/${parts[2]}`;
    }
    const d = new Date(trimmed);
    if (!isNaN(d.getTime())) {
      const dStr = d.toLocaleDateString('en-US', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
      });
      const tStr = d.toLocaleTimeString('en-US', {
        hour: 'numeric',
        minute: '2-digit',
        hour12: true,
      });
      return `${dStr} ${tStr}`;
    }
    return trimmed;
  }

  // Object case: payment record
  const payDate = paymentOrDate.paymentDate;
  const created = paymentOrDate.createdAt;
  const updated = paymentOrDate.updatedAt;

  // Extract time portion (from createdAt / updatedAt / paymentDate)
  const timeStr = formatPaymentTime(paymentOrDate, isAr);

  // Extract date portion: paymentDate is the authoritative transaction date
  let datePartStr = '';
  if (payDate) {
    const trimmed = payDate.trim();
    const dateOnly = trimmed.split('T')[0].split(' ')[0];
    if (/^\d{4}-\d{2}-\d{2}$/.test(dateOnly)) {
      const parts = dateOnly.split('-');
      datePartStr = `${parts[0]}/${parts[1]}/${parts[2]}`;
    } else {
      const d = new Date(trimmed);
      if (!isNaN(d.getTime())) {
        datePartStr = d.toLocaleDateString('en-US', {
          year: 'numeric',
          month: '2-digit',
          day: '2-digit',
        });
      } else {
        datePartStr = dateOnly;
      }
    }
  } else if (created) {
    const d = new Date(created);
    if (!isNaN(d.getTime())) {
      datePartStr = d.toLocaleDateString('en-US', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
      });
    }
  } else if (updated) {
    const d = new Date(updated);
    if (!isNaN(d.getTime())) {
      datePartStr = d.toLocaleDateString('en-US', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
      });
    }
  }

  if (!datePartStr) {
    datePartStr = getLocalDateString();
  }

  if (timeStr) {
    return `${datePartStr} ${timeStr}`;
  }
  return datePartStr;
}

/**
 * Extracts and formats the time portion only from a payment or date record using mobile local time.
 */
export function formatPaymentTime(
  paymentOrDate: { paymentDate?: string; createdAt?: string; updatedAt?: string } | string | Date | undefined | null,
  isAr = true
): string {
  if (!paymentOrDate) return '';

  let dateObj: Date | null = null;
  if (typeof paymentOrDate === 'object' && !(paymentOrDate instanceof Date)) {
    if (paymentOrDate.createdAt) {
      const d = new Date(paymentOrDate.createdAt);
      if (!isNaN(d.getTime())) dateObj = d;
    }
    if (!dateObj && paymentOrDate.updatedAt) {
      const d = new Date(paymentOrDate.updatedAt);
      if (!isNaN(d.getTime())) dateObj = d;
    }
    if (!dateObj && paymentOrDate.paymentDate && (paymentOrDate.paymentDate.includes('T') || paymentOrDate.paymentDate.includes(':'))) {
      const d = new Date(paymentOrDate.paymentDate);
      if (!isNaN(d.getTime())) dateObj = d;
    }
  } else if (paymentOrDate instanceof Date) {
    dateObj = isNaN(paymentOrDate.getTime()) ? null : paymentOrDate;
  } else if (typeof paymentOrDate === 'string' && (paymentOrDate.includes('T') || paymentOrDate.includes(':'))) {
    const d = new Date(paymentOrDate);
    if (!isNaN(d.getTime())) dateObj = d;
  }

  if (dateObj) {
    return dateObj.toLocaleTimeString('en-US', {
      hour: '2-digit',
      minute: '2-digit',
      hour12: true,
    });
  }

  return '';
}

/**
 * Accurately extracts date string and time string for a payment using device local time.
 * Avoids the UTC-midnight to 3:00 AM timezone conversion issue.
 */
export function getPaymentFormattedDateAndTime(
  p: { paymentDate?: string; createdAt?: string; updatedAt?: string; note?: string } | undefined | null,
  isAr = true
): { dateStr: string; timeStr: string; cleanNote: string } {
  if (!p) {
    const now = new Date();
    return {
      dateStr: getLocalDateString(now),
      timeStr: now.toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit', hour12: true }),
      cleanNote: '',
    };
  }

  let timeStr = formatPaymentTime(p, isAr);
  let dateStr = '';

  if (p.paymentDate) {
    const pDateOnly = p.paymentDate.split('T')[0].split(' ')[0].trim();
    const parts = pDateOnly.split('-');
    if (parts.length === 3) {
      dateStr = `${parts[2]}/${parts[1]}/${parts[0]}`;
    } else {
      const d = new Date(p.paymentDate);
      if (!isNaN(d.getTime())) {
        dateStr = d.toLocaleDateString('en-US');
      } else {
        dateStr = pDateOnly;
      }
    }
  } else if (p.createdAt) {
    const d = new Date(p.createdAt);
    if (!isNaN(d.getTime())) {
      dateStr = d.toLocaleDateString('en-US');
    }
  }

  if (!dateStr) {
    dateStr = getLocalDateString();
  }

  let cleanNote = (p.note || '').trim();
  if (cleanNote === 'تسديد قسط يومي' || cleanNote === 'تسديد قسط' || cleanNote === 'قسط يومي' || cleanNote === 'Daily installment payment') {
    cleanNote = '';
  }

  return { dateStr, timeStr, cleanNote };
}

/**
 * Checks if a customer/contract has remaining balance of 0 (or status is completed)
 * and at least 24 hours (1 calendar day) have passed since that date.
 */
export function isZeroBalanceExpired24h(contract: {
  id?: string;
  remainingBalance?: number;
  status?: string;
  startDate?: string;
  createdAt?: string | number;
  completedAt?: string | number;
}): boolean {
  const isZero = (contract.remainingBalance ?? 0) <= 0 || contract.status === 'completed';
  if (!isZero) {
    if (typeof window !== 'undefined' && contract.id) {
      try {
        localStorage.removeItem(`zero_balance_completed_at_${contract.id}`);
      } catch {
        // ignore
      }
    }
    return false;
  }

  const expiryMs = getZeroBalanceExpiryMs(contract);
  return Date.now() > expiryMs;
}

/**
 * Returns the timestamp (ms) when a zero-balance contract expires (24h after completion timestamp).
 */
export function getZeroBalanceExpiryMs(contract: {
  id?: string;
  remainingBalance?: number;
  status?: string;
  startDate?: string;
  createdAt?: string | number;
  completedAt?: string | number;
}): number {
  const isZero = (contract.remainingBalance ?? 0) <= 0 || contract.status === 'completed';
  if (!isZero) return 0;

  if (contract.completedAt) {
    const completedMs = new Date(contract.completedAt).getTime();
    if (!isNaN(completedMs)) {
      return completedMs + 24 * 60 * 60 * 1000;
    }
  }

  // If completedAt is not in PostgreSQL yet, use localStorage to remember the exact moment it was zeroed
  if (typeof window !== 'undefined') {
    const storageKey = `zero_balance_completed_at_${contract.id || 'unknown'}`;
    const stored = localStorage.getItem(storageKey);
    if (stored) {
      const storedMs = parseInt(stored, 10);
      if (!isNaN(storedMs)) {
        return storedMs + 24 * 60 * 60 * 1000;
      }
    } else {
      const now = Date.now();
      try {
        localStorage.setItem(storageKey, String(now));
      } catch {
        // ignore storage errors
      }
      return now + 24 * 60 * 60 * 1000;
    }
  }

  return Date.now() + 24 * 60 * 60 * 1000;
}

/**
 * Formats the countdown until the zero-balance contract is hidden (e.g. "(يتم الإخفاء خلال 23:45:10)").
 */
export function formatZeroBalanceCountdown(
  contract: {
    remainingBalance?: number;
    status?: string;
    startDate?: string;
    createdAt?: string | number;
    completedAt?: string | number;
  },
  isAr: boolean = true
): string {
  const isZero = (contract.remainingBalance ?? 0) <= 0 || contract.status === 'completed';
  if (!isZero) return '';

  const expiryMs = getZeroBalanceExpiryMs(contract);
  const diff = expiryMs - Date.now();
  if (diff <= 0) {
    return isAr ? '(انتهى وقت الإخفاء)' : '(Expired)';
  }

  const hours = Math.floor(diff / (1000 * 60 * 60));
  const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
  const seconds = Math.floor((diff % (1000 * 60)) / 1000);

  const pad = (n: number) => String(n).padStart(2, '0');
  const timeStr = `${pad(hours)}:${pad(minutes)}:${pad(seconds)}`;

  return isAr ? `(يتم الإخفاء خلال ${timeStr})` : `(Hidden in ${timeStr})`;
}


export function playNotificationSound() {
  try {
    const audioCtx = new (window.AudioContext || (window as any).webkitAudioContext)();
    const osc = audioCtx.createOscillator();
    const gain = audioCtx.createGain();
    osc.type = 'sine';
    osc.frequency.setValueAtTime(587.33, audioCtx.currentTime); // D5
    osc.frequency.setValueAtTime(880, audioCtx.currentTime + 0.15); // A5
    gain.gain.setValueAtTime(0.3, audioCtx.currentTime);
    gain.gain.exponentialRampToValueAtTime(0.01, audioCtx.currentTime + 0.4);
    osc.connect(gain);
    gain.connect(audioCtx.destination);
    osc.start();
    osc.stop(audioCtx.currentTime + 0.4);
  } catch (e) {
    // Ignore audio errors
  }
}

export function playAppointmentChime() {
  try {
    const AudioContextClass = window.AudioContext || (window as any).webkitAudioContext;
    if (!AudioContextClass) return;
    const audioCtx = new AudioContextClass();
    
    // 3-note pleasant reminder chime: G5 (784Hz) -> C6 (1046.5Hz) -> E6 (1318.5Hz)
    const notes = [
      { freq: 783.99, time: 0, duration: 0.18 },
      { freq: 1046.50, time: 0.16, duration: 0.18 },
      { freq: 1318.51, time: 0.32, duration: 0.35 }
    ];

    notes.forEach((n) => {
      const osc = audioCtx.createOscillator();
      const gain = audioCtx.createGain();
      osc.type = 'sine';
      osc.frequency.setValueAtTime(n.freq, audioCtx.currentTime + n.time);
      gain.gain.setValueAtTime(0.35, audioCtx.currentTime + n.time);
      gain.gain.exponentialRampToValueAtTime(0.001, audioCtx.currentTime + n.time + n.duration);
      osc.connect(gain);
      gain.connect(audioCtx.destination);
      osc.start(audioCtx.currentTime + n.time);
      osc.stop(audioCtx.currentTime + n.time + n.duration);
    });
  } catch (e) {
    // Ignore audio autoplay restrictions if user hasn't interacted yet
  }
}

export function requestNotificationPermissions(): Promise<boolean> {
  if (typeof window === 'undefined' || !('Notification' in window)) {
    return Promise.resolve(false);
  }
  if (Notification.permission === 'granted') {
    return Promise.resolve(true);
  }
  if (Notification.permission !== 'denied') {
    return Notification.requestPermission().then((permission) => permission === 'granted');
  }
  return Promise.resolve(false);
}

export function showBrowserNotification(title: string, body: string) {
  try {
    if (typeof window !== 'undefined' && 'Notification' in window) {
      if (Notification.permission === 'granted') {
        if ('serviceWorker' in navigator && navigator.serviceWorker.controller) {
          navigator.serviceWorker.ready.then((reg) => {
            reg.showNotification(title, {
              body,
              icon: '/pwa-192x192.png',
              badge: '/pwa-192x192.png',
              vibrate: [200, 100, 200, 100, 200],
              tag: 'appointment-alert-' + Date.now(),
              requireInteraction: true,
            } as any).catch(() => {
              new Notification(title, { body, icon: '/favicon.ico' });
            });
          }).catch(() => {
            new Notification(title, { body, icon: '/favicon.ico' });
          });
        } else {
          new Notification(title, { body, icon: '/favicon.ico' });
        }
      } else if (Notification.permission !== 'denied') {
        Notification.requestPermission().then((permission) => {
          if (permission === 'granted') {
            new Notification(title, { body, icon: '/favicon.ico' });
          }
        });
      }
    }
  } catch (e) {
    console.warn('Notification trigger warning:', e);
  }
}


