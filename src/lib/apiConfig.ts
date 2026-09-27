// API Configuration & Universal Fetch Utility

export const CLOUD_SERVER_URL = 'https://ais-pre-asc5xuvnur4hlmpl5rfxpz-655986077616.europe-west2.run.app';
const SERVER_URL_KEY = 'alkarrar_custom_server_url';

export function getBaseApiUrl(): string {
  if (typeof window === 'undefined') return '';

  try {
    const custom = localStorage.getItem(SERVER_URL_KEY);
    if (custom && custom.trim().length > 5) {
      return custom.trim().replace(/\/+$/, '');
    }
  } catch (e) {}

  const origin = (typeof window !== 'undefined' && window.location?.origin) || '';
  
  // If running inside Capacitor mobile container or file system
  const isLocalMobile =
    !origin ||
    origin.includes('localhost') ||
    origin.includes('127.0.0.1') ||
    origin.includes('capacitor://') ||
    origin.includes('ionic://') ||
    origin.startsWith('file://');

  if (isLocalMobile) {
    return CLOUD_SERVER_URL;
  }

  return origin;
}

export function setCustomServerUrl(url: string): void {
  if (typeof window !== 'undefined') {
    if (!url || !url.trim()) {
      localStorage.removeItem(SERVER_URL_KEY);
    } else {
      localStorage.setItem(SERVER_URL_KEY, url.trim().replace(/\/+$/, ''));
    }
  }
}

export const API_BASE_URL = getBaseApiUrl();

export function getFullApiUrl(endpoint: string): string {
  if (endpoint.startsWith('http://') || endpoint.startsWith('https://')) {
    return endpoint;
  }
  const cleanEndpoint = endpoint.startsWith('/') ? endpoint : `/${endpoint}`;
  const base = getBaseApiUrl();
  return `${base}${cleanEndpoint}`;
}

export async function checkServerHealth(): Promise<boolean> {
  try {
    const url = getFullApiUrl('/api/health');
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), 6000);
    const res = await fetch(url, { cache: 'no-store', signal: controller.signal });
    clearTimeout(timeoutId);
    return res.ok;
  } catch (e) {
    return false;
  }
}

export async function universalApiFetch<T = any>(
  endpoint: string,
  options: RequestInit = {}
): Promise<T> {
  const url = getFullApiUrl(endpoint);
  const headers = {
    'Content-Type': 'application/json',
    ...(options.headers || {}),
  };

  const response = await fetch(url, { ...options, headers });
  if (!response.ok) {
    const errText = await response.text();
    throw new Error(errText || `API request failed with status ${response.status}`);
  }
  return response.json();
}

export async function fetchWithFallback<T = any>(
  endpoint: string,
  options: RequestInit = {}
): Promise<T> {
  return universalApiFetch<T>(endpoint, options);
}
