import React, { useState, useMemo } from 'react';
import { 
  Calendar, Clock, Check, Phone, DollarSign, Trash2, X, Search, 
  Filter, CheckCircle2, AlertCircle, User, Sparkles, Plus, Info, RefreshCw
} from 'lucide-react';
import { Appointment, InstallmentContract, SalesRepresentative, Language } from '../types';

const formatAppointmentTime = (timeStr?: string, isArabic = true): string => {
  if (!timeStr) return '';
  if (timeStr.includes('ص') || timeStr.includes('م') || timeStr.includes('AM') || timeStr.includes('PM')) {
    return timeStr;
  }
  const parts = timeStr.split(':');
  if (parts.length >= 2) {
    const hours = parseInt(parts[0], 10);
    const minutes = parts[1];
    if (!isNaN(hours)) {
      const isPm = hours >= 12;
      const h12 = hours % 12 || 12;
      const suffix = isArabic ? (isPm ? 'م' : 'ص') : (isPm ? 'PM' : 'AM');
      return `${h12}:${minutes} ${suffix}`;
    }
  }
  return timeStr;
};

interface AppointmentsBoxModalProps {
  isOpen: boolean;
  onClose: () => void;
  appointments: Appointment[];
  contracts: InstallmentContract[];
  reps?: SalesRepresentative[];
  currentRep: SalesRepresentative | null;
  isAdmin: boolean;
  lang?: Language;
  onToggleComplete: (appt: Appointment) => Promise<void> | void;
  onDelete: (apptId: string) => Promise<void> | void;
  onQuickPay?: (contract: InstallmentContract) => void;
  onOpenCustomerModal?: (contract: InstallmentContract) => void;
}

