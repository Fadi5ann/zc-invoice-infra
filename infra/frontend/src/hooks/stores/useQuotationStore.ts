import { CreateQuotationDto, Quotation, UpdateQuotationDto } from '@/types';
import { BaseActions, createBaseStore } from './useBaseStore';

interface QuotationData {
  response: Quotation | null;
  createDto: CreateQuotationDto;
  createDtoErrors: Record<string, string[]>;

  updateDto?: UpdateQuotationDto;
  updateDtoErrors: Record<string, string[]>;
}

interface IQuotationStore extends QuotationData {}

export interface QuotationStore extends IQuotationStore, BaseActions<IQuotationStore> {}

const initialState: QuotationData = {
  response: null,
  createDto: {
    date: undefined as unknown as string,
    dueDate: undefined as unknown as string,
    object: '',
    generalConditions: undefined,
    interlocutorId: undefined,
    currencyId: undefined,
    bankAccountId: undefined
  },
  createDtoErrors: {},
  updateDtoErrors: {}
};

export const useQuotationStore = createBaseStore<IQuotationStore>({
  ...initialState
});
