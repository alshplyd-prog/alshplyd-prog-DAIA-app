import React, { useState, useEffect } from 'react';
import { X, Save, FileText } from 'lucide-react';
import { InstallmentContract, CustomerList, Language } from '../types';

interface ContractFormModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSave: (contractData: any) => Promise<void>;
  editingContract?: InstallmentContract | null;
  inventory?: any[];
  customerLists?: CustomerList[];
  defaultListId?: string;
  lang?: Language;
}

export const ContractFormModal: React.FC<ContractFormModalProps> = ({
  isOpen,
  onClose,
  onSave,
  editingContract,
  customerLists = [],
  defaultListId,
  lang = 'ar',
}) => {
  const isAr = lang === 'ar';
  const [customerName, setCustomerName] = useState('');
  const [phone, setPhone] = useState('');
  const [itemName, setItemName] = useState('');
  const [totalPrice, setTotalPrice] = useState('');
  const [advancePayment, setAdvancePayment] = useState('');
  const [monthlyInstallment, setMonthlyInstallment] = useState('');
  const [listId, setListId] = useState(defaultListId || customerLists[0]?.id || 'list_main');
  const [isSaving, setIsSaving] = useState(false);

  useEffect(() => {
    if (editingContract) {
      setCustomerName(editingContract.customerName || '');
      setPhone(editingContract.phone || '');
      setItemName(editingContract.itemName || '');
      setTotalPrice(String(editingContract.totalPrice || ''));
      setAdvancePayment(String(editingContract.advancePayment || ''));
      setMonthlyInstallment(String(editingContract.monthlyInstallment || ''));
      setListId(editingContract.listId || defaultListId || 'list_main');
    } else {
      setCustomerName('');
      setPhone('');
      setItemName('');
      setTotalPrice('');
      setAdvancePayment('');
      setMonthlyInstallment('');
      setListId(defaultListId || customerLists[0]?.id || 'list_main');
    }
  }, [editingContract, isOpen, defaultListId]);

  if (!isOpen) return null;

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!customerName.trim()) return;
    setIsSaving(true);
    try {
      await onSave({
        customerName: customerName.trim(),
        phone: phone.trim(),
        itemName: itemName.trim() || 'عقد مبيعات أجهزة',
        totalPrice: Number(totalPrice) || 0,
        advancePayment: Number(advancePayment) || 0,
        monthlyInstallment: Number(monthlyInstallment) || 0,
        listId,
      });
      onClose();
    } catch (err) {
      console.error(err);
    } finally {
      setIsSaving(false);
    }
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-3 bg-slate-950/80 backdrop-blur-md animate-in fade-in duration-200 dir-rtl">
      <div className="bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-3xl shadow-2xl w-full max-w-lg overflow-hidden flex flex-col">
        <div className="px-5 py-4 bg-slate-900 text-white flex items-center justify-between">
          <div className="flex items-center gap-2">
            <FileText className="w-5 h-5 text-indigo-400" />
            <h3 className="font-extrabold text-sm">
              {editingContract ? (isAr ? 'تعديل عقد زبون' : 'Edit Contract') : (isAr ? 'إضافة عقد بيع جديد' : 'New Contract')}
            </h3>
          </div>
          <button onClick={onClose} className="p-1 rounded-xl bg-white/10 hover:bg-white/20 text-white">
            <X className="w-5 h-5" />
          </button>
        </div>

        <form onSubmit={handleSubmit} className="p-5 space-y-4">
          <div>
            <label className="block text-xs font-bold mb-1 text-slate-700 dark:text-slate-300">
              {isAr ? 'اسم الزبون الرباعي' : 'Customer Name'}
            </label>
            <input
              type="text"
              required
              value={customerName}
              onChange={(e) => setCustomerName(e.target.value)}
              className="w-full px-3.5 py-2.5 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-bold"
              placeholder={isAr ? 'أدخل اسم الزبون' : 'Enter customer name'}
            />
          </div>

          <div className="grid grid-cols-2 gap-3">
            <div>
              <label className="block text-xs font-bold mb-1 text-slate-700 dark:text-slate-300">
                {isAr ? 'رقم الهاتف' : 'Phone'}
              </label>
              <input
                type="text"
                value={phone}
                onChange={(e) => setPhone(e.target.value)}
                className="w-full px-3 py-2 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-bold dir-ltr text-right"
                placeholder="07700000000"
              />
            </div>
            <div>
              <label className="block text-xs font-bold mb-1 text-slate-700 dark:text-slate-300">
                {isAr ? 'اسم المادة / المبيع' : 'Item Name'}
              </label>
              <input
                type="text"
                value={itemName}
                onChange={(e) => setItemName(e.target.value)}
                className="w-full px-3 py-2 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-bold"
                placeholder={isAr ? 'هاتف / جهاز' : 'Item name'}
              />
            </div>
          </div>

          <div className="grid grid-cols-3 gap-2">
            <div>
              <label className="block text-[11px] font-bold mb-1 text-slate-700 dark:text-slate-300">
                {isAr ? 'السعر الكلي' : 'Total Price'}
              </label>
              <input
                type="number"
                value={totalPrice}
                onChange={(e) => setTotalPrice(e.target.value)}
                className="w-full px-2.5 py-2 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-bold"
                placeholder="0"
              />
            </div>
            <div>
              <label className="block text-[11px] font-bold mb-1 text-slate-700 dark:text-slate-300">
                {isAr ? 'القدمة / المقدمة' : 'Advance'}
              </label>
              <input
                type="number"
                value={advancePayment}
                onChange={(e) => setAdvancePayment(e.target.value)}
                className="w-full px-2.5 py-2 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-bold"
                placeholder="0"
              />
            </div>
            <div>
              <label className="block text-[11px] font-bold mb-1 text-slate-700 dark:text-slate-300">
                {isAr ? 'القسط الشهري' : 'Monthly'}
              </label>
              <input
                type="number"
                value={monthlyInstallment}
                onChange={(e) => setMonthlyInstallment(e.target.value)}
                className="w-full px-2.5 py-2 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-bold"
                placeholder="0"
              />
            </div>
          </div>

          <div>
            <label className="block text-xs font-bold mb-1 text-slate-700 dark:text-slate-300">
              {isAr ? 'القائمة الملحقة' : 'Customer List'}
            </label>
            <select
              value={listId}
              onChange={(e) => setListId(e.target.value)}
              className="w-full px-3 py-2.5 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-bold"
            >
              {customerLists.map((l) => (
                <option key={l.id} value={l.id}>{l.name}</option>
              ))}
            </select>
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
              disabled={isSaving}
              className="px-5 py-2 rounded-xl bg-indigo-600 hover:bg-indigo-700 text-white text-xs font-black flex items-center gap-1 shadow-md"
            >
              <Save className="w-4 h-4" />
              <span>{isSaving ? (isAr ? 'جاري الحفظ...' : 'Saving...') : (isAr ? 'حفظ العقد' : 'Save Contract')}</span>
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};
