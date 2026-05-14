import { Tax } from '@/types';
import { create } from 'zustand';

export interface TaxManager extends Partial<Tax> {
  specificCurrency: boolean;
  setTax: (tax: Tax) => void;
  getTax: () => Tax;
  set: (name: string, value: any) => void;
  reset: () => void;
  errors?: Record<string, string[]>;
}

const initialState: Omit<TaxManager, 'setTax' | 'getTax' | 'set' | 'reset'> = {
  id: undefined,
  label: '',
  value: 0,
  isRate: true,
  isSpecial: false,
  currencyId: undefined,
  specificCurrency: false
};

export const useTaxManager = create<TaxManager>((set, get) => ({
  ...initialState,
  setTax: (tax: Tax) => {
    set({ ...tax, specificCurrency: !!tax.currencyId });
  },
  getTax: () => {
    const { setTax, getTax, set, reset, specificCurrency, ...taxData } = get();
    return {
      ...taxData,
      currencyId: specificCurrency ? taxData.currencyId : undefined
    } as Tax;
  },
  set: (name: string, value: any) => {
    set((state) => ({ ...state, [name]: value }));
  },
  reset: () => set({ ...initialState })
}));
