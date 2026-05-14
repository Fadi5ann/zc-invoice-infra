import { TaxWithholding } from '@/types';
import { create } from 'zustand';

export interface TaxWithholdingManager extends Partial<TaxWithholding> {
  setTax: (tax: Partial<TaxWithholding>) => void;
  getTax: () => TaxWithholding;
  set: (name: string, value: any) => void;
  reset: () => void;
}

const initialState: Omit<TaxWithholdingManager, 'setTax' | 'getTax' | 'set' | 'reset'> = {
  id: undefined,
  label: '',
  rate: 0
};

export const useTaxWithholdingManager = create<TaxWithholdingManager>((set, get) => ({
  ...initialState,
  setTax: (tax: Partial<TaxWithholding>) => {
    set({ ...tax });
  },
  getTax: () => {
    const { setTax, getTax, set, reset, ...taxData } = get();
    return taxData as TaxWithholding;
  },
  set: (name: string, value: any) => {
    set((state) => ({ ...state, [name]: value }));
  },
  reset: () => set({ ...initialState })
}));
