import React, { useState } from 'react';
import {
  Wallet,
  Plus,
  ArrowRightLeft,
  ArrowDownLeft,
  ArrowUpRight,
  RefreshCw,
  FolderOpen,
  DollarSign,
  TrendingUp,
  Trash2,
  Calendar,
  Layers,
  ChevronRight
} from 'lucide-react';
import { CashFund, CustomerList, FundTransaction, SalesRepresentative, Language, InstallmentContract } from '../types';

interface FundsViewProps {
  funds: CashFund[];
  customerLists: CustomerList[];
  transactions?: FundTransaction[];
  currentRep: SalesRepresentative | null;
  lang?: Language;
  contracts?: InstallmentContract[];
  onAddFund?: (fund: any) => Promise<void>;
  onUpdateFund?: (id: string, updates: any) => Promise<void>;
  onDeleteFund?: (id: string) => Promise<void>;
  onReorderFunds?: (orderedIds: string[]) => Promise<void>;
  onReorderLists?: (orderedIds: string[]) => Promise<void>;
  onRecalculateBalances?: () => Promise<void>;
  onAddDepositOrWithdrawal?: (data: any) => Promise<void>;
  onTransfer?: (data: any) => Promise<void>;
  onAddList?: (data: any) => Promise<void>;
  onUpdateList?: (id: string, data: any) => Promise<void>;
  onDeleteList?: (id: string) => Promise<void>;
  onDeleteFundTransaction?: (id: string) => Promise<void>;
  onUpdateFundTransaction?: (id: string, updates: any) => Promise<void>;
}

