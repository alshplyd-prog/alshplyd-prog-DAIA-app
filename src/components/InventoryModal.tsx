import React from 'react';

export const InventoryModal: React.FC<any> = ({ isOpen, onClose }) => {
  if (!isOpen) return null;
  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-3 bg-slate-950/80">
      <div className="bg-white dark:bg-slate-900 p-6 rounded-3xl max-w-md w-full">
        <h3 className="font-extrabold text-sm mb-4">المخزن</h3>
        <button onClick={onClose} className="px-4 py-2 rounded-xl bg-slate-200 text-xs font-bold">إغلاق</button>
      </div>
    </div>
  );
};
