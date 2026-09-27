import React, { useState } from 'react';
import { X, Check, DollarSign } from 'lucide-react';
import { InstallmentContract, Language } from '../types';

interface AddPaymentModalProps {
  isOpen: boolean;
  onClose: () => void;
  contract: InstallmentContract | null;
  onAddPayment: (contractId: string, amount: number, note?: string) => Promise<void>;
  lang?: Language;
}

export const AddPaymentModal: React.FC<AddPaymentModalProps> = ({
  isOpen,
  onClose,
  contract,
  onAddPayment,
  lang = 'ar',
}) => {
  const isAr = lang === 'ar';
  const [amount, setAmount] = useState('');
  const [note, setNote] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);

  if (!isOpen || !contract) return null;

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const payVal = Number(amount);
    if (!payVal || payVal <= 0) return;

    setIsSubmitting(true);
    try {
      await onAddPayment(contract.id, payVal, note.trim());
      setAmount('');
      setNote('');
      onClose();
    } catch (e) {
      console.error(e);
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-3 bg-slate-950/80 backdrop-blur-md animate-in fade-in duration-200 dir-rtl">
      <div className="bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-3xl shadow-2xl w-full max-w-md overflow-hidden">
        <div className="px-5 py-4 bg-emerald-600 text-white flex items-center justify-between">
          <div className="flex items-center gap-2">
            <DollarSign className="w-5 h-5 text-emerald-200" />
            <h3 className="font-extrabold text-sm">
              {isAr ? `تسديد قسط: ${contract.customerName}` : `Add Payment: ${contract.customerName}`}
            </h3>
          </div>
          <button onClick={onClose} className="p-1 rounded-xl bg-white/10 hover:bg-white/20 text-white">
            <X className="w-5 h-5" />
          </button>
        </div>

        <form onSubmit={handleSubmit} className="p-5 space-y-4">
          <div className="p-3 bg-slate-50 dark:bg-slate-800/60 rounded-2xl border border-slate-200 dark:border-slate-700 space-y-1">
            <p className="text-xs text-slate-500">{isAr ? 'المتبقي الحالي على الزبون:' : 'Current Remaining:'}</p>
            <p className="text-lg font-black text-rose-600 dark:text-rose-400">
              {(contract.remainingBalance || 0).toLocaleString()} د.ع
            </p>
          </div>

          <div>
            <label className="block text-xs font-bold mb-1 text-slate-700 dark:text-slate-300">
              {isAr ? 'مبلغ القسط المدفوع الآن' : 'Amount Paid'}
            </label>
            <input
              type="number"
              required
              min="1"
              value={amount}
              onChange={(e) => setAmount(e.target.value)}
              className="w-full px-3.5 py-2.5 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-sm font-black"
              placeholder={String(contract.monthlyInstallment || '0')}
            />
          </div>

          <div>
            <label className="block text-xs font-bold mb-1 text-slate-700 dark:text-slate-300">
              {isAr ? 'ملاحظة الوصل' : 'Note'}
            </label>
            <input
              type="text"
              value={note}
              onChange={(e) => setNote(e.target.value)}
              className="w-full px-3 py-2 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-bold"
              placeholder={isAr ? 'مثال: تسديد شهر أيلول' : 'e.g. September payment'}
            />
          </div>

          <div className="flex justify-end gap-2 pt-3 border-t border-slate-200 dark:border-slate-800">
            <button
              type="button"
              onClick={onClose}
              className="px-4 py-2 rounded-xl border border-slate-300 text-slate-700 font-bold text-xs"
            >
              {isAr ? 'إلغاء' : 'Cancel'}
            </button>
            <button
              type="submit"
              disabled={isSubmitting}
              className="px-5 py-2 rounded-xl bg-emerald-600 hover:bg-emerald-700 text-white text-xs font-black flex items-center gap-1 shadow-md"
            >
              <Check className="w-4 h-4" />
              <span>{isSubmitting ? (isAr ? 'جاري التسديد...' : 'Processing...') : (isAr ? 'تأكيد التسديد وطباعة الوصل' : 'Confirm Payment')}</span>
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};
