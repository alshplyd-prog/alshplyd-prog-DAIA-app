export function isPgConfigured(): boolean {
  return Boolean(process.env.DATABASE_URL || process.env.PGHOST);
}

export async function executePg<T = any>(query: string, params: any[] = []): Promise<T[]> {
  return [];
}
