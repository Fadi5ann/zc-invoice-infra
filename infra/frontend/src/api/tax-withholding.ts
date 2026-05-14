import axios from './axios';
import {
  CreateTaxWithholdingDto,
  PagedTaxWithholding,
  TaxWithholding,
  ToastValidation,
  UpdateTaxWithholdingDto
} from '@/types';
import { QueryParams } from '@/types/response/server-responses';

const findPaginated = async (
  page: number = 1,
  size: number = 5,
  order: 'ASC' | 'DESC' = 'ASC',
  sortKey: string = 'id',
  search: string = ''
): Promise<PagedTaxWithholding> => {
  const filter = search ? `label||$cont||${search}` : '';
  const response = await axios.get<PagedTaxWithholding>(
    `public/tax-withholding/list`,
    {
      params: {
        page,
        limit: size,
        sort: `${sortKey},${order}`,
        filter
      }
    }
  );
  return response.data;
};

const find = async (): Promise<TaxWithholding[]> => {
  const response = await axios.get<TaxWithholding[]>(`public/tax-withholding/all`);
  return response.data;
};

const create = async (taxWithholding: CreateTaxWithholdingDto): Promise<TaxWithholding> => {
  const response = await axios.post<TaxWithholding>('public/tax-withholding', taxWithholding);
  return response.data;
};

const update = async (taxWithholding: UpdateTaxWithholdingDto): Promise<TaxWithholding> => {
  const response = await axios.put<TaxWithholding>(
    `public/tax-withholding/${taxWithholding.id}`,
    taxWithholding
  );
  return response.data;
};

const remove = async (id?: number): Promise<TaxWithholding> => {
  const response = await axios.delete<TaxWithholding>(`public/tax-withholding/${id}`);
  return response.data;
};

const validate = (taxWithholding: Partial<TaxWithholding>): ToastValidation => {
  if (!taxWithholding?.label || !taxWithholding.label?.trim()) {
    return { message: 'Le libellé doit être défini' };
  }
  if (taxWithholding?.rate == null || Number.isNaN(taxWithholding.rate)) {
    return { message: 'Le taux doit être défini' };
  }
  if (taxWithholding.rate < 0) {
    return { message: 'Le taux doit être supérieur ou égal à 0' };
  }
  return { message: '', position: 'bottom-right' };
};

export const taxWithholding = { findPaginated, find, create, update, remove, validate };
