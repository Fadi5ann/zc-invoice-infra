import React from 'react';
import { useActivities } from '@/hooks/content/core/useActivities';
import { useCountries } from '@/hooks/content/core/useCountries';
import { Button } from '../../../ui/button';
import { Spinner } from '@/components/shared';
import { usePaymentCondition } from '@/hooks/content/core/usePaymentConditions';
import { ChevronLeft, ChevronRight, Save } from 'lucide-react';
import { api } from '@/api';
import { toast } from 'sonner';
import { useMutation } from '@tanstack/react-query';
import { getErrorMessage } from '@/utils/errors';
import { useRouter } from 'next/router';
import { cn } from '@/lib/utils';
import { useEnterpriseStore } from '@/hooks/stores/useEnterpriseStore';
import { useTranslation } from 'next-i18next';
import { ResponseRefParamDto } from '@/types';
import { useBreadcrumb } from '@/context/BreadcrumbContext';
import { defineStepper } from '@/components/ui/stepper';
import { useEnterpriseCreateFormStructure } from './useEnterpriseCreateFormStructure';
import { FormBuilder } from '@/components/shared/form-builder/FormBuilder';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { createEnterpriseValidationSchema } from '@/types/validations/enterprise.validation';
import { mapToSelectOptions } from '@/components/shared/form-builder/utils/mapToSelectOptions';
import { useCurrencies } from '@/hooks/content/core/useCurrencies';
import { CreateEnterpriseDto } from '@/types/core/enterprise';

const steps =[
  { id: '1', title: 'Enterprise information', description: 'Basic information about the enterprise.' },
  { id: '2', title: 'Interlocutor information', description: 'Information about the main contact person for the enterprise.' },
  { id: '3', title: 'Address information', description: 'Invoicing and shipping addresses for the enterprise.' },
  { id: '4', title: 'Additional information', description: 'Additional information about the enterprise.' }
];

const { Stepper } = defineStepper(...steps);

