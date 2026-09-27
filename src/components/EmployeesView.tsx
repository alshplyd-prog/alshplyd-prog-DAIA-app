import React, { useState } from 'react';
import {
  Users,
  Plus,
  DollarSign,
  TrendingDown,
  TrendingUp,
  Trash2,
  Edit2,
  Search,
  Phone,
  Calendar,
  RefreshCw,
  ArrowDownLeft,
  ArrowUpRight
} from 'lucide-react';
import { Employee, CashFund, EmployeeTransaction, SalesRepresentative, Language } from '../types';

interface EmployeesViewProps {
  employees: Employee[];
  funds: CashFund[];
  transactions?: EmployeeTransaction[];
  currentRep: SalesRepresentative | null;
  reps?: SalesRepresentative[];
  lang?: Language;
  onAddEmployee?: (employee: any) => Promise<void>;
  onUpdateEmployee?: (id: string, updates: any) => Promise<void>;
  onDeleteEmployee?: (id: string) => Promise<void>;
  onDeleteAllEmployees?: () => Promise<void>;
  onProcessDebtTransaction?: (data: any) => Promise<void>;
  onDeleteEmployeeTransaction?: (id: string) => Promise<void>;
  onUpdateEmployeeTransaction?: (id: string, updates: any) => Promise<void>;
  onSyncDebtBalances?: () => Promise<void>;
}

