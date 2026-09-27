// API Configuration & Universal Fetch Utility

export const API_BASE_URL = typeof window !== 'undefined' && window.location
  ? window.location.origin
  : '';

export function getFullApiUrl(endpoint: string): string {
  if (endpoint.startsWith('http://') || endpoint.startsWith('https://')) {
    return endpoint;
  }
  const cleanEndpoint = endpoint.startsWith('/') ? endpoint : `/${endpoint}`;
  return `${API_BASE_URL}${cleanEndpoint}`;
}

export async function checkServerHealth(): Promise<boolean> {
  try {
    const res = await fetch(getFullApiUrl('/api/health'), { cache: 'no-store' });
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
