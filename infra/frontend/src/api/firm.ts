import axios from './axios';
import { address } from './address';
import { interlocutor } from './interlocutor';
import { SOCIAL_TITLE } from '../types/enums';
import { isValidUrl } from '@/utils/string.utils';
import { CreateFirmDto, Firm, PagedFirm, ToastValidation, UpdateFirmDto } from '@/types';
import { FIRM_FILTER_ATTRIBUTES } from '@/constants/firm.filter-attributes';

const TEST_CABINET =
  typeof window !== 'undefined' ? process.env.NEXT_PUBLIC_CABINET_ID : process.env.CABINET_ID;

const factory = (): CreateFirmDto => {
  return {
    website: '',
    name: '',
    taxIdNumber: '',
    isPerson: false,
    invoicingAddress: {
      address: '',
      address2: '',
      region: '',
      zipcode: '',
      countryId: -1
    },
    deliveryAddress: {
      address: '',
      address2: '',
      region: '',
      zipcode: '',
      countryId: -1
    },
    cabinetId: parseInt(TEST_CABINET || '1'),
    activityId: -1,
    currencyId: -1,
    paymentConditionId: -1,
    mainInterlocutor: {
      title: SOCIAL_TITLE.MR,
      name: '',
      surname: '',
      email: '',
      phone: '',
      position: ''
    },
    notes: ''
  };
};

const findPaginated = async (
  page: number = 1,
  size: number = 5,
  order: 'ASC' | 'DESC' = 'ASC',
  sortKey: string = 'id',
  search: string = '',
  relations: string[] = [
    'interlocutorsToFirm',
    'interlocutorsToFirm.interlocutor',
    'currency',
    'activity'
  ]
): Promise<PagedFirm> => {
  const generalFilter = search
    ? Object.values(FIRM_FILTER_ATTRIBUTES)
        .map((key) => `${key}||$cont||${search}`)
        .join('||$or||')
    : '';
  const response = await axios.get<PagedFirm>(
    `public/firm/list?sort=${sortKey},${order}&filter=${generalFilter}&limit=${size}&page=${page}&join=${relations.join(',')}`
  );
  return response.data;
};

const findChoices = async (
  relations: string[] = [
    'interlocutorsToFirm',
    'interlocutorsToFirm.interlocutor',
    'currency',
    'activity',
    'paymentCondition'
  ]
): Promise<Partial<Firm>[]> => {
  const response = await axios.get<Partial<Firm>[]>(`public/firm/all?join=${relations.join(',')}`);
  return response.data;
};

const findOne = async (
  id?: number,
  relations: string[] = [
    'interlocutorsToFirm',
    'interlocutorsToFirm.interlocutor',
    'currency',
    'activity',
    'paymentCondition',
    'invoicingAddress',
    'invoicingAddress.country',
    'deliveryAddress',
    'deliveryAddress.country'
  ]
): Promise<Firm> => {
  const response = await axios.get<Firm>(`public/firm/${id}?join=${relations.join(',')}`);
  return response.data;
};

const create = async (firm: CreateFirmDto): Promise<Firm> => {
  const backendPayload = {
    website: firm.website || undefined,
    name: firm.name,
    phone: firm.mainInterlocutor?.phone || '', 
    particular: Boolean(firm.isPerson),        // Remap frontend 'isPerson' to backend 'particular'
    taxId: firm.taxIdNumber || '',             // Remap frontend 'taxIdNumber' to backend 'taxId'
    notes: firm.notes || undefined,
    activityId: firm.activityId && firm.activityId > 0 ? Number(firm.activityId) : undefined,
    currencyId: firm.currencyId && firm.currencyId > 0 ? Number(firm.currencyId) : undefined,
    paymentConditionId: firm.paymentConditionId && firm.paymentConditionId > 0 ? Number(firm.paymentConditionId) : undefined,
    
    // Explicitly reconstruct the invoicing address to match CreateAddressDto
    invoicingAddress: {
      address: firm.invoicingAddress?.address || '',
      address2: firm.invoicingAddress?.address2 || '',
      region: firm.invoicingAddress?.region || '',
      zipcode: String(firm.invoicingAddress?.zipcode || ''), 
      countryId: firm.invoicingAddress?.countryId && firm.invoicingAddress.countryId > 0 
        ? Number(firm.invoicingAddress.countryId) 
        : undefined,
    },

    // Explicitly reconstruct the delivery address
    deliveryAddress: {
      address: firm.deliveryAddress?.address || firm.invoicingAddress?.address || '',
      address2: firm.deliveryAddress?.address2 || '',
      region: firm.deliveryAddress?.region || firm.invoicingAddress?.region || '',
      zipcode: String(firm.deliveryAddress?.zipcode || firm.invoicingAddress?.zipcode || ''),
      countryId: firm.deliveryAddress?.countryId && firm.deliveryAddress.countryId > 0 
        ? Number(firm.deliveryAddress.countryId) 
        : firm.invoicingAddress?.countryId && firm.invoicingAddress.countryId > 0
          ? Number(firm.invoicingAddress.countryId)
          : undefined,
    },
    
    cabinetId: parseInt(TEST_CABINET || '1')
  };

  try {
    // Replace 'public/firm' with 'enterprise' if your Nest main.ts global routing path changed!
    const response = await axios.post<Firm>('public/firm', backendPayload); 
    return response.data;
  } catch (error: any) {
    console.error('API ERROR:', error.response?.data || error.message);
    throw error;
  }
};

const update = async (firm: UpdateFirmDto): Promise<Firm> => {
  const { id, isPerson, taxIdNumber, ...rest } = firm;
  const payload = {
    ...rest,
    ...(isPerson !== undefined && { particular: isPerson }),
    ...(taxIdNumber !== undefined && { taxId: taxIdNumber })
  };
  const response = await axios.put<Firm>(`public/firm/${id}`, payload);
  return response.data;
};

const remove = async (id: number) => {
  const { data, status } = await axios.delete<Firm>(`public/firm/${id}`);
  return { data, status };
};

const validate = (firm: Partial<CreateFirmDto>): ToastValidation => {
  if (!firm.name?.trim()) {
    return { message: 'Firm name is required.' };
  }

  if (firm.website && !isValidUrl(firm.website)) {
    return { message: 'Invalid website URL.' };
  }

  if (!firm.isPerson && !firm.taxIdNumber?.trim()) {
    return { message: 'Tax ID is required for companies.' };
  }

  if (firm.invoicingAddress) {
    const addressValidation = address.validate(firm.invoicingAddress);
    if (addressValidation.message) {
      return addressValidation;
    }
  } else {
    return { message: 'Invoicing address is required.' };
  }

  if (firm.mainInterlocutor) {
    const interlocutorValidation = interlocutor.validate(firm.mainInterlocutor);
    if (interlocutorValidation.message && interlocutorValidation.type !== 'warning') {
      return interlocutorValidation;
    }
  }

  return { message: '' };
};

export const firm = {
  findPaginated,
  findOne,
  findChoices,
  create,
  factory,
  update,
  remove,
  validate
};