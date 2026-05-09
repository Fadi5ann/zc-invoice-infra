import {
  CreateQuotationDto,
  ResponseQuotationDto,
  ResponseQuotationWorkflowDto,
  UpdateQuotationDto,
  DuplicateQuotationDto,
  CreateInvoiceDto
} from '@/types';
import axios from '../axios';
import { Paginated, QueryParams } from '@/types/response';

const findPaginated = async ({
  page = '1',
  limit = '5',
  sort,
  search = '',
  filter = '',
  join = ''
}: QueryParams): Promise<Paginated<ResponseQuotationDto>> => {
  const params: { [key: string]: string | undefined } = {
    page,
    limit,
    sort
  };

  if (search) params.search = search;
  if (filter) params.filter = filter;
  if (join) params.join = join;

  const response = await axios.get<Paginated<ResponseQuotationDto>>(`/_quotation/list`, {
    params
  });

  return response.data;
};

const findAll = async (): Promise<ResponseQuotationDto[]> => {
  const response = await axios.get<ResponseQuotationDto[]>(`/_quotation/all`);
  return response.data;
};

const findById = async (id: number, join?: string): Promise<ResponseQuotationDto> => {
  const response = await axios.get<ResponseQuotationDto>(`/_quotation/${id}`, { params: { join } });
  return response.data;
};

const findWorkflowById = async (
  id: number,
  join?: string
): Promise<ResponseQuotationWorkflowDto> => {
  const response = await axios.get<ResponseQuotationWorkflowDto>(`/quotation-workflow/${id}`, {
    params: { join }
  });
  return response.data;
};

const create = async (quotation: CreateQuotationDto): Promise<ResponseQuotationDto> => {
  const response = await axios.post('/_quotation', quotation);
  return response.data;
};

const update = async (
  id?: number,
  quotation?: UpdateQuotationDto
): Promise<ResponseQuotationDto> => {
  const response = await axios.put(`/_quotation/${id}`, quotation);
  return response.data;
};

const next = async (id: number, event: string): Promise<ResponseQuotationWorkflowDto> => {
  const response = await axios.post(`/quotation-workflow/${id}/next`, { event });
  return response.data;
};

const remove = async (id?: number): Promise<ResponseQuotationDto> => {
  const response = await axios.delete(`/_quotation/${id}`);
  return response.data;
};

const duplicate = async (duplicateQuotationDto: DuplicateQuotationDto): Promise<ResponseQuotationDto> => {
  const response = await axios.post('/_quotation/duplicate', duplicateQuotationDto);
  return response.data;
};

const download = async (id: number, template?: string): Promise<Blob> => {
  const response = await axios.get(`/_quotation/${id}/download`, {
    params: { template },
    responseType: 'blob'
  });
  return response.data;
};

const validate = async (quotation: CreateQuotationDto): Promise<any> => {
  const response = await axios.post('/_quotation/validate', quotation);
  return response.data;
};

const findChoices = async (): Promise<ResponseQuotationDto[]> => {
  const response = await axios.get<ResponseQuotationDto[]>('/_quotation/choices');
  return response.data;
};

const invoice = async (id: number, createInvoice: CreateInvoiceDto): Promise<any> => {
  const response = await axios.post(`/_quotation/${id}/invoice`, createInvoice);
  return response.data;
};

export const quotation = {
  findPaginated,
  findAll,
  findById,
  create,
  update,
  remove,
  duplicate,
  download,
  validate,
  findChoices,
  invoice,
  workflow: {
    findById: findWorkflowById,
    next
  }
};
