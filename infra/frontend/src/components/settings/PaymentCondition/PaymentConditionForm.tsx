import React from 'react';
import { useTranslation } from 'next-i18next';
import { cn } from '@/lib/utils';
import { usePaymentConditionManager } from './data-table/usePaymentConditionManager';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { Label } from '@/components/ui/label';

interface PaymentConditionFormProps {
  className?: string;
}

export const PaymentConditionForm: React.FC<PaymentConditionFormProps> = ({ className }) => {
  const { t: tSettings } = useTranslation('settings');
  const paymentConditionManager = usePaymentConditionManager();
  const paymentCondition = paymentConditionManager.getPaymentCondition();

  return (
    <div className={cn('flex flex-col gap-4', className)}>
      <div className="flex flex-col gap-2">
        <Label htmlFor="payment-condition-label">
          {tSettings('payment_condition.attributes.label') || 'Label'}
        </Label>
        <Input
          id="payment-condition-label"
          placeholder="Enter label"
          value={paymentCondition.label || ''}
          onChange={(e) => {
            const updated = { ...paymentCondition, label: e.target.value };
            paymentConditionManager.setPaymentCondition(updated);
          }}
        />
      </div>
      <div className="flex flex-col gap-2">
        <Label htmlFor="payment-condition-description">
          {tSettings('payment_condition.attributes.description') || 'Description'}
        </Label>
        <Textarea
          id="payment-condition-description"
          placeholder="Enter description"
          value={paymentCondition.description || ''}
          onChange={(e) => {
            const updated = { ...paymentCondition, description: e.target.value };
            paymentConditionManager.setPaymentCondition(updated);
          }}
        />
      </div>
    </div>
  );
};
