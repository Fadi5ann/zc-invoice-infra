import axios from './axios';
import { Currency } from '@/types';

const find = async (): Promise<Currency[]> => {
  const response = await axios.get('public/currency/all');
  return response.data;
};

const factory = (): Currency => {
  return {
    id: 0,
    code: '',
    label: '',
    symbol: '',
    digitAfterComma: 0,
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
    deletedAt: '',
    isDeletionRestricted: false
  };
};

export const currency = { factory, find };
