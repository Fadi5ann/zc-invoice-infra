import { ParamVariant } from 'src/shared/configurations/enums/param-variant.enum';

export const testConfiguration = [
  {
    name: 'test1.var1',
    description: 'test var 1',
    variant: ParamVariant.NUMBER,
    value: '0',
  },
  {
    name: 'test1.var2',
    description: 'test var 2',
    variant: ParamVariant.STRING,
    value: 'test',
  },
  {
    name: 'test2.var1',
    description: 'test var 1',
    variant: ParamVariant.NUMBER,
    value: '0',
  },
  {
    name: 'test2.var2',
    description: 'test var 2',
    variant: ParamVariant.SELECT,
    value: 'test',
    options: [
      { label: 'Test', value: 'test' },
      { label: 'Test 2', value: 'test2' },
    ],
  },
];

export const coreConfiguration = [
  {
    name: 'company.name',
    description: 'Company name',
    variant: ParamVariant.STRING,
    value: 'SUPER COMPANY',
  },
  {
    name: 'company.support',
    description: 'Company support email',
    variant: ParamVariant.STRING,
    value: 'support@super.company',
  },
  {
    name: 'company.address',
    description: 'Company address',
    variant: ParamVariant.STRING,
    value: '123 Main Street, Anytown',
  },
];
