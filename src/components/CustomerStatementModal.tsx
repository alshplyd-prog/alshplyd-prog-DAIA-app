import React from 'react';
import { X, FileText, Printer } from 'lucide-react';
import { InstallmentContract, PaymentRecord, Language } from '../types';
import { openCustomerStatementPdfWindow } from '../lib/statementPdf';

interface CustomerStatementModalProps {
  isOpen: boolean;
  onClose: () => void;
  contract: InstallmentContract | null;
  payments: PaymentRecord[];
  lang?: Language;
}

export const CustomerStatementModal: React.FC<CustomerStatementModalProps> = ({
  isOpen,
  onClose,
  contract,
  payments = [],
  lang = 'ar',
}) => {
  const isAr = lang === 'ar';
  if (!isOpen || !contract) return null;

  const handlePrint = () => {
    openCustomerStatementPdfWindow({
      customerName: contract.customerName,
      payments,
    });
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-3 bg-slate-950/80 backdrop-blur-md animate-in fade-in duration-200 dir-rtl">
      <div className="bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-3xl shadow-2xl w-full max-w-lg overflow-hidden flex flex-col max-h-[90vh]">
        <div className="px-5 py-4 bg-slate-900 text-white flex items-center justify-between">
          <div className="flex items-center gap-2">
            <FileText className="w-5 h-5 text-indigo-400" />
            <h3 className="font-extrabold text-sm">{isAr ? `كشف حساب: ${contract.customerName}` : `Statement: ${contract.customerName}`}</h3>
          </div>
          <button onClick={onClose} className="p-1 rounded-xl bg-white/10 hover:bg-white/20 text-white">
            <X className="w-5 h-5" />
          </button>
        </div>

        <div className="p-5 overflow-y-auto space-y-3">
          <div className="grid grid-cols-3 gap-2 text-center p-3 rounded-2xl bg-slate-50 dark:bg-slate-800">
            <div>
              <p className="text-[10px] text-slate-500">{isAr ? 'المبلغ الكلي' : 'Total'}</p>
              <p className="font-black text-xs text-slate-900 dark:text-slate-100">{(contract.totalPrice || 0).toLocaleString()} د.ع</p>
            </div>
            <div>
              <p className="text-[10px] text-slate-500">{isAr ? 'الواصل الكلي' : 'Paid'}</p>
              <p className="font-black text-xs text-emerald-600 dark:text-emerald-400">{(contract.totalPaid || 0).toLocaleString()} د.ع</p>
            </div>
            <div>
              <p className="text-[10px] text-slate-500">{isAr ? 'المتبقي' : 'Remaining'}</p>
              <p className="font-black text-xs text-rose-600 dark:text-rose-400">{(contract.remainingBalance || 0).toLocaleString()} د.ع</p>
            </div>
          </div>

          <div className="space-y-2">
            <h4 className="font-bold text-xs text-slate-800 dark:text-slate-200">{isAr ? 'سجل الأقساط المسددة:' : 'Payment History:'}</h4>
            {payments.length === 0 ? (
              <p className="text-xs text-slate-400 text-center py-4">{isAr ? 'لا توجد دفعات مسجلة بعد' : 'No payments recorded yet'}</p>
            ) : (
              <div className="space-y-1.5 max-h-60 overflow-y-auto">
                {payments.map((p) => (
                  <div key={p.id} className="p-2.5 rounded-xl border border-slate-200 dark:border-slate-800 flex items-center justify-between text-xs">
                    <div>
                      <p className="font-bold text-slate-900 dark:text-slate-100">{(p.amountPaid || p.amount || 0).toLocaleString()} د.ع</p>
                      <p className="text-[10px] text-slate-500">{p.paymentDate || p.createdAt}</p>
                    </div>
                    <span className="text-[10px] px-2 py-0.5 rounded-md bg-slate-100 dark:bg-slate-800 text-slate-600">{p.repName || 'مندوب'}</span>
                  </div>
                ))}
              </div>
            )}
          </div>
        </div>

        <div className="p-4 bg-slate-50 dark:bg-slate-800/50 border-t border-slate-200 dark:border-slate-800 flex justify-between items-center">
          <button onClick={handlePrint} className="px-4 py-2 rounded-xl bg-indigo-600 hover:bg-indigo-700 text-white font-black text-xs flex items-center gap-1">
            <Printer className="w-4 h-4" />
            <span>{isAr ? 'طباعة كشف الحساب' : 'Print Statement'}</span>
          </button>
          <button onClick={onClose} className="px-4 py-2 rounded-xl border border-slate-300 text-slate-700 font-bold text-xs">
            {isAr ? 'إغلاق' : 'Close'}
          </button>
        </div>
      </div>
    </div>
  );
};
