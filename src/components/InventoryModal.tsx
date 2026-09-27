import React, { useState } from 'react';
import { X, Package, Plus, Trash2, Edit2, Search } from 'lucide-react';
import { InventoryItem, Language } from '../types';

interface InventoryModalProps {
  isOpen: boolean;
  onClose: () => void;
  items?: InventoryItem[];
  lang?: Language;
  onAddItem?: (item: any) => Promise<void>;
  onUpdateItem?: (id: string, updates: any) => Promise<void>;
  onDeleteItem?: (id: string) => Promise<void>;
}

export const InventoryModal: React.FC<InventoryModalProps> = ({
  isOpen,
  onClose,
  items = [],
  lang = 'ar',
  onAddItem,
  onUpdateItem,
  onDeleteItem,
}) => {
  const isAr = lang === 'ar';
  const [searchTerm, setSearchTerm] = useState('');
  const [isAdding, setIsAdding] = useState(false);
  const [newItemName, setNewItemName] = useState('');
  const [newItemQty, setNewItemQty] = useState('1');
  const [newItemPrice, setNewItemPrice] = useState('');
  const [newItemInstallmentPrice, setNewItemInstallmentPrice] = useState('');

  if (!isOpen) return null;

  const filteredItems = items.filter((item) =>
    (item.name || '').toLowerCase().includes(searchTerm.toLowerCase())
  );

  const handleCreate = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!newItemName.trim() || !onAddItem) return;

    await onAddItem({
      name: newItemName.trim(),
      quantity: Number(newItemQty) || 1,
      costPrice: Number(newItemPrice) || 0,
      installmentPrice: Number(newItemInstallmentPrice) || Number(newItemPrice) || 0,
    });

    setNewItemName('');
    setNewItemQty('1');
    setNewItemPrice('');
    setNewItemInstallmentPrice('');
    setIsAdding(false);
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-3 bg-slate-950/80 backdrop-blur-md animate-in fade-in duration-200 dir-rtl">
      <div className="bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-3xl shadow-2xl w-full max-w-xl overflow-hidden flex flex-col max-h-[90vh]">
        <div className="px-5 py-4 bg-slate-900 text-white flex items-center justify-between">
          <div className="flex items-center gap-2">
            <Package className="w-5 h-5 text-indigo-400" />
            <h3 className="font-extrabold text-sm">{isAr ? 'إدارة المواد والمخزن' : 'Inventory Management'}</h3>
          </div>
          <button onClick={onClose} className="p-1 rounded-xl bg-white/10 hover:bg-white/20 text-white">
            <X className="w-5 h-5" />
          </button>
        </div>

        <div className="p-4 border-b border-slate-200 dark:border-slate-800 flex gap-2">
          <div className="relative flex-1">
            <Search className="w-4 h-4 absolute right-3 top-3 text-slate-400" />
            <input
              type="text"
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              placeholder={isAr ? 'بحث في المخزن...' : 'Search items...'}
              className="w-full pr-9 pl-3 py-2 rounded-xl bg-slate-50 dark:bg-slate-800 border border-slate-200 dark:border-slate-700 text-xs font-bold"
            />
          </div>
          <button
            onClick={() => setIsAdding(!isAdding)}
            className="px-3.5 py-2 rounded-xl bg-indigo-600 hover:bg-indigo-700 text-white font-black text-xs flex items-center gap-1 shrink-0"
          >
            <Plus className="w-4 h-4" />
            <span>{isAr ? 'إضافة مادة' : 'Add Item'}</span>
          </button>
        </div>

        {isAdding && (
          <form onSubmit={handleCreate} className="p-4 bg-slate-50 dark:bg-slate-800/60 border-b border-slate-200 dark:border-slate-800 space-y-3">
            <h4 className="text-xs font-black text-slate-800 dark:text-slate-100">{isAr ? 'إضافة مادة جديدة للمخزن:' : 'Add New Item:'}</h4>
            <div className="grid grid-cols-2 gap-2">
              <input
                type="text"
                required
                value={newItemName}
                onChange={(e) => setNewItemName(e.target.value)}
                placeholder={isAr ? 'اسم المادة أو الجهاز' : 'Item name'}
                className="w-full px-3 py-2 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-bold"
              />
              <input
                type="number"
                value={newItemQty}
                onChange={(e) => setNewItemQty(e.target.value)}
                placeholder={isAr ? 'الكمية' : 'Quantity'}
                className="w-full px-3 py-2 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-bold"
              />
            </div>
            <div className="grid grid-cols-2 gap-2">
              <input
                type="number"
                value={newItemPrice}
                onChange={(e) => setNewItemPrice(e.target.value)}
                placeholder={isAr ? 'سعر الكلفة' : 'Cost price'}
                className="w-full px-3 py-2 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-bold"
              />
              <input
                type="number"
                value={newItemInstallmentPrice}
                onChange={(e) => setNewItemInstallmentPrice(e.target.value)}
                placeholder={isAr ? 'سعر البيع بالتقسيط' : 'Installment price'}
                className="w-full px-3 py-2 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-bold"
              />
            </div>
            <div className="flex justify-end gap-2">
              <button
                type="button"
                onClick={() => setIsAdding(false)}
                className="px-3 py-1.5 rounded-xl border border-slate-300 text-slate-700 font-bold text-xs"
              >
                {isAr ? 'إلغاء' : 'Cancel'}
              </button>
              <button
                type="submit"
                className="px-4 py-1.5 rounded-xl bg-indigo-600 hover:bg-indigo-700 text-white font-black text-xs"
              >
                {isAr ? 'حفظ المادة' : 'Save'}
              </button>
            </div>
          </form>
        )}

        <div className="p-4 overflow-y-auto space-y-2 flex-1">
          {filteredItems.length === 0 ? (
            <div className="text-center py-8 text-slate-400 text-xs font-bold">
              {isAr ? 'لا توجد مواد مسجلة في المخزن' : 'No inventory items'}
            </div>
          ) : (
            filteredItems.map((item) => (
              <div
                key={item.id}
                className="p-3 rounded-2xl border border-slate-200 dark:border-slate-800 flex items-center justify-between hover:bg-slate-50 dark:hover:bg-slate-800/40 transition-colors"
              >
                <div>
                  <h4 className="font-black text-xs text-slate-900 dark:text-slate-100">{item.name}</h4>
                  <div className="flex gap-3 text-[10px] text-slate-500 mt-0.5">
                    <span>{isAr ? 'الكمية: ' : 'Qty: '}<strong>{item.quantity || 0}</strong></span>
                    {item.installmentPrice ? (
                      <span>{isAr ? 'التقسيط: ' : 'Price: '}<strong>{(item.installmentPrice || 0).toLocaleString()} د.ع</strong></span>
                    ) : null}
                  </div>
                </div>
                {onDeleteItem && (
                  <button
                    onClick={() => onDeleteItem(item.id)}
                    className="p-2 rounded-xl text-rose-500 hover:bg-rose-50 dark:hover:bg-rose-950/40"
                    title={isAr ? 'حذف المادة' : 'Delete'}
                  >
                    <Trash2 className="w-4 h-4" />
                  </button>
                )}
              </div>
            ))
          )}
        </div>

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
