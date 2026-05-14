import { PaymentCondition } from '@/types';
import { create } from 'zustand';

export interface PaymentConditionManager extends Partial<PaymentCondition> {
  setPaymentCondition: (condition: PaymentCondition) => void;
  getPaymentCondition: () => PaymentCondition;
  reset: () => void;
}

const initialState: Partial<PaymentCondition> = {
  id: undefined,
  label: '',
  description: ''
};

export const usePaymentConditionManager = create<PaymentConditionManager>((set, get) => ({
  ...initialState,
  setPaymentCondition: (condition: PaymentCondition) => {
    set({ ...condition });
  },
  getPaymentCondition: () => {
    return get() as PaymentCondition;
  },
  reset: () => set({ ...initialState })
}));
