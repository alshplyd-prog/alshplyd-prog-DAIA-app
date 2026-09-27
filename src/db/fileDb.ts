import fs from 'fs';
import path from 'path';

const DATA_DIR = path.resolve(process.cwd(), 'data');

if (!fs.existsSync(DATA_DIR)) {
  fs.mkdirSync(DATA_DIR, { recursive: true });
}

function resolveFileName(table: string): string {
  const normalized = table.toLowerCase().trim();
  if (normalized === 'funds') return 'cash_funds.json';
  if (normalized === 'inventory') return 'inventory_items.json';
  if (normalized.endsWith('.json')) return normalized;
  return `${normalized}.json`;
}

// In-memory cache to avoid excessive disk I/O
const memoryCache: Record<string, any[]> = {};

function loadTable(table: string): any[] {
  const fileName = resolveFileName(table);
  const filePath = path.join(DATA_DIR, fileName);

  if (memoryCache[fileName]) {
    return memoryCache[fileName];
  }

  try {
    if (fs.existsSync(filePath)) {
      const content = fs.readFileSync(filePath, 'utf-8');
      const parsed = JSON.parse(content);
      const items = Array.isArray(parsed) ? parsed : [];
      memoryCache[fileName] = items;
      return items;
    }
  } catch (err) {
    console.error(`Error reading ${filePath}:`, err);
  }

  memoryCache[fileName] = [];
  return memoryCache[fileName];
}

function saveTable(table: string, items: any[]): void {
  const fileName = resolveFileName(table);
  const filePath = path.join(DATA_DIR, fileName);
  memoryCache[fileName] = items;

  try {
    fs.writeFileSync(filePath, JSON.stringify(items, null, 2), 'utf-8');
  } catch (err) {
    console.error(`Error writing ${filePath}:`, err);
  }
}

export const fileDb = {
  get<T = any>(table: string): T[] {
    return (loadTable(table) as T[]) || [];
  },

  setAll(table: string, items: any[]): void {
    const list = Array.isArray(items) ? [...items] : [];
    saveTable(table, list);
  },

  upsert<T extends { id?: string | number }>(table: string, item: T): T {
    const list = [...this.get(table)];
    const id = item.id;
    const index = id !== undefined ? list.findIndex((x: any) => String(x.id) === String(id)) : -1;

    if (index >= 0) {
      list[index] = { ...list[index], ...item };
      saveTable(table, list);
      return list[index];
    } else {
      list.push(item);
      saveTable(table, list);
      return item;
    }
  },

  update<T extends { id?: string | number }>(table: string, id: string | number, updates: Partial<T>): any {
    const list = [...this.get(table)];
    const index = list.findIndex((x: any) => String(x.id) === String(id));

    if (index >= 0) {
      const updated = { ...list[index], ...updates };
      list[index] = updated;
      saveTable(table, list);
      return updated;
    }
    return null;
  },

  delete(table: string, id: string | number): boolean {
    const list = this.get(table);
    const filtered = list.filter((x: any) => String(x.id) !== String(id));
    if (filtered.length !== list.length) {
      saveTable(table, filtered);
      return true;
    }
    return false;
  },

  readJson<T = any>(filename: string, defaultValue: T): T {
    const filePath = path.join(DATA_DIR, filename.endsWith('.json') ? filename : `${filename}.json`);
    try {
      if (!fs.existsSync(filePath)) {
        fs.writeFileSync(filePath, JSON.stringify(defaultValue, null, 2), 'utf-8');
        return defaultValue;
      }
      const data = fs.readFileSync(filePath, 'utf-8');
      return JSON.parse(data);
    } catch (e) {
      return defaultValue;
    }
  },

  writeJson<T = any>(filename: string, data: T): void {
    const filePath = path.join(DATA_DIR, filename.endsWith('.json') ? filename : `${filename}.json`);
    try {
      fs.writeFileSync(filePath, JSON.stringify(data, null, 2), 'utf-8');
    } catch (e) {
      console.error(`Error writing file ${filePath}:`, e);
    }
  },
};
