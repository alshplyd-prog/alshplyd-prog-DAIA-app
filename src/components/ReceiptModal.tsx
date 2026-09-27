import React from 'react';
import { X, Printer, CheckCircle } from 'lucide-react';
import { Language } from '../types';

export interface ReceiptData {
  customerName?: string;
  amountPaid?: number;
  remainingBalance?: number;
  totalPaid?: number;
  date?: string;
  repName?: string;
  note?: string;
}

interface ReceiptModalProps {
  isOpen: boolean;
  onClose: () => void;
  data: ReceiptData | null;
  onPrint?: () => void;
  lang?: Language;
}

export const ReceiptModal: React.FC<ReceiptModalProps> = ({
  isOpen,
  onClose,
  data,
  onPrint,
  lang = 'ar',
}) => {
  const isAr = lang === 'ar';
  if (!isOpen || !data) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-3 bg-slate-950/80 backdrop-blur-md animate-in fade-in duration-200 dir-rtl">
      <div className="bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-3xl shadow-2xl w-full max-w-sm overflow-hidden flex flex-col">
        <div className="px-5 py-4 bg-teal-600 text-white flex items-center justify-between">
          <div className="flex items-center gap-2">
            <CheckCircle className="w-5 h-5 text-teal-200" />
            <h3 className="font-extrabold text-sm">{isAr ? 'وصل تسديد ناجح' : 'Receipt'}</h3>
          </div>
          <button onClick={onClose} className="p-1 rounded-xl bg-white/10 hover:bg-white/20 text-white">
            <X className="w-5 h-5" />
          </button>
        </div>

        <div className="p-5 space-y-3 font-mono text-xs">
          <div className="text-center py-2 border-b border-dashed border-slate-300 dark:border-slate-700">
            <h4 className="font-black text-sm text-slate-800 dark:text-slate-100">وصل القبض الرسمي</h4>
            <p className="text-[10px] text-slate-500">{data.date || new Date().toLocaleDateString('ar-IQ')}</p>
          </div>

          <div className="space-y-1.5 text-slate-700 dark:text-slate-300">
            <div className="flex justify-between">
              <span>الزبون:</span>
              <span className="font-black text-slate-900 dark:text-slate-100">{data.customerName || '-'}</span>
            </div>
            <div className="flex justify-between">
              <span>المبلغ المدفوع:</span>
              <span className="font-black text-emerald-600 dark:text-emerald-400">
                {(data.amountPaid || 0).toLocaleString()} د.ع
              </span>
            </div>
            <div className="flex justify-between">
              <span>المتبقي:</span>
              <span className="font-black text-rose-600 dark:text-rose-400">
                {(data.remainingBalance || 0).toLocaleString()} د.ع
              </span>
            </div>
            <div className="flex justify-between">
              <span>المندوب:</span>
              <span>{data.repName || '-'}</span>
            </div>
          </div>

          {data.note && (
            <div className="p-2 rounded-xl bg-slate-100 dark:bg-slate-800 text-[11px]">
              ملاحظة: {data.note}
            </div>
          )}
        </div>

        <div className="p-4 bg-slate-50 dark:bg-slate-800/50 border-t border-slate-200 dark:border-slate-800 flex justify-end gap-2">
          <button
            onClick={onClose}
            className="px-4 py-2 rounded-xl border border-slate-300 text-slate-700 font-bold text-xs"
          >
            {isAr ? 'إغلاق' : 'Close'}
          </button>
          {onPrint && (
            <button
              onClick={onPrint}
              className="px-4 py-2 rounded-xl bg-teal-600 hover:bg-teal-700 text-white font-black text-xs flex items-center gap-1"
            >
              <Printer className="w-4 h-4" />
              <span>{isAr ? 'طباعة الوصل' : 'Print'}</span>
            </button>
          )}
        </div>
      </div>
    </div>
  );
};
