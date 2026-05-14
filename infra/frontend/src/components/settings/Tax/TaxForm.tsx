import React from 'react';
import { useTaxManager } from './data-table/useTaxManager';
import { useTaxFormStructure } from './useTaxFormStructure';
import { FormBuilder } from '@/components/shared/form-builder/FormBuilder';
import { useCurrencies } from '@/hooks/content/core/useCurrencies';

interface TaxFormProps {
  className?: string;
}

export const TaxForm: React.FC<TaxFormProps> = ({ className }) => {
  const store = useTaxManager();

  // Safely extract currencies and pending state regardless of the hook's return signature
  const { currencies, isCurrenciesPending, data, isPending } = useCurrencies() as any;
  const resolvedCurrencies = currencies || data?.data || data || [];
  const resolvedIsPending = isCurrenciesPending ?? isPending ?? false;

  const { taxFormStructure } = useTaxFormStructure({ 
    store, 
    currencies: resolvedIsPending ? [] : resolvedCurrencies 
  });

  return <FormBuilder structure={taxFormStructure} className={className} />;
};