export const EnterpriseCreateForm = ({ className }: { className?: string }) => {
  const router = useRouter();
  const { t: tCommon } = useTranslation('common');
  const { t: tContact } = useTranslation('contacts');
  const { t: tCountry } = useTranslation('country');

  const enterpriseStore = useEnterpriseStore();

  const { activities, isFetchActivitiesPending } = useActivities();
  const { currencies, isCurrenciesPending } = useCurrencies();
  const { countries, isFetchCountriesPending } = useCountries();
  const { paymentConditions, isFetchPaymentConditionsPending } = usePaymentCondition();

  // DEBUG LOGS
  React.useEffect(() => {
    if (!isFetchActivitiesPending && !isCurrenciesPending && !isFetchPaymentConditionsPending) {
      console.log("=== DEBUG API RESPONSES ===");
      console.log("Activities API Response:", activities);
      console.log("Currencies API Response:", currencies);
      console.log("Payment Conditions API Response:", paymentConditions);
      console.log("===========================");
    }
  },[activities, currencies, paymentConditions, isFetchActivitiesPending, isCurrenciesPending, isFetchPaymentConditionsPending]);

const {
    enterpriseInformation,
    addressInformation,
    interlocutorInformation,
    additionalInformation
  } = useEnterpriseCreateFormStructure({
    store: enterpriseStore,
    activityOptions: mapToSelectOptions({
      data: activities ||[],
      labelKey: 'label',
      valueKey: 'id'
    }).map(opt => ({ ...opt, value: String(opt.value) })),
    
    currencyOptions: mapToSelectOptions({
      data: currencies ||[],
      labelKey: 'label',
      valueKey: 'id',
      labelKeyTransformer: (label, entity: any) =>
        `${tCommon(label || '')} ${entity?.extras?.symbol || ''}`
    }).map(opt => ({ ...opt, value: String(opt.value) })),
    
    paymentConditionOptions: mapToSelectOptions({
      data: paymentConditions ||[],
      labelKey: 'label',
      valueKey: 'id'
    }).map(opt => ({ ...opt, value: String(opt.value) })),
    
    countryOptions: mapToSelectOptions({
      data: countries ||[],
      labelKey: 'label',
      valueKey: 'id',
      labelKeyTransformer: (label) => tCountry(label || '')
    }).map(opt => ({ ...opt, value: String(opt.value) }))
  });

  const { setRoutes } = useBreadcrumb();
  React.useEffect(() => {
    setRoutes?.([
      { title: tCommon('menu.contacts'), href: '/contacts' },
      { title: tCommon('submenu.enterprises'), href: '/contacts/enterprises' },
      { title: tContact('enterprise.new') }
    ]);
    return () => {
      setRoutes?.([]);
      enterpriseStore.reset();
    };
  }, [router.locale]);

  const { mutate: createEnterprise, isPending: isCreatePending } = useMutation({
    mutationFn: (data: CreateEnterpriseDto) => api.core.enterprise.create(data),
    onSuccess: () => {
      router.push(`/contacts/enterprises`);
      toast.success(tContact('enterprise.action_add_success'));
    },
    onError: (error): void => {
      const message = getErrorMessage('contacts', error, tContact('enterprise.action_add_failure'));
      toast.error(message);
    }
  });

  const validateStep = (stepId: string) => {
    if (stepId === '1') {
      const result = createEnterpriseValidationSchema.safeParse(enterpriseStore.createDto);
      if (!result.success) {
        enterpriseStore.set('errors', result.error.flatten().fieldErrors);
      }
      return result.success;
    }
    return true;
  };

  const handleSubmit = () => {
    createEnterprise({
      ...enterpriseStore.createDto,
      notes: JSON.stringify(enterpriseStore.createDto.notes)
    });
  };

  const loading =
    isFetchActivitiesPending ||
    isCurrenciesPending ||
    isFetchCountriesPending ||
    isFetchPaymentConditionsPending;

  if (loading) return <Spinner className="h-screen" show={loading} />;

  return (
    <div className={cn('flex flex-col flex-1 overflow-hidden m-5 lg:mx-10', className)}>
      <div className={cn('flex flex-col flex-1 overflow-hidden')}>
        <Stepper.Provider className="flex flex-col flex-1 overflow-hidden" variant="horizontal">
          {({ methods }) => {
            const activeIndex = steps.findIndex((step) => step.id === methods.current.id);

            const handleNext = () => {
              const valid = validateStep(methods.current.id);
              if (!valid) return;

              if (methods.isLast) {
                handleSubmit();
              } else {
                methods.next();
              }
            };

            return (
              <>
                <Stepper.Navigation className="shrink">
                  {methods.all.map((step, index) => (
                    <Stepper.Step
                      key={step.id}
                      of={step.id}
                      onClick={() => {
                        if (index > activeIndex) {
                          let valid = true;
                          for (let i = 0; i <= activeIndex; i++) {
                            valid = valid && validateStep(steps[i].id);
                          }
                          if (!valid) return;
                        }
                        methods.goTo(step.id);
                      }}
                      disabled={false}>
                      <Stepper.Title>{step.title}</Stepper.Title>
                    </Stepper.Step>
                  ))}
                </Stepper.Navigation>

                <div className="flex flex-col flex-1 h-full overflow-hidden my-4">
                  <div className="flex flex-col flex-1 overflow-auto p-2">
                    <Card className="flex flex-col flex-1">
                      <CardHeader>
                        <CardTitle>{methods.current.title}</CardTitle>
                        <CardDescription>{methods.current.description}</CardDescription>
                      </CardHeader>
                      <CardContent>
                        {methods.current.id === '1' && <FormBuilder structure={enterpriseInformation} />}
                        {methods.current.id === '2' && <FormBuilder structure={interlocutorInformation} />}
                        {methods.current.id === '3' && <FormBuilder structure={addressInformation} />}
                        {methods.current.id === '4' && <FormBuilder structure={additionalInformation} />}
                      </CardContent>
                    </Card>
                  </div>
                </div>

                <Stepper.Controls className="shrink-0 flex items-center justify-end gap-2 px-4">
                  {!methods.isFirst && (
                    <Button variant="outline" size="sm" onClick={methods.prev} disabled={false}>
                      <div className="flex items-center gap-2">
                        <ChevronLeft /> <span>Previous</span>
                      </div>
                    </Button>
                  )}
                  <Button size="sm" onClick={handleNext} disabled={isCreatePending}>
                    {methods.isLast ? (
                      <div className="flex items-center gap-2">
                        <span>Create</span>
                        <Save />
                      </div>
                    ) : (
                      <div className="flex items-center gap-2">
                        <span>Next</span>
                        <ChevronRight />
                      </div>
                    )}
                  </Button>
                </Stepper.Controls>
              </>
            );
          }}
        </Stepper.Provider>
      </div>
    </div>
  );
};