export const AppointmentsBoxModal: React.FC<AppointmentsBoxModalProps> = ({
  isOpen,
  onClose,
  appointments,
  contracts,
  currentRep,
  isAdmin,
  lang = 'ar',
  onToggleComplete,
  onDelete,
  onOpenCustomerModal,
}) => {
  const isAr = lang === 'ar';

  const [searchQuery, setSearchQuery] = useState('');
  const [typeFilter, setTypeFilter] = useState<'all' | 'today' | 'recurring_day' | 'recurring_month' | 'date' | 'completed'>('all');

  const todayDateStr = new Date().toISOString().split('T')[0];
  const todayDayIndex = new Date().getDay(); // 0 is Sunday, 6 is Saturday

  // Permission check for deleting
  const canDeleteAppointment = (appt: Appointment) => {
    if (isAdmin || currentRep?.role === 'admin' || currentRep?.id === 'rep-1' || currentRep?.name?.includes('ضياء')) {
      return true;
    }
    if (appt.createdByRepId && currentRep && appt.createdByRepId === currentRep.id) {
      return true;
    }
    if (appt.createdByName && currentRep && appt.createdByName === currentRep.name) {
      return true;
    }
    return false;
  };

  // Find customer contract details for each appointment
  const contractsMap = useMemo(() => {
    const map = new Map<string, InstallmentContract>();
    contracts.forEach((c) => {
      map.set(c.id, c);
    });
    return map;
  }, [contracts]);

  // Filtered Appointments
  const filteredAppointments = useMemo(() => {
    return appointments.filter((appt) => {
      // 1. Type filter
      if (typeFilter === 'completed') {
        if (appt.status !== 'completed') return false;
      } else if (typeFilter === 'today') {
        const isTodayDate = appt.appointmentType === 'date' && appt.appointmentDate === todayDateStr;
        const isTodayRecurring = appt.appointmentType === 'recurring_day' && appt.recurringDay === todayDayIndex;
        const isTodayMonth = appt.appointmentType === 'recurring_month' && appt.recurringMonthDay === new Date().getDate();
        if (!isTodayDate && !isTodayRecurring && !isTodayMonth) return false;
      } else if (typeFilter === 'recurring_day') {
        if (appt.appointmentType !== 'recurring_day') return false;
      } else if (typeFilter === 'recurring_month') {
        if (appt.appointmentType !== 'recurring_month') return false;
      } else if (typeFilter === 'date') {
        if (appt.appointmentType !== 'date') return false;
      }

      // 2. Search query
      if (searchQuery.trim()) {
        const q = searchQuery.toLowerCase();
        const matchesName = appt.customerName?.toLowerCase().includes(q);
        const matchesPhone = appt.customerPhone?.includes(q);
        const matchesNote = appt.note?.toLowerCase().includes(q);
        const matchesList = appt.listName?.toLowerCase().includes(q);
        const matchesRep = appt.createdByName?.toLowerCase().includes(q);
        if (!matchesName && !matchesPhone && !matchesNote && !matchesList && !matchesRep) return false;
      }

      return true;
    });
  }, [appointments, typeFilter, searchQuery, todayDateStr, todayDayIndex]);

  // Statistics
  const todayCount = useMemo(() => {
    return appointments.filter((a) => {
      if (a.status === 'completed') return false;
      if (a.appointmentType === 'date' && a.appointmentDate === todayDateStr) return true;
      if (a.appointmentType === 'recurring_day' && a.recurringDay === todayDayIndex) return true;
      if (a.appointmentType === 'recurring_month' && a.recurringMonthDay === new Date().getDate()) return true;
      return false;
    }).length;
  }, [appointments, todayDateStr, todayDayIndex]);

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 bg-black/60 backdrop-blur-xs flex items-center justify-center p-2 sm:p-4 md:p-6 animate-fadeIn" dir="rtl">
      <div className="bg-white dark:bg-slate-800 rounded-3xl w-full max-w-6xl max-h-[94vh] flex flex-col shadow-2xl border border-slate-200 dark:border-slate-700 overflow-hidden">
        
        {/* Header */}
        <div className="p-4 sm:p-5 bg-gradient-to-r from-purple-700 via-indigo-600 to-purple-600 text-white flex items-center justify-between shrink-0 shadow-sm">
          <div className="flex items-center gap-3.5">
            <div className="w-11 h-11 rounded-2xl bg-white/20 backdrop-blur-xs flex items-center justify-center shadow-inner">
              <Calendar className="w-6 h-6 text-white" />
            </div>
            <div>
              <div className="flex items-center gap-2.5">
                <h3 className="text-base sm:text-lg font-black">
                  {isAr ? 'صندوق المواعيد وجدول التحصيل' : 'Appointments & Collection Box'}
                </h3>
                <span className="text-xs bg-white/20 text-purple-100 font-extrabold px-2.5 py-0.5 rounded-full">
                  {appointments.length} {isAr ? 'موعد إجمالي' : 'Total Appts'}
                </span>
              </div>
              <p className="text-xs text-purple-100 font-bold mt-0.5">
                {isAr
                  ? 'مواعيد الأقساط الأسبوعية، الشهرية والمحددة بتواريخ'
                  : 'Weekly, monthly and scheduled installment dates'}
              </p>
            </div>
          </div>
          <button
            type="button"
            onClick={onClose}
            className="w-9 h-9 rounded-full bg-white/20 hover:bg-white/30 flex items-center justify-center transition-colors"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Top Controls: Search Bar & Tabs */}
        <div className="p-3 sm:p-4 bg-slate-50 dark:bg-slate-900/60 border-b border-slate-200 dark:border-slate-700 flex flex-col md:flex-row gap-3 items-center justify-between">
          <div className="relative w-full md:w-96">
            <Search className="w-4 h-4 text-slate-400 absolute right-3.5 top-3" />
            <input
              type="text"
              placeholder={isAr ? 'بحث سريع باسم الزبون أو الهاتف أو القائمة أو الملاحظة...' : 'Search customer, phone, note...'}
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="w-full bg-white dark:bg-slate-800 pr-10 pl-3 py-2 rounded-xl border border-slate-200 dark:border-slate-700 text-xs sm:text-sm font-bold focus:outline-none focus:border-purple-500 shadow-2xs"
            />
          </div>

          {/* Filter Tabs Bar */}
          <div className="w-full md:w-auto overflow-x-auto no-scrollbar flex items-center gap-1.5 justify-start md:justify-end">
            <button
              type="button"
              onClick={() => setTypeFilter('all')}
              className={`px-3.5 py-1.5 rounded-xl text-xs sm:text-sm font-extrabold whitespace-nowrap transition-all ${
                typeFilter === 'all'
                  ? 'bg-purple-600 text-white shadow-xs'
                  : 'bg-white dark:bg-slate-800 text-slate-700 dark:text-slate-300 border border-slate-200 dark:border-slate-700 hover:bg-slate-100 dark:hover:bg-slate-700'
              }`}
            >
              {isAr ? 'الكل' : 'All'} ({appointments.length})
            </button>

            <button
              type="button"
              onClick={() => setTypeFilter('today')}
              className={`px-3.5 py-1.5 rounded-xl text-xs sm:text-sm font-extrabold whitespace-nowrap transition-all flex items-center gap-1.5 ${
                typeFilter === 'today'
                  ? 'bg-purple-600 text-white shadow-xs'
                  : 'bg-white dark:bg-slate-800 text-slate-700 dark:text-slate-300 border border-slate-200 dark:border-slate-700 hover:bg-slate-100 dark:hover:bg-slate-700'
              }`}
            >
              <Clock className="w-4 h-4 text-amber-500" />
              <span>{isAr ? 'مواعيد اليوم' : 'Today'}</span>
              <span className="bg-amber-100 dark:bg-amber-950 text-amber-800 dark:text-amber-300 px-2 py-0.5 rounded-full text-[11px] font-mono">
                {todayCount}
              </span>
            </button>

            <button
              type="button"
              onClick={() => setTypeFilter('recurring_day')}
              className={`px-3.5 py-1.5 rounded-xl text-xs sm:text-sm font-extrabold whitespace-nowrap transition-all ${
                typeFilter === 'recurring_day'
                  ? 'bg-purple-600 text-white shadow-xs'
                  : 'bg-white dark:bg-slate-800 text-slate-700 dark:text-slate-300 border border-slate-200 dark:border-slate-700 hover:bg-slate-100 dark:hover:bg-slate-700'
              }`}
            >
              {isAr ? 'أسبوعية متكررة' : 'Weekly'}
            </button>

            <button
              type="button"
              onClick={() => setTypeFilter('recurring_month')}
              className={`px-3.5 py-1.5 rounded-xl text-xs sm:text-sm font-extrabold whitespace-nowrap transition-all ${
                typeFilter === 'recurring_month'
                  ? 'bg-purple-600 text-white shadow-xs'
                  : 'bg-white dark:bg-slate-800 text-slate-700 dark:text-slate-300 border border-slate-200 dark:border-slate-700 hover:bg-slate-100 dark:hover:bg-slate-700'
              }`}
            >
              {isAr ? 'شهرية متكررة' : 'Monthly'}
            </button>

            <button
              type="button"
              onClick={() => setTypeFilter('date')}
              className={`px-3.5 py-1.5 rounded-xl text-xs sm:text-sm font-extrabold whitespace-nowrap transition-all ${
                typeFilter === 'date'
                  ? 'bg-purple-600 text-white shadow-xs'
                  : 'bg-white dark:bg-slate-800 text-slate-700 dark:text-slate-300 border border-slate-200 dark:border-slate-700 hover:bg-slate-100 dark:hover:bg-slate-700'
              }`}
            >
              {isAr ? 'محددة بتاريخ' : 'Date Specific'}
            </button>

            <button
              type="button"
              onClick={() => setTypeFilter('completed')}
              className={`px-3.5 py-1.5 rounded-xl text-xs sm:text-sm font-extrabold whitespace-nowrap transition-all ${
                typeFilter === 'completed'
                  ? 'bg-purple-600 text-white shadow-xs'
                  : 'bg-white dark:bg-slate-800 text-slate-700 dark:text-slate-300 border border-slate-200 dark:border-slate-700 hover:bg-slate-100 dark:hover:bg-slate-700'
              }`}
            >
              {isAr ? 'المكتملة' : 'Completed'}
            </button>
          </div>
        </div>

        {/* Appointments List Content */}
        <div className="flex-1 overflow-y-auto p-4 sm:p-5 space-y-3">
          {filteredAppointments.length > 0 ? (
            <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
              {filteredAppointments.map((appt, idx) => {
                const contract = contractsMap.get(appt.contractId);
                const remaining = contract ? contract.remainingBalance : 0;
                const isCompleted = appt.status === 'completed';
                const canDel = canDeleteAppointment(appt);

                return (
                  <div
                    key={appt.id ? `appt_${appt.id}` : `appt_idx_${appt.contractId}_${idx}`}
                    className={`rounded-2xl p-4 border transition-all flex flex-col justify-between gap-3 ${
                      isCompleted
                        ? 'bg-slate-50 dark:bg-slate-900/40 border-slate-200 dark:border-slate-800 opacity-60'
                        : 'bg-white dark:bg-slate-800 border-purple-200/80 dark:border-slate-700 hover:border-purple-400 shadow-xs hover:shadow-md'
                    }`}
                  >
                    {/* Upper Info Section */}
                    <div className="flex items-start gap-3.5">
                      <button
                        type="button"
                        onClick={() => onToggleComplete(appt)}
                        className={`w-8 h-8 rounded-xl flex items-center justify-center mt-0.5 transition-all shrink-0 ${
                          isCompleted
                            ? 'bg-emerald-600 text-white shadow-xs'
                            : 'border-2 border-purple-400 hover:bg-purple-50 dark:hover:bg-purple-950 text-transparent'
                        }`}
                        title={isCompleted ? (isAr ? 'إلغاء الإكمال' : 'Unmark') : (isAr ? 'تحديد كمكتمل' : 'Mark Complete')}
                      >
                        <Check className="w-4 h-4 stroke-[3]" />
                      </button>

                      <div className="min-w-0 flex-1">
                        <div className="flex items-center gap-2 flex-wrap">
                          <h4 
                            className={`text-sm sm:text-base font-black text-slate-900 dark:text-slate-100 ${
                              isCompleted ? 'line-through' : ''
                            } ${contract && onOpenCustomerModal ? 'cursor-pointer hover:text-purple-600 dark:hover:text-purple-400' : ''}`}
                            onClick={() => {
                              if (contract && onOpenCustomerModal) {
                                onOpenCustomerModal(contract);
                              }
                            }}
                          >
                            {appt.customerName}
                          </h4>

                          {/* Appointment Type Badge */}
                          <span className="text-[11px] font-black px-2.5 py-0.5 rounded-lg bg-purple-100 dark:bg-purple-950 text-purple-800 dark:text-purple-300 border border-purple-200 dark:border-purple-800">
                            {appt.appointmentType === 'recurring_day' && (appt.recurringDayName || (isAr ? 'أسبوعي' : 'Weekly'))}
                            {appt.appointmentType === 'recurring_month' && (appt.recurringMonthDayName || (isAr ? `يوم ${appt.recurringMonthDay} شهرياً` : `Day ${appt.recurringMonthDay}`)) }
                            {appt.appointmentType === 'date' && `بتاريخ: ${appt.appointmentDate ? appt.appointmentDate.replace(/-/g, '/') : ''}`}
                          </span>

                          {appt.appointmentTime && (
                            <span className="text-[11px] font-bold text-slate-500 dark:text-slate-400 flex items-center gap-1">
                              <Clock className="w-3.5 h-3.5 text-purple-500" />
                              {formatAppointmentTime(appt.appointmentTime, isAr)}
                            </span>
                          )}
                        </div>

                        <div className="flex items-center gap-2 text-xs text-slate-500 dark:text-slate-400 font-bold mt-1.5 flex-wrap">
                          {appt.listName && (
                            <span className="bg-slate-100 dark:bg-slate-700/60 text-slate-700 dark:text-slate-300 px-2 py-0.5 rounded-md text-[11px]">
                              {appt.listName}
                            </span>
                          )}
                          <span>•</span>
                          <span>{isAr ? 'المسؤول:' : 'By:'} <strong className="text-slate-800 dark:text-slate-200">{appt.createdByName || 'المندوب'}</strong></span>
                          {appt.note && (
                            <>
                              <span>•</span>
                              <span className="text-purple-700 dark:text-purple-300 font-semibold">{appt.note}</span>
                            </>
                          )}
                        </div>
                      </div>
                    </div>

                    {/* Bottom Actions & Balance Bar */}
                    <div className="flex items-center justify-between border-t border-slate-100 dark:border-slate-700/80 pt-2.5 mt-1">
                      <div className="flex items-center gap-1.5">
                        <span className="text-[11px] text-slate-400 font-bold">{isAr ? 'المتبقي الحالي:' : 'Remaining:'}</span>
                        <span className={`text-xs sm:text-sm font-black font-mono ${remaining <= 0 ? 'text-emerald-600' : 'text-rose-600'}`}>
                          {remaining.toLocaleString()} د.ع
                        </span>
                      </div>

                      <div className="flex items-center gap-2">
                        {appt.customerPhone && (
                          <a
                            href={`tel:${appt.customerPhone}`}
                            className="px-3 py-1.5 rounded-xl bg-blue-50 dark:bg-blue-950/60 text-blue-600 dark:text-blue-400 hover:bg-blue-100 text-xs font-bold flex items-center gap-1.5 transition-colors"
                            title={isAr ? 'اتصال بالزبون' : 'Call'}
                          >
                            <Phone className="w-3.5 h-3.5" />
                            <span>{isAr ? 'اتصال' : 'Call'}</span>
                          </a>
                        )}

                        {canDel && (
                          <button
                            type="button"
                            onClick={() => {
                              if (confirm(isAr ? 'هل أنت متأكد من حذف هذا الموعد؟' : 'Delete appointment?')) {
                                onDelete(appt.id);
                              }
                            }}
                            className="p-1.5 rounded-xl bg-rose-50 hover:bg-rose-100 dark:bg-rose-950/60 text-rose-600 dark:text-rose-400 transition-colors"
                            title={isAr ? 'حذف الموعد' : 'Delete'}
                          >
                            <Trash2 className="w-4 h-4" />
                          </button>
                        )}
                      </div>
                    </div>
                  </div>
                );
              })}
            </div>
          ) : (
            <div className="text-center py-16 bg-slate-50 dark:bg-slate-900/30 rounded-3xl border border-dashed border-slate-200 dark:border-slate-700 p-6">
              <Calendar className="w-14 h-14 text-slate-300 dark:text-slate-600 mx-auto mb-3" />
              <h4 className="text-base font-black text-slate-700 dark:text-slate-300">
                {isAr ? 'لا توجد مواعيد مطابقة لخيارات البحث' : 'No appointments found'}
              </h4>
              <p className="text-xs sm:text-sm text-slate-400 font-bold mt-1 max-w-md mx-auto">
                {isAr
                  ? 'يمكنك جدولة موعد جديد لأي زبون بالضغط على علامة الـ 3 نقاط (⋮) في بطاقة الزبون'
                  : 'You can schedule an appointment from the 3-dots menu on any customer card'}
              </p>
            </div>
          )}
        </div>

        {/* Footer info bar */}
        <div className="p-3 sm:p-4 bg-slate-100 dark:bg-slate-900/80 border-t border-slate-200 dark:border-slate-700 flex flex-col sm:flex-row items-center justify-between gap-2 text-xs text-slate-500 dark:text-slate-400">
          <div className="flex items-center gap-1.5 font-bold">
            <Info className="w-4 h-4 text-purple-600 shrink-0" />
            <span>
              {isAr
                ? 'يُحذف الموعد المحدد بتاريخ بعد 3 أيام من تاريخه، ويُحذف الأسبوعي والشهري فور تصفير المتبقي.'
                : 'Date appointments auto-purge after 3 days; recurring appts purge when balance hits 0.'}
            </span>
          </div>
          <button
            type="button"
            onClick={onClose}
            className="px-6 py-2 rounded-xl bg-slate-800 hover:bg-slate-900 text-white font-bold text-xs shadow-xs"
          >
            {isAr ? 'إغلاق' : 'Close'}
          </button>
        </div>

      </div>
    </div>
  );
};
