import { api } from '@/api';
import {
  Currency,
  Firm,
  Interlocutor,
  PaymentCondition,
  Quotation,
  QuotationUploadedFile
} from '@/types';
import { QUOTATION_STATUS } from '@/types/quotation';
import { DateFormat } from '@/types/enums/date-formats';
import { DISCOUNT_TYPE } from '@/types/enums/discount-types';
import { fromStringToSequentialObject } from '@/utils/string.utils';
import { create } from 'zustand';

type QuotationManager = {
  // data
  id?: number;
  sequentialNumber: {
    dateFormat: DateFormat;
    next: number;
    prefix: string;
  };
  sequential: string;
  date: Date | undefined;
  dueDate: Date | undefined;
  object: string;
  firm?: Firm;
  interlocutor?: Interlocutor;
  subTotal: number;
  total: number;
  discount: number;
  discountType: DISCOUNT_TYPE;
  bankAccount?: any;
  currency?: Currency;
  notes: string;
  status: QUOTATION_STATUS;
  generalConditions: string;
  uploadedFiles: QuotationUploadedFile[];
  // utility data
  isInterlocutorInFirm: boolean;
  // methods
  setFirm: (firm?: Firm) => void;
  setInterlocutor: (interlocutor?: Interlocutor) => void;
  set: (name: keyof QuotationManager, value: any) => void;
  getQuotation: () => Partial<QuotationManager>;
  setQuotation: (
    quotation: Partial<Quotation & { files: QuotationUploadedFile[] }>,
    firms?: Firm[],
    bankAccounts?: any[]
  ) => void;
  reset: () => void;
};

const getDateRangeAccordingToPaymentConditions = (paymentCondition: PaymentCondition) => {
  const today = new Date();
  const year = today.getFullYear();
  const month = today.getMonth();

  switch (paymentCondition.id) {
    case 1:
      return { date: today, dueDate: today };
    case 2:
      return { date: today, dueDate: new Date(year, month + 1, 0) }; // End of current month
    case 3:
      return { date: today, dueDate: new Date(year, month + 2, 0) }; // End of next month
    case 4:
      return { date: today, dueDate: undefined };
    default:
      return { date: undefined, dueDate: undefined };
  }
};

const initialState: Omit<
  QuotationManager,
  'set' | 'reset' | 'setFirm' | 'setInterlocutor' | 'getQuotation' | 'setQuotation'
> = {
  id: -1,
  sequentialNumber: {
    prefix: '',
    dateFormat: DateFormat.YYMM,
    next: 0
  },
  sequential: '',
  date: undefined,
  dueDate: undefined,
  object: '',
  firm: (api as any).firm?.factory() ?? undefined,
  interlocutor: (api as any).interlocutor?.factory() ?? undefined,
  subTotal: 0,
  total: 0,
  discount: 0,
  discountType: DISCOUNT_TYPE.PERCENTAGE,
  bankAccount: (api as any).bankAccount?.factory() ?? undefined,
  currency: (api as any).currency?.factory() ?? undefined,
  notes: '',
  generalConditions: '',
  status: QUOTATION_STATUS.Draft,
  isInterlocutorInFirm: false,
  uploadedFiles: []
};

export const useQuotationManager = create<QuotationManager>((set, get) => ({
  ...initialState,
  setFirm: (firm?: Firm) => {
    const dateRange = firm?.paymentCondition !== undefined
      ? getDateRangeAccordingToPaymentConditions(firm.paymentCondition)
      : { date: undefined, dueDate: undefined };

    set((state) => ({
      ...state,
      firm,
      interlocutor:
        firm?.interlocutorsToFirm?.length === 1
          ? firm.interlocutorsToFirm[0]
          : (api as any).interlocutor?.factory() ?? undefined,
      isInterlocutorInFirm: (firm?.interlocutorsToFirm?.length ?? 0) > 0,
      date: dateRange.date,
      dueDate: dateRange.dueDate
    }));
  },
  setInterlocutor: (interlocutor?: Interlocutor) =>
    set((state) => ({
      ...state,
      interlocutor,
      isInterlocutorInFirm: true
    })),
  set: (name: keyof QuotationManager, value: any) => {
    if (name === 'date' || name === 'dueDate') {
      const dateValue = typeof value === 'string' ? new Date(value) : value;
      set((state) => ({
        ...state,
        [name]: dateValue
      }));
    } else {
      set((state) => ({
        ...state,
        [name]: value
      }));
    }
  },
  getQuotation: () => {
    const {
      id,
      sequentialNumber,
      date,
      dueDate,
      object,
      firm,
      interlocutor,
      discount,
      discountType,
      notes,
      generalConditions,
      bankAccount,
      currency,
      uploadedFiles,
      ...rest
    } = get();

    return {
      id,
      sequentialNumber,
      date,
      dueDate,
      object,
      firmId: firm?.id,
      interlocutorId: interlocutor?.id,
      discount,
      discountType,
      notes,
      generalConditions,
      bankAccountId: bankAccount?.id,
      currencyId: currency?.id,
      uploadedFiles
    };
  },
  setQuotation: (
    quotation: Partial<Quotation & { files: QuotationUploadedFile[] }>,
    firms?: Firm[],
    bankAccounts?: any[]
  ) => {
    set((state) => ({
      ...state,
      id: quotation.id,
      sequentialNumber: fromStringToSequentialObject(quotation.sequential ?? ''),
      date: quotation.date !== undefined ? new Date(quotation.date) : undefined,
      dueDate: quotation.dueDate !== undefined ? new Date(quotation.dueDate) : undefined,
      object: quotation.object,
      firm: firms?.find((firm) => quotation.firm?.id === firm.id),
      interlocutor: quotation.interlocutor,
      discount: quotation.discount,
      discountType: quotation.discount_type,
      bankAccount: quotation.bankAccount,
      currency: quotation.currency ?? quotation.firm?.currency,
      notes: quotation.notes,
      generalConditions: quotation.generalConditions,
      status: quotation.status,
      uploadedFiles: quotation.files ?? []
    }));
  },
  reset: () => set({ ...initialState })
}));
