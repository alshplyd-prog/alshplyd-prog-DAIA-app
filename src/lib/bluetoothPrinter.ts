// Bluetooth & Thermal Printer Utility

export const DEFAULT_DUPLICATE_RECEIPT_WARNING = 'تنبيه: وصل مكرر / طباعة إضافية';

export interface ThermalReceiptData {
  title?: string;
  customerName?: string;
  phone?: string;
  amountPaid?: number;
  totalPaid?: number;
  remainingBalance?: number;
  date?: string;
  contractNumber?: string;
  repName?: string;
  note?: string;
  isDuplicate?: boolean;
}

export type Platform = 'web' | 'android' | 'ios';
export type PrintMethod = 'bluetooth' | 'web_window' | 'native_app';

export interface BluetoothDevice {
  name?: string;
  address?: string;
  id?: string;
}

export interface PrinterConfig {
  method: PrintMethod;
  deviceName?: string;
  deviceAddress?: string;
  paperWidth?: number;
}

export interface SavedPrinterProfile {
  id: string;
  name: string;
  address?: string;
  isDefault?: boolean;
}

export function getSavedPrinterConfig(): PrinterConfig {
  return { method: 'web_window' };
}

export function savePrinterConfig(config: PrinterConfig): void {}
export async function scanAndSaveBluetoothPrinter(): Promise<BluetoothDevice | null> { return null; }
export async function listPairedBluetoothDevices(): Promise<BluetoothDevice[]> { return []; }
export async function requestWebBluetoothDevice(): Promise<BluetoothDevice | null> { return null; }

export function getSavedPrintersList(): SavedPrinterProfile[] {
  return [];
}

export function removePrinterProfile(id: string): void {}
export function switchActivePrinter(id: string): void {}
export async function openNativeBluetoothSettings(): Promise<void> {}
export async function requestAndroidBluetoothPermissions(): Promise<boolean> {
  return true;
}
export async function ensureBluetoothEnabled(): Promise<boolean> {
  return true;
}

export async function silentAutoPrintReceipt(data: ThermalReceiptData): Promise<boolean> {
  return Promise.resolve(true);
}

export async function directPrintReceipt(data: ThermalReceiptData): Promise<boolean> {
  return Promise.resolve(true);
}

export function openThermalPrintWindow(data: ThermalReceiptData): void {
  if (typeof window === 'undefined') return;
  const printWin = window.open('', '_blank', 'width=400,height=600');
  if (!printWin) return;

  printWin.document.write(`
    <!DOCTYPE html>
    <html dir="rtl" lang="ar">
    <head>
      <meta charset="utf-8">
      <title>وصل قبض</title>
      <style>
        body { font-family: monospace; padding: 20px; text-align: center; font-size: 14px; }
        .line { border-bottom: 1px dashed #000; margin: 10px 0; }
        .row { display: flex; justify-content: space-between; margin: 5px 0; }
        .bold { font-weight: bold; }
      </style>
    </head>
    <body>
      <h2>${data.title || 'وصل قبض أقساط'}</h2>
      ${data.isDuplicate ? `<div style="color:red; font-weight:bold;">${DEFAULT_DUPLICATE_RECEIPT_WARNING}</div>` : ''}
      <div class="line"></div>
      <div class="row"><span>الزبون:</span><span class="bold">${data.customerName || '-'}</span></div>
      <div class="row"><span>المبلغ المدفوع:</span><span class="bold">${(data.amountPaid || 0).toLocaleString()} د.ع</span></div>
      <div class="row"><span>المتبقي:</span><span class="bold">${(data.remainingBalance || 0).toLocaleString()} د.ع</span></div>
      <div class="row"><span>التاريخ:</span><span>${data.date || new Date().toLocaleDateString('ar-IQ')}</span></div>
      <div class="row"><span>المندوب:</span><span>${data.repName || '-'}</span></div>
      <div class="line"></div>
      <p>شكراً لتعاملكم معنا</p>
      <script>window.print();</script>
    </body>
    </html>
  `);
  printWin.document.close();
}

export async function printOrQueueInvoice(data: ThermalReceiptData): Promise<boolean> {
  openThermalPrintWindow(data);
  return true;
}

export async function processPrintQueue(): Promise<void> {}
