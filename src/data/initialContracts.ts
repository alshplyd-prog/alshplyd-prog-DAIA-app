// Initial Data Fallbacks & Constants
import { InstallmentContract, SalesRepresentative, CashFund, CustomerList } from '../types';

export const DEFAULT_REPS: SalesRepresentative[] = [
  {
    id: 'rep_admin',
    name: 'المشرف الرئيسي (المدير)',
    phone: '07700000000',
    code: '1234',
    role: 'admin',
    canEdit: true,
    canDelete: true,
    canMoveCustomer: true,
    canSell: true,
    allowedListIds: ['all'],
  },
];

export const DEFAULT_FUNDS: CashFund[] = [
  {
    id: 'fund_main',
    name: 'الصندوق الرئيسي',
    balance: 0,
    description: 'صندوق المقبوضات والمصروفات العام',
  },
];

export const DEFAULT_CUSTOMER_LISTS: CustomerList[] = [
  {
    id: 'list_main',
    name: 'القائمة الرئيسية',
    fundId: 'fund_main',
    description: 'قائمة الزبائن الرئيسية',
  },
];

export const INITIAL_CONTRACTS: InstallmentContract[] = [];
