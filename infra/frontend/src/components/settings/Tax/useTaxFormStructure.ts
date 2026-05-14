import {
  Field,
  FieldVariant,
  FormStructure,
  NumberFieldProps,
  SelectFieldProps,
  SwitchFieldProps,
  TextFieldProps
} from '@/components/shared/form-builder/types';
import { TaxManager } from './data-table/useTaxManager';
import { CurrencyPayload, ResponseRefParamDto } from '@/types';
import { useTranslation } from 'next-i18next';

interface useTaxFormStructureProps {
  store: TaxManager;
  currencies: ResponseRefParamDto<CurrencyPayload>[];
}

export const useTaxFormStructure = ({ store, currencies }: useTaxFormStructureProps) => {
  const { t: tSettings } = useTranslation('settings');
  const { t: tCommon } = useTranslation('common');
  const { t: tCurrency } = useTranslation('currency');

  const labelField: Field<TextFieldProps> = {
    id: 'tax-label',
    label: 'Label',
    required: true,
    variant: FieldVariant.TEXT,
    placeholder: 'Ex. FODEC',
    description: 'Enter a unique name for the tax (e.g., VAT, FODEC)',
    error: store.errors?.label?.[0],
    props: {
      value: store.label,
      onChange: (e: string) => store.set('label', e)
    }
  };

  const valueField: Field<NumberFieldProps> = {
    id: 'tax-value',
    label: 'Value',
    required: true,
    variant: FieldVariant.NUMBER,
    placeholder: 'Ex. 10',
    description: 'Enter the value of the tax (e.g., 10 for 10%)',
    error: store.errors?.value?.[0],
    props: {
      value: store.value,
      onChange: (e: number) => store.set('value', e)
    }
  };

  const typeField: Field<SelectFieldProps> = {
    id: 'tax-type',
    label: 'Type',
    required: true,
    variant: FieldVariant.SELECT,
    placeholder: 'Ex. PERCENTAGE',
    description: 'Select the type of tax (e.g., percentage or amount)',
    error: store.errors?.isRate?.[0],
    props: {
      options: [
        {
          label: 'Percentage (%)',
          value: 'PERCENTAGE'
        },
        {
          label: 'Amount ($)',
          value: 'AMOUNT'
        }
      ],
      value: store.isRate ? 'PERCENTAGE' : 'AMOUNT',
      onValueChange: (e: string) => store.set('isRate', e === 'PERCENTAGE')
    }
  };

  const isSpecialField: Field<SwitchFieldProps> = {
    id: 'tax-is-special',
    label: 'Special Tax',
    variant: FieldVariant.SWITCH,
    description:
      'Une taxe spéciale est appliquée sur le montant après que les taxes normales ont déjà été calculées.',
    error: store.errors?.isSpecial?.[0],
    props: {
      checked: store.isSpecial,
      onCheckedChange: (e: boolean) => store.set('isSpecial', e)
    }
  };

  const specificCurrencyField: Field<SwitchFieldProps> = {
    id: 'tax-specific-currency',
    label: 'Specific Currency',
    variant: FieldVariant.SWITCH,
    description: 'Set a specific currency for this tax',
    error: store.errors?.specificCurrency?.[0],
    props: {
      checked: store.specificCurrency,
      onCheckedChange: (e: boolean) => store.set('specificCurrency', e)
    }
  };

  const currencyField: Field<SelectFieldProps> = {
    id: 'tax-type',
    label: 'Currency',
    required: true,
    variant: FieldVariant.SELECT,
    placeholder: 'Ex. Tunisian Dinar',
    description: 'Choose the currency of the tax',
    hidden: !store.specificCurrency,
    error: store.errors?.currencyId?.[0],
    props: {
      options: currencies.map((c) => ({
        label: `${c.label} (${c.extras?.symbol})`,
        value: c.id?.toString()
      })),
      value: store.currencyId?.toString(),
      onValueChange: (e: string) => store.set('currencyId', Number(e))
    }
  };

  const taxFormStructure: FormStructure = {
    title: { value: 'Tax Form' },
    orientation: 'horizontal',
    fieldsets: [
      {
        title: { value: 'Tax' },
        rows: [
          {
            fields: [labelField]
          },
          {
            fields: [valueField, typeField]
          },
          {
            fields: [isSpecialField]
          },
          {
            fields: [specificCurrencyField]
          },
          {
            fields: [currencyField]
          }
        ]
      }
    ]
  };

  return { taxFormStructure };
};