export const FundsView: React.FC<FundsViewProps> = ({
  funds = [],
  customerLists = [],
  transactions = [],
  currentRep,
  lang = 'ar',
  onAddFund,
  onRecalculateBalances,
  onAddDepositOrWithdrawal,
  onTransfer,
  onAddList,
  onDeleteFund,
  onDeleteList,
}) => {
  const isAr = lang === 'ar';
  const [selectedFundId, setSelectedFundId] = useState<string>(funds[0]?.id || 'all');
  const [showDepositModal, setShowDepositModal] = useState<boolean>(false);
  const [showTransferModal, setShowTransferModal] = useState<boolean>(false);
  const [showAddFundModal, setShowAddFundModal] = useState<boolean>(false);
  const [showAddListModal, setShowAddListModal] = useState<boolean>(false);

  // Form states
  const [fundName, setFundName] = useState('');
  const [listName, setListName] = useState('');
  const [listTargetFundId, setListTargetFundId] = useState(funds[0]?.id || '');
  const [txType, setTxType] = useState<'deposit' | 'withdrawal'>('deposit');
  const [txAmount, setTxAmount] = useState('');
  const [txFundId, setTxFundId] = useState(funds[0]?.id || '');
  const [txNote, setTxNote] = useState('');

  // Transfer state
  const [fromFundId, setFromFundId] = useState(funds[0]?.id || '');
  const [toFundId, setToFundId] = useState(funds[1]?.id || '');
  const [transferAmount, setTransferAmount] = useState('');
  const [transferNote, setTransferNote] = useState('');

  const totalFundsBalance = funds.reduce((sum, f) => sum + (f.balance || 0), 0);

  const filteredTransactions = selectedFundId === 'all'
    ? transactions
    : transactions.filter((t) => t.fundId === selectedFundId || t.targetFundId === selectedFundId);

  const handleDepositWithdraw = async (e: React.FormEvent) => {
    e.preventDefault();
    const amt = Number(txAmount);
    if (!amt || !txFundId || !onAddDepositOrWithdrawal) return;

    await onAddDepositOrWithdrawal({
      fundId: txFundId,
      type: txType,
      amount: amt,
      note: txNote.trim(),
      repName: currentRep?.name || 'المدير',
    });

    setTxAmount('');
    setTxNote('');
    setShowDepositModal(false);
  };

  const handleTransferSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const amt = Number(transferAmount);
    if (!amt || !fromFundId || !toFundId || fromFundId === toFundId || !onTransfer) return;

    await onTransfer({
      sourceFundId: fromFundId,
      targetFundId: toFundId,
      amount: amt,
      note: transferNote.trim(),
      repName: currentRep?.name || 'المدير',
    });

    setTransferAmount('');
    setTransferNote('');
    setShowTransferModal(false);
  };

  const handleCreateFund = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!fundName.trim() || !onAddFund) return;
    await onAddFund({ name: fundName.trim(), balance: 0 });
    setFundName('');
    setShowAddFundModal(false);
  };

  const handleCreateList = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!listName.trim() || !onAddList) return;
    await onAddList({ name: listName.trim(), fundId: listTargetFundId || funds[0]?.id });
    setListName('');
    setShowAddListModal(false);
  };

  return (
    <div className="space-y-4 max-w-7xl mx-auto p-2 sm:p-4 dir-rtl">
      {/* Overview header */}
      <div className="bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-3xl p-5 shadow-sm flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div className="flex items-center gap-3">
          <div className="w-12 h-12 rounded-2xl bg-indigo-50 dark:bg-indigo-950/60 text-indigo-600 dark:text-indigo-400 flex items-center justify-center">
            <Wallet className="w-6 h-6" />
          </div>
          <div>
            <h2 className="text-base font-black text-slate-900 dark:text-slate-100">
              {isAr ? 'إدارة الصناديق وحركات النقد' : 'Cash Funds & Accounts'}
            </h2>
            <p className="text-xs text-slate-500">
              {isAr ? 'رصيد الخزينة الإجمالي: ' : 'Total Cash Balance: '}
              <strong className="text-emerald-600 dark:text-emerald-400 text-sm font-black">
                {totalFundsBalance.toLocaleString()} د.ع
              </strong>
            </p>
          </div>
        </div>

        {/* Action buttons */}
        <div className="flex flex-wrap gap-2">
          {onRecalculateBalances && (
            <button
              onClick={() => onRecalculateBalances()}
              className="px-3.5 py-2 rounded-xl bg-slate-100 dark:bg-slate-800 text-slate-700 dark:text-slate-300 font-bold text-xs flex items-center gap-1.5 hover:bg-slate-200 transition-colors"
            >
              <RefreshCw className="w-3.5 h-3.5" />
              <span>{isAr ? 'إعادة مطابقة الأرصدة' : 'Recalculate'}</span>
            </button>
          )}
          <button
            onClick={() => setShowDepositModal(true)}
            className="px-3.5 py-2 rounded-xl bg-emerald-600 hover:bg-emerald-700 text-white font-bold text-xs flex items-center gap-1.5 shadow-sm transition-colors"
          >
            <ArrowDownLeft className="w-3.5 h-3.5" />
            <span>{isAr ? 'إيداع / سحب' : 'Deposit / Withdraw'}</span>
          </button>
          <button
            onClick={() => setShowTransferModal(true)}
            className="px-3.5 py-2 rounded-xl bg-indigo-600 hover:bg-indigo-700 text-white font-bold text-xs flex items-center gap-1.5 shadow-sm transition-colors"
          >
            <ArrowRightLeft className="w-3.5 h-3.5" />
            <span>{isAr ? 'تحويل بين الصناديق' : 'Transfer'}</span>
          </button>
          <button
            onClick={() => setShowAddFundModal(true)}
            className="px-3.5 py-2 rounded-xl border border-slate-300 dark:border-slate-700 text-slate-700 dark:text-slate-300 font-bold text-xs flex items-center gap-1.5 hover:bg-slate-50 dark:hover:bg-slate-800"
          >
            <Plus className="w-3.5 h-3.5" />
            <span>{isAr ? 'صندوق جديد' : 'New Fund'}</span>
          </button>
          <button
            onClick={() => setShowAddListModal(true)}
            className="px-3.5 py-2 rounded-xl border border-slate-300 dark:border-slate-700 text-slate-700 dark:text-slate-300 font-bold text-xs flex items-center gap-1.5 hover:bg-slate-50 dark:hover:bg-slate-800"
          >
            <Layers className="w-3.5 h-3.5" />
            <span>{isAr ? 'قائمة جديدة' : 'New List'}</span>
          </button>
        </div>
      </div>

      {/* Funds Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-3">
        {funds.map((fund) => {
          const isSelected = selectedFundId === fund.id;
          return (
            <div
              key={fund.id}
              onClick={() => setSelectedFundId(isSelected ? 'all' : fund.id)}
              className={`p-4 rounded-3xl border cursor-pointer transition-all ${
                isSelected
                  ? 'bg-indigo-50/80 dark:bg-indigo-950/40 border-indigo-400 dark:border-indigo-600 shadow-md ring-2 ring-indigo-500/20'
                  : 'bg-white dark:bg-slate-900 border-slate-200 dark:border-slate-800 hover:border-slate-300'
              }`}
            >
              <div className="flex items-center justify-between mb-2">
                <span className="font-extrabold text-xs text-slate-800 dark:text-slate-100">{fund.name}</span>
                <Wallet className="w-4 h-4 text-indigo-500" />
              </div>
              <p className="text-lg font-black text-slate-900 dark:text-slate-100 mb-1">
                {(fund.balance || 0).toLocaleString()} د.ع
              </p>
              <div className="flex items-center justify-between text-[10px] text-slate-500">
                <span>{customerLists.filter((l) => l.fundId === fund.id).length} قوائم مرتبطة</span>
                {onDeleteFund && funds.length > 1 && (
                  <button
                    onClick={(e) => {
                      e.stopPropagation();
                      if (confirm(isAr ? 'هل تريد حذف هذا الصندوق؟' : 'Delete fund?')) {
                        onDeleteFund(fund.id);
                      }
                    }}
                    className="text-rose-500 hover:text-rose-700 p-1"
                  >
                    <Trash2 className="w-3.5 h-3.5" />
                  </button>
                )}
              </div>
            </div>
          );
        })}
      </div>

      {/* Customer Lists section */}
      <div className="bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-3xl p-5 shadow-sm">
        <h3 className="text-xs font-black text-slate-800 dark:text-slate-200 mb-3 flex items-center gap-2">
          <Layers className="w-4 h-4 text-indigo-500" />
          <span>{isAr ? 'القوائم وفئات الزبائن' : 'Customer Lists'}</span>
        </h3>
        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-2">
          {customerLists.map((list) => {
            const linkedFund = funds.find((f) => f.id === list.fundId);
            return (
              <div
                key={list.id}
                className="p-3 rounded-2xl border border-slate-200 dark:border-slate-800 bg-slate-50 dark:bg-slate-800/40 flex items-center justify-between"
              >
                <div>
                  <h4 className="font-bold text-xs text-slate-900 dark:text-slate-100">{list.name}</h4>
                  <p className="text-[10px] text-slate-500">
                    {isAr ? 'الصندوق: ' : 'Fund: '}{linkedFund?.name || 'غير محدد'}
                  </p>
                </div>
                {onDeleteList && customerLists.length > 1 && (
                  <button
                    onClick={() => {
                      if (confirm(isAr ? 'هل تريد حذف هذه القائمة؟' : 'Delete list?')) {
                        onDeleteList(list.id);
                      }
                    }}
                    className="text-rose-500 hover:text-rose-700 p-1"
                  >
                    <Trash2 className="w-3.5 h-3.5" />
                  </button>
                )}
              </div>
            );
          })}
        </div>
      </div>

      {/* Fund Transactions Table */}
      <div className="bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-3xl p-5 shadow-sm">
        <div className="flex items-center justify-between mb-3">
          <h3 className="text-xs font-black text-slate-800 dark:text-slate-200">
            {isAr ? 'سجل حركات الصندوق الأخيرة:' : 'Recent Fund Transactions:'}
          </h3>
          <span className="text-[10px] text-slate-500 font-bold">
            {filteredTransactions.length} حركة
          </span>
        </div>

        {filteredTransactions.length === 0 ? (
          <p className="text-center py-8 text-xs text-slate-400 font-bold">
            {isAr ? 'لا توجد حركات نقدية مسجلة بعد' : 'No transactions recorded'}
          </p>
        ) : (
          <div className="space-y-1.5 max-h-96 overflow-y-auto">
            {filteredTransactions.map((tx) => {
              const isDeposit = tx.type === 'deposit';
              const isWithdrawal = tx.type === 'withdrawal';
              const isTransfer = tx.type === 'transfer';
              return (
                <div
                  key={tx.id}
                  className="p-3 rounded-2xl border border-slate-200 dark:border-slate-800 flex items-center justify-between text-xs"
                >
                  <div className="flex items-center gap-3">
                    <div
                      className={`w-8 h-8 rounded-xl flex items-center justify-center ${
                        isDeposit
                          ? 'bg-emerald-50 dark:bg-emerald-950/60 text-emerald-600'
                          : isWithdrawal
                          ? 'bg-rose-50 dark:bg-rose-950/60 text-rose-600'
                          : 'bg-indigo-50 dark:bg-indigo-950/60 text-indigo-600'
                      }`}
                    >
                      {isDeposit ? <ArrowDownLeft className="w-4 h-4" /> : isWithdrawal ? <ArrowUpRight className="w-4 h-4" /> : <ArrowRightLeft className="w-4 h-4" />}
                    </div>
                    <div>
                      <p className="font-extrabold text-slate-900 dark:text-slate-100">
                        {tx.note || (isDeposit ? 'إيداع نقدي' : isWithdrawal ? 'سحب نقدي' : 'تحويل')}
                      </p>
                      <p className="text-[10px] text-slate-500">
                        {tx.repName || 'المدير'} • {tx.createdAt ? new Date(tx.createdAt).toLocaleDateString('ar-IQ') : ''}
                      </p>
                    </div>
                  </div>
                  <span
                    className={`font-black font-mono ${
                      isDeposit
                        ? 'text-emerald-600 dark:text-emerald-400'
                        : isWithdrawal
                        ? 'text-rose-600 dark:text-rose-400'
                        : 'text-indigo-600 dark:text-indigo-400'
                    }`}
                  >
                    {isWithdrawal ? '-' : '+'}{(tx.amount || 0).toLocaleString()} د.ع
                  </span>
                </div>
              );
            })}
          </div>
        )}
      </div>

      {/* Modals for deposit, transfer, add fund, add list */}
      {showDepositModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-3 bg-slate-950/80 backdrop-blur-md">
          <form onSubmit={handleDepositWithdraw} className="bg-white dark:bg-slate-900 p-5 rounded-3xl max-w-sm w-full space-y-3">
            <h4 className="font-black text-sm">{isAr ? 'تسجيل إيداع / سحب' : 'Deposit / Withdraw'}</h4>
            <div className="flex gap-2">
              <button
                type="button"
                onClick={() => setTxType('deposit')}
                className={`flex-1 py-2 rounded-xl text-xs font-black ${txType === 'deposit' ? 'bg-emerald-600 text-white' : 'bg-slate-100 dark:bg-slate-800'}`}
              >
                {isAr ? 'إيداع (+)' : 'Deposit (+)'}
              </button>
              <button
                type="button"
                onClick={() => setTxType('withdrawal')}
                className={`flex-1 py-2 rounded-xl text-xs font-black ${txType === 'withdrawal' ? 'bg-rose-600 text-white' : 'bg-slate-100 dark:bg-slate-800'}`}
              >
                {isAr ? 'سحب (-)' : 'Withdraw (-)'}
              </button>
            </div>
            <select
              value={txFundId}
              onChange={(e) => setTxFundId(e.target.value)}
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
              value={txAmount}
              onChange={(e) => setTxAmount(e.target.value)}
              placeholder={isAr ? 'المبلغ بالدينار' : 'Amount'}
              className="w-full px-3 py-2 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-black"
            />
            <input
              type="text"
              value={txNote}
              onChange={(e) => setTxNote(e.target.value)}
              placeholder={isAr ? 'ملاحظة الحركة' : 'Note'}
              className="w-full px-3 py-2 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-bold"
            />
            <div className="flex justify-end gap-2 pt-2">
              <button
                type="button"
                onClick={() => setShowDepositModal(false)}
                className="px-3 py-1.5 rounded-xl border border-slate-300 text-xs font-bold"
              >
                {isAr ? 'إلغاء' : 'Cancel'}
              </button>
              <button
                type="submit"
                className="px-4 py-1.5 rounded-xl bg-emerald-600 text-white text-xs font-black shadow-sm"
              >
                {isAr ? 'تأكيد' : 'Confirm'}
              </button>
            </div>
          </form>
        </div>
      )}

      {showTransferModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-3 bg-slate-950/80 backdrop-blur-md">
          <form onSubmit={handleTransferSubmit} className="bg-white dark:bg-slate-900 p-5 rounded-3xl max-w-sm w-full space-y-3">
            <h4 className="font-black text-sm">{isAr ? 'تحويل بين الصناديق' : 'Transfer Funds'}</h4>
            <div>
              <label className="text-[10px] text-slate-500 font-bold block mb-1">{isAr ? 'من الصندوق:' : 'From Fund:'}</label>
              <select
                value={fromFundId}
                onChange={(e) => setFromFundId(e.target.value)}
                className="w-full px-3 py-2 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-bold"
              >
                {funds.map((f) => (
                  <option key={f.id} value={f.id}>{f.name} ({(f.balance || 0).toLocaleString()} د.ع)</option>
                ))}
              </select>
            </div>
            <div>
              <label className="text-[10px] text-slate-500 font-bold block mb-1">{isAr ? 'إلى الصندوق:' : 'To Fund:'}</label>
              <select
                value={toFundId}
                onChange={(e) => setToFundId(e.target.value)}
                className="w-full px-3 py-2 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-bold"
              >
                {funds.map((f) => (
                  <option key={f.id} value={f.id}>{f.name} ({(f.balance || 0).toLocaleString()} د.ع)</option>
                ))}
              </select>
            </div>
            <input
              type="number"
              required
              min="1"
              value={transferAmount}
              onChange={(e) => setTransferAmount(e.target.value)}
              placeholder={isAr ? 'المبلغ المحول' : 'Amount'}
              className="w-full px-3 py-2 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-black"
            />
            <input
              type="text"
              value={transferNote}
              onChange={(e) => setTransferNote(e.target.value)}
              placeholder={isAr ? 'ملاحظة التحويل' : 'Note'}
              className="w-full px-3 py-2 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-bold"
            />
            <div className="flex justify-end gap-2 pt-2">
              <button
                type="button"
                onClick={() => setShowTransferModal(false)}
                className="px-3 py-1.5 rounded-xl border border-slate-300 text-xs font-bold"
              >
                {isAr ? 'إلغاء' : 'Cancel'}
              </button>
              <button
                type="submit"
                className="px-4 py-1.5 rounded-xl bg-indigo-600 text-white text-xs font-black shadow-sm"
              >
                {isAr ? 'تحويل الآن' : 'Transfer'}
              </button>
            </div>
          </form>
        </div>
      )}

      {showAddFundModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-3 bg-slate-950/80 backdrop-blur-md">
          <form onSubmit={handleCreateFund} className="bg-white dark:bg-slate-900 p-5 rounded-3xl max-w-sm w-full space-y-3">
            <h4 className="font-black text-sm">{isAr ? 'إضافة صندوق كاش جديد' : 'New Cash Fund'}</h4>
            <input
              type="text"
              required
              value={fundName}
              onChange={(e) => setFundName(e.target.value)}
              placeholder={isAr ? 'اسم الصندوق (مثال: صندوق فرع 1)' : 'Fund name'}
              className="w-full px-3 py-2.5 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-bold"
            />
            <div className="flex justify-end gap-2 pt-2">
              <button
                type="button"
                onClick={() => setShowAddFundModal(false)}
                className="px-3 py-1.5 rounded-xl border border-slate-300 text-xs font-bold"
              >
                {isAr ? 'إلغاء' : 'Cancel'}
              </button>
              <button
                type="submit"
                className="px-4 py-1.5 rounded-xl bg-indigo-600 text-white text-xs font-black"
              >
                {isAr ? 'إنشاء الصندوق' : 'Create'}
              </button>
            </div>
          </form>
        </div>
      )}

      {showAddListModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-3 bg-slate-950/80 backdrop-blur-md">
          <form onSubmit={handleCreateList} className="bg-white dark:bg-slate-900 p-5 rounded-3xl max-w-sm w-full space-y-3">
            <h4 className="font-black text-sm">{isAr ? 'إضافة قائمة زبائن جديدة' : 'New Customer List'}</h4>
            <input
              type="text"
              required
              value={listName}
              onChange={(e) => setListName(e.target.value)}
              placeholder={isAr ? 'اسم القائمة (مثال: زبائن بغداد)' : 'List name'}
              className="w-full px-3 py-2.5 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-bold"
            />
            <div>
              <label className="text-[10px] text-slate-500 font-bold block mb-1">{isAr ? 'ربط بالصندوق:' : 'Link to Fund:'}</label>
              <select
                value={listTargetFundId}
                onChange={(e) => setListTargetFundId(e.target.value)}
                className="w-full px-3 py-2 rounded-xl border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs font-bold"
              >
                {funds.map((f) => (
                  <option key={f.id} value={f.id}>{f.name}</option>
                ))}
              </select>
            </div>
            <div className="flex justify-end gap-2 pt-2">
              <button
                type="button"
                onClick={() => setShowAddListModal(false)}
                className="px-3 py-1.5 rounded-xl border border-slate-300 text-xs font-bold"
              >
                {isAr ? 'إلغاء' : 'Cancel'}
              </button>
              <button
                type="submit"
                className="px-4 py-1.5 rounded-xl bg-indigo-600 text-white text-xs font-black"
              >
                {isAr ? 'إنشاء القائمة' : 'Create'}
              </button>
            </div>
          </form>
        </div>
      )}
    </div>
  );
};
