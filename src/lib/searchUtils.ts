// Search & Filtering Utilities

import { normalizeEntityName } from './nameHelpers';

export function searchEntities<T extends Record<string, any>>(
  items: T[],
  query: string,
  searchKeys: (keyof T)[]
): T[] {
  if (!query || !query.trim()) return items;
  const normalizedQuery = normalizeEntityName(query);

  return items.filter((item) => {
    return searchKeys.some((key) => {
      const val = item[key];
      if (!val) return false;
      const normalizedVal = normalizeEntityName(String(val));
      return normalizedVal.includes(normalizedQuery);
    });
  });
}
