import { z } from 'zod';

// 1. Create a sub-schema for the nested addresses
export const addressValidationSchema = z.object({
  address: z.string().min(1, 'Address is required'),
  address2: z.string().optional().nullable(),
  region: z.string().min(1, 'Region/City is required'),
  zipcode: z.string().min(1, 'Zip code is required'),
  countryId: z.number({
    required_error: 'Country is required',
    invalid_type_error: 'Country is required'
  }).min(1, 'Country is required'),
});

// 2. Main base enterprise info schema
export const baseEnterpriseInformationValidationSchema = z.object({
  name: z
    .string({
      required_error: 'Name is required'
    })
    .min(1, 'Name is required'),
  taxId: z.string().optional(),
  phone: z.string().min(1, 'Phone number is required'),
  notes: z.string().optional(),
  website: z.string().url('Invalid website URL').optional().or(z.literal('')), // Handles optional empty strings safely
  particular: z.boolean().default(false),
  activityId: z.number().optional(),
  currencyId: z.number().optional(),
  paymentConditionId: z.number().optional(), // Fixed typo: backend uses paymentConditionId, not paymentConditionsId
  
  // Add the nested object schemas here to match NestJS backend DTO
  invoicingAddress: addressValidationSchema,
  deliveryAddress: addressValidationSchema.optional(), // Make optional if frontend handles copying data
});

export const createEnterpriseValidationSchema = baseEnterpriseInformationValidationSchema.refine(
  (data) => {
    if (data.particular) {
      return true;
    }
    return data.taxId && data.taxId.trim() !== '';
  },
  {
    message: 'Tax ID Number is required for non-particular enterprises',
    path: ['taxId']
  }
);