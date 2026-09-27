// Name helpers & entity deduplication

export function normalizeEntityName(name: string): string {
  if (!name) return '';
  return name
    .trim()
    .toLowerCase()
    .replace(/\s+/g, ' ')
    .replace(/[أإآء]/g, 'ا')
    .replace(/ة/g, 'ه')
    .replace(/ى/g, 'ي');
}

export function hasDuplicateName<T extends { id: string; name: string }>(
  items: T[],
  newName: string,
  excludeId?: string
): boolean {
  const normalizedNew = normalizeEntityName(newName);
  if (!normalizedNew) return false;

  return items.some((item) => {
    if (excludeId && item.id === excludeId) return false;
    return normalizeEntityName(item.name) === normalizedNew;
  });
}

export function deduplicateEntitiesByName<T extends { id: string; name: string }>(items: T[]): T[] {
  const seen = new Set<string>();
  const result: T[] = [];

  for (const item of items) {
    const key = normalizeEntityName(item.name);
    if (!key || !seen.has(key)) {
      if (key) seen.add(key);
      result.push(item);
    }
  }

  return result;
}