export const EmployeesView: React.FC<EmployeesViewProps> = ({
  employees = [],
  funds = [],
  transactions = [],
  currentRep,
  lang = 'ar',
  onAddEmployee,
  onDeleteEmployee,
  onProcessDebtTransaction,
  onSyncDebtBalances,
}) => {
  const isAr = lang === 'ar';
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedEmpId, setSelectedEmpId] = useState<string>('all');
  const [showAddEmpModal, setShowAddEmpModal] = useState<boolean>(false);
  const [showDebtModal, setShowDebtModal] = useState<boolean>(false);

  // New Employee state
  const [empName, setEmpName] = useState('');
  const [empPhone, setEmpPhone] = useState('');
  const [empSalary, setEmpSalary] = useState('');

  // Debt transaction state
  const [targetEmpId, setTargetEmpId] = useState(employees[0]?.id || '');
  const [debtType, setDebtType] = useState<'advance' | 'repayment' | 'salary'>('advance');
  const [debtAmount, setDebtAmount] = useState('');
  const [debtFundId, setDebtFundId] = useState(funds[0]?.id || '');
  const [debtNote, setDebtNote] = useState('');

  const totalEmployeesDebt = employees.reduce((sum, e) => sum + (e.debtBalance || 0), 0);

  const filteredEmployees = employees.filter((e) =>
    (e.name || '').toLowerCase().includes(searchTerm.toLowerCase()) ||
    (e.phone || '').includes(searchTerm)
  );

  const filteredTransactions = selectedEmpId === 'all'
    ? transactions
    : transactions.filter((t) => t.employeeId === selectedEmpId);

  const handleCreateEmployee = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!empName.trim() || !onAddEmployee) return;

    await onAddEmployee({
      name: empName.trim(),
      phone: empPhone.trim(),
      baseSalary: Number(empSalary) || 0,
      debtBalance: 0,
    });

    setEmpName('');
    setEmpPhone('');
    setEmpSalary('');
    setShowAddEmpModal(false);
  };

  const handleDebtSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const amt = Number(debtAmount);
    if (!amt || !targetEmpId || !onProcessDebtTransaction) return;

    await onProcessDebtTransaction({
      employeeId: targetEmpId,
      type: debtType,
      amount: amt,
      fundId: debtFundId || funds[0]?.id,
      note: debtNote.trim(),
      repName: currentRep?.name || 'المدير',
    });

    setDebtAmount('');
    setDebtNote('');
    setShowDebtModal(false);
  };

  return (
    <div className="space-y-4 max-w-7xl mx-auto p-2 sm:p-4 dir-rtl">
      {/* Header Overview */}
      <div className="bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-3xl p-5 shadow-sm flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div className="flex items-center gap-3">
          <div className="w-12 h-12 rounded-2xl bg-indigo-50 dark:bg-indigo-950/60 text-indigo-600 dark:text-indigo-400 flex items-center justify-center">
            <Users className="w-6 h-6" />
          </div>
          <div>
            <h2 className="text-base font-black text-slate-900 dark:text-slate-100">
              {isAr ? 'إدارة الموظفين والديون والسلف' : 'Employees & Debt Management'}
            </h2>
            <p className="text-xs text-slate-500">
              {isAr ? 'إجمالي السلف والديون المستحقة: ' : 'Total Outstanding Debt: '}
              <strong className="text-rose-600 dark:text-rose-400 text-sm font-black">
                {totalEmployeesDebt.toLocaleString()} د.ع
              </strong>
            </p>
          </div>
        </div>

        {/* Buttons */}
        <div className="flex flex-wrap gap-2">
          {onSyncDebtBalances && (
            <button
              onClick={() => onSyncDebtBalances()}
              className="px-3.5 py-2 rounded-xl bg-slate-100 dark:bg-slate-800 text-slate-700 dark:text-slate-300 font-bold text-xs flex items-center gap-1.5 hover:bg-slate-200"
            >
              <RefreshCw className="w-3.5 h-3.5" />
              <span>{isAr ? 'تحديث ومطابقة الديون' : 'Sync Debts'}</span>
            </button>
          )}
          <button
            onClick={() => setShowDebtModal(true)}
            className="px-3.5 py-2 rounded-xl bg-indigo-600 hover:bg-indigo-700 text-white font-bold text-xs flex items-center gap-1.5 shadow-sm transition-colors"
          >
            <DollarSign className="w-3.5 h-3.5" />
            <span>{isAr ? 'صرف سلفة / تسديد دين' : 'Advance / Repayment'}</span>
          </button>
          <button
            onClick={() => setShowAddEmpModal(true)}
            className="px-3.5 py-2 rounded-xl border border-slate-300 dark:border-slate-700 text-slate-700 dark:text-slate-300 font-bold text-xs flex items-center gap-1.5 hover:bg-slate-50 dark:hover:bg-slate-800"
          >
            <Plus className="w-3.5 h-3.5" />
            <span>{isAr ? 'إضافة موظف' : 'New Employee'}</span>
          </button>
        </div>
      </div>

      {/* Employees list */}
      <div className="bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-3xl p-5 shadow-sm">
        <div className="flex flex-col sm:flex-row gap-2 justify-between mb-4">
          <div className="relative flex-1">
            <Search className="w-4 h-4 absolute right-3 top-3 text-slate-400" />
            <input
              type="text"
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              placeholder={isAr ? 'بحث عن موظف بالاسم أو الهاتف...' : 'Search employees...'}
              className="w-full pr-9 pl-3 py-2 rounded-xl bg-slate-50 dark:bg-slate-800 border border-slate-200 dark:border-slate-700 text-xs font-bold"
            />
          </div>
        </div>

        {filteredEmployees.length === 0 ? (
          <p className="text-center py-8 text-xs text-slate-400 font-bold">
            {isAr ? 'لا يوجد موظفون مضافون بعد' : 'No employees added'}
          </p>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-3">
            {filteredEmployees.map((emp) => {
              const isSelected = selectedEmpId === emp.id;
              return (
                <div
                  key={emp.id}
                  onClick={() => setSelectedEmpId(isSelected ? 'all' : emp.id)}
                  className={`p-4 rounded-3xl border cursor-pointer transition-all ${
                    isSelected
                      ? 'bg-indigo-50/80 dark:bg-indigo-950/40 border-indigo-400 dark:border-indigo-600 shadow-md ring-2 ring-indigo-500/20'
                      : 'bg-white dark:bg-slate-800/40 border-slate-200 dark:border-slate-800 hover:border-slate-300'
                  }`}
                >
                  <div className="flex items-center justify-between mb-2">
                    <span className="font-black text-xs text-slate-900 dark:text-slate-100">{emp.name}</span>
                    <span className="text-[10px] text-slate-500">{emp.phone || '-'}</span>
                  </div>
                  <div className="space-y-1 text-xs">
                    <div className="flex justify-between">
                      <span className="text-slate-500">{isAr ? 'الراتب الأساسي:' : 'Salary:'}</span>
                      <span className="font-bold text-slate-800 dark:text-slate-200 font-mono">
                        {(emp.baseSalary || 0).toLocaleString()} د.ع
                      </span>
                    </div>
                    <div className="flex justify-between">
                      <span className="text-slate-500">{isAr ? 'رصيد السلف/الديون:' : 'Debt Balance:'}</span>
                      <span className="font-black text-rose-600 dark:text-rose-400 font-mono">
                        {(emp.debtBalance || 0).toLocaleString()} د.ع
                      </span>
                    </div>
                  </div>
                  {onDeleteEmployee && (
                    <div className="mt-3 pt-2 border-t border-slate-200 dark:border-slate-700/60 flex justify-end">
                      <button
                        onClick={(e) => {
                          e.stopPropagation();
                          if (confirm(isAr ? 'هل تريد حذف هذا الموظف؟' : 'Delete employee?')) {
                            onDeleteEmployee(emp.id);
                          }
                        }}
                        className="text-rose-500 hover:text-rose-700 text-xs font-bold p-1"
                      >
                        <Trash2 className="w-3.5 h-3.5" />
                      </button>
                    </div>
                  )}
                </div>
              );
            })}
          </div>
        )}
      </div>

      {/* Transactions list */}
      <div className="bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-3xl p-5 shadow-sm">
        <h3 className="text-xs font-black text-slate-800 dark:text-slate-200 mb-3">
          {isAr ? 'سجل حركات السلف والرواتب:' : 'Debt & Advance Transactions:'}
        </h3>
        {filteredTransactions.length === 0 ? (
          <p className="text-center py-6 text-xs text-slate-400 font-bold">
            {isAr ? 'لا توجد حركات سلف مسجلة' : 'No transactions'}
          </p>
        ) : (
          <div className="space-y-1.5 max-h-80 overflow-y-auto">
            {filteredTransactions.map((tx) => {
              const isRepayment = tx.type === 'repayment';
              const targetEmp = employees.find((e) => e.id === tx.employeeId);
              return (
                <div
                  key={tx.id}
                  className="p-3 rounded-2xl border border-slate-200 dark:border-slate-800 flex items-center justify-between text-xs"
                >
                  <div className="flex items-center gap-2">
                    <div
                      className={`w-7 h-7 rounded-xl flex items-center justify-center ${
                        isRepayment
                          ? 'bg-emerald-50 dark:bg-emerald-950/60 text-emerald-600'
                          : 'bg-rose-50 dark:bg-rose-950/60 text-rose-600'
                      }`}
                    >
                      {isRepayment ? <ArrowDownLeft className="w-4 h-4" /> : <ArrowUpRight className="w-4 h-4" />}
                    </div>
                    <div>
                      <p className="font-extrabold text-slate-900 dark:text-slate-100">
                        {targetEmp?.name || 'موظف'} • {tx.note || (isRepayment ? 'تسديد سلفة' : 'صرف سلفة')}
                      </p>
                      <p className="text-[10px] text-slate-500">
                        {tx.createdAt ? new Date(tx.createdAt).toLocaleDateString('ar-IQ') : ''}
                      </p>
                    </div>
                  </div>
                  <span
                    className={`font-black font-mono ${
                      isRepayment ? 'text-emerald-600 dark:text-emerald-400' : 'text-rose-600 dark:text-rose-400'
                    }`}
                  >
                    {isRepayment ? '-' : '+'}{(tx.amount || 0).toLocaleString()} د.ع
                  </span>
                </div>
              );
            })}
          </div>
        )}
      </div>

      {/* Add Employee Modal */}
      {showAddEmpModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-3 bg-slate-950/80 backdrop-blur-md">
          <form onSubmit={handleCreateEmployee} className="bg-white dark:bg-slate-900 p-5 rounded-3xl max-w-sm w-full space-y-3">
            <h4 className="font-black text-sm">{isAr ? 'إضافة موظف جديد' : 'New Employee'}</h4>
            <input
              type="text"
              required
              value={empName}
              onChange={(e) => setEmpName(e.target.value)}
              placeholder={isAr ? 'اسم الموظف' : 'Name'}
              className="w-full px-3 py-2 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-bold"
            />
            <input
              type="text"
              value={empPhone}
              onChange={(e) => setEmpPhone(e.target.value)}
              placeholder={isAr ? 'رقم الهاتف' : 'Phone'}
              className="w-full px-3 py-2 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-bold"
            />
            <input
              type="number"
              value={empSalary}
              onChange={(e) => setEmpSalary(e.target.value)}
              placeholder={isAr ? 'الراتب الأساسي' : 'Salary'}
              className="w-full px-3 py-2 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-bold"
            />
            <div className="flex justify-end gap-2 pt-2">
              <button
                type="button"
                onClick={() => setShowAddEmpModal(false)}
                className="px-3 py-1.5 rounded-xl border border-slate-300 text-xs font-bold"
              >
                {isAr ? 'إلغاء' : 'Cancel'}
              </button>
              <button
                type="submit"
                className="px-4 py-1.5 rounded-xl bg-indigo-600 text-white text-xs font-black shadow-sm"
              >
                {isAr ? 'إضافة' : 'Add'}
              </button>
            </div>
          </form>
        </div>
      )}

      {/* Debt / Advance Modal */}
      {showDebtModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-3 bg-slate-950/80 backdrop-blur-md">
          <form onSubmit={handleDebtSubmit} className="bg-white dark:bg-slate-900 p-5 rounded-3xl max-w-sm w-full space-y-3">
            <h4 className="font-black text-sm">{isAr ? 'صرف سلفة أو تسديد' : 'Debt Transaction'}</h4>
            <div className="flex gap-2">
              <button
                type="button"
                onClick={() => setDebtType('advance')}
                className={`flex-1 py-2 rounded-xl text-xs font-black ${debtType === 'advance' ? 'bg-rose-600 text-white' : 'bg-slate-100 dark:bg-slate-800'}`}
              >
                {isAr ? 'صرف سلفة (+)' : 'Advance (+)'}
              </button>
              <button
                type="button"
                onClick={() => setDebtType('repayment')}
                className={`flex-1 py-2 rounded-xl text-xs font-black ${debtType === 'repayment' ? 'bg-emerald-600 text-white' : 'bg-slate-100 dark:bg-slate-800'}`}
              >
                {isAr ? 'تسديد سلفة (-)' : 'Repayment (-)'}
              </button>
            </div>
            <select
              value={targetEmpId}
              onChange={(e) => setTargetEmpId(e.target.value)}
              className="w-full px-3 py-2 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-bold"
            >
              {employees.map((e) => (
                <option key={e.id} value={e.id}>{e.name} (دين: {(e.debtBalance || 0).toLocaleString()} د.ع)</option>
              ))}
            </select>
            <select
              value={debtFundId}
              onChange={(e) => setDebtFundId(e.target.value)}
              className="w-full px-3 py-2 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-bold"
            >
              {funds.map((f) => (
                <option key={f.id} value={f.id}>{f.name} ({(f.balance || 0).toLocaleString()} د.ع)</option>
              ))}
            </select>
            <input
              type="number"
              required
              min="1"
              value={debtAmount}
              onChange={(e) => setDebtAmount(e.target.value)}
              placeholder={isAr ? 'المبلغ بالدينار' : 'Amount'}
              className="w-full px-3 py-2 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-black"
            />
            <input
              type="text"
              value={debtNote}
              onChange={(e) => setDebtNote(e.target.value)}
              placeholder={isAr ? 'الملاحظة أو السبب' : 'Note'}
              className="w-full px-3 py-2 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-bold"
            />
            <div className="flex justify-end gap-2 pt-2">
              <button
                type="button"
                onClick={() => setShowDebtModal(false)}
                className="px-3 py-1.5 rounded-xl border border-slate-300 text-xs font-bold"
              >
                {isAr ? 'إلغاء' : 'Cancel'}
              </button>
              <button
                type="submit"
                className="px-4 py-1.5 rounded-xl bg-indigo-600 text-white text-xs font-black shadow-sm"
              >
                {isAr ? 'تأكيد الحركة' : 'Confirm'}
              </button>
            </div>
          </form>
        </div>
      )}
    </div>
  );
};
