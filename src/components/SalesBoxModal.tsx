import React, { useState } from 'react';
import { X, ShoppingCart, DollarSign, TrendingUp, Search, Calendar, User } from 'lucide-react';
import { InstallmentContract, CustomerList, SalesRepresentative, Language } from '../types';

interface SalesBoxModalProps {
  isOpen: boolean;
  onClose: () => void;
  contracts?: InstallmentContract[];
  customerLists?: CustomerList[];
  inventory?: any[];
  reps?: SalesRepresentative[];
  currentRep?: SalesRepresentative | null;
  lang?: Language;
  onOpenCustomerHistory?: (contract: InstallmentContract) => void;
}

export const SalesBoxModal: React.FC<SalesBoxModalProps> = ({
  isOpen,
  onClose,
  contracts = [],
  customerLists = [],
  lang = 'ar',
  onOpenCustomerHistory,
}) => {
  const isAr = lang === 'ar';
  const [searchTerm, setSearchTerm] = useState('');

  if (!isOpen) return null;

  const totalSalesAmount = contracts.reduce((sum, c) => sum + (c.totalPrice || 0), 0);
  const totalPaidAmount = contracts.reduce((sum, c) => sum + (c.totalPaid || 0), 0);
  const totalRemainingAmount = contracts.reduce((sum, c) => sum + (c.remainingBalance || 0), 0);

  const filteredContracts = contracts.filter((c) =>
    (c.customerName || '').toLowerCase().includes(searchTerm.toLowerCase()) ||
    (c.itemName || '').toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-3 bg-slate-950/80 backdrop-blur-md animate-in fade-in duration-200 dir-rtl">
      <div className="bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-3xl shadow-2xl w-full max-w-2xl overflow-hidden flex flex-col max-h-[90vh]">
        {/* Header */}
        <div className="px-5 py-4 bg-indigo-600 text-white flex items-center justify-between">
          <div className="flex items-center gap-2">
            <ShoppingCart className="w-5 h-5 text-indigo-200" />
            <h3 className="font-extrabold text-sm">{isAr ? 'صندوق المبيعات والعقود' : 'Sales & Contracts Box'}</h3>
          </div>
          <button onClick={onClose} className="p-1 rounded-xl bg-white/10 hover:bg-white/20 text-white">
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Stats summary */}
        <div className="grid grid-cols-3 gap-2 p-4 bg-slate-50 dark:bg-slate-800/50 border-b border-slate-200 dark:border-slate-800 text-center">
          <div className="p-3 bg-white dark:bg-slate-800 rounded-2xl border border-slate-200 dark:border-slate-700">
            <p className="text-[10px] text-slate-500 font-bold mb-0.5">{isAr ? 'إجمالي المبيعات' : 'Total Sales'}</p>
            <p className="text-xs sm:text-sm font-black text-indigo-600 dark:text-indigo-400">
              {totalSalesAmount.toLocaleString()} د.ع
            </p>
          </div>
          <div className="p-3 bg-white dark:bg-slate-800 rounded-2xl border border-slate-200 dark:border-slate-700">
            <p className="text-[10px] text-slate-500 font-bold mb-0.5">{isAr ? 'المقبوض الفعلي' : 'Collected'}</p>
            <p className="text-xs sm:text-sm font-black text-emerald-600 dark:text-emerald-400">
              {totalPaidAmount.toLocaleString()} د.ع
            </p>
          </div>
          <div className="p-3 bg-white dark:bg-slate-800 rounded-2xl border border-slate-200 dark:border-slate-700">
            <p className="text-[10px] text-slate-500 font-bold mb-0.5">{isAr ? 'المتبقي الكلي' : 'Remaining'}</p>
            <p className="text-xs sm:text-sm font-black text-rose-600 dark:text-rose-400">
              {totalRemainingAmount.toLocaleString()} د.ع
            </p>
          </div>
        </div>

        {/* Search */}
        <div className="p-3 border-b border-slate-200 dark:border-slate-800">
          <div className="relative">
            <Search className="w-4 h-4 absolute right-3 top-3 text-slate-400" />
            <input
              type="text"
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              placeholder={isAr ? 'بحث في المبيعات والزبائن...' : 'Search sales...'}
              className="w-full pr-9 pl-3 py-2 rounded-xl bg-slate-50 dark:bg-slate-800 border border-slate-200 dark:border-slate-700 text-xs font-bold"
            />
          </div>
        </div>

        {/* Contracts list */}
        <div className="p-4 overflow-y-auto space-y-2 flex-1">
          {filteredContracts.length === 0 ? (
            <div className="text-center py-8 text-slate-400 text-xs font-bold">
              {isAr ? 'لا توجد عقود مبيعات مطابقة' : 'No sales contracts found'}
            </div>
          ) : (
            filteredContracts.map((contract) => (
              <div
                key={contract.id}
                onClick={() => {
                  if (onOpenCustomerHistory) {
                    onOpenCustomerHistory(contract);
                    onClose();
                  }
                }}
                className="p-3 rounded-2xl border border-slate-200 dark:border-slate-800 flex items-center justify-between hover:bg-slate-50 dark:hover:bg-slate-800/40 cursor-pointer transition-colors"
              >
                <div>
                  <h4 className="font-black text-xs text-slate-900 dark:text-slate-100">{contract.customerName}</h4>
                  <div className="flex gap-2 text-[10px] text-slate-500 mt-0.5">
                    <span>{contract.itemName || 'عقد بيع'}</span>
                    <span>•</span>
                    <span>{contract.phone || '-'}</span>
                  </div>
                </div>
                <div className="text-left font-mono">
                  <p className="font-black text-xs text-slate-900 dark:text-slate-100">
                    {(contract.totalPrice || 0).toLocaleString()} د.ع
                  </p>
                  <p className="text-[10px] font-bold text-rose-500">
                    {isAr ? 'متبقي: ' : 'Rem: '}{(contract.remainingBalance || 0).toLocaleString()} د.ع
                  </p>
                </div>
              </div>
            ))
          )}
        </div>

        {/* Footer */}
        <div className="p-3 bg-slate-50 dark:bg-slate-800/50 border-t border-slate-200 dark:border-slate-800 flex justify-end">
          <button
            onClick={onClose}
            className="px-4 py-2 rounded-xl bg-slate-200 dark:bg-slate-800 text-slate-700 dark:text-slate-300 font-bold text-xs"
          >
            {isAr ? 'إغلاق' : 'Close'}
          </button>
        </div>
      </div>
    </div>
  );
};
