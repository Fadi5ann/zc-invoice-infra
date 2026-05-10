import React from 'react';
import dinero from 'dinero.js';
import { createDineroAmountFromFloatWithDynamicCurrency } from '@/utils/money.utils';
import { DISCOUNT_TYPE } from '@/types/enums/discount-types';

export const useCalculateInvoiceTotals = ({
  invoiceManager,
  articleManager,
  taxes
}: any) => {
  const digitAfterComma = React.useMemo(() => {
    return invoiceManager?.currency?.digitAfterComma || 3;
  }, [invoiceManager?.currency]);

  React.useEffect(() => {
    const zero = dinero({ amount: 0, precision: digitAfterComma });
    const articles = articleManager?.getArticles() || [];

    // Calculate subTotal
    const subTotal = articles.reduce((acc: any, article: any) => {
      return acc.add(
        dinero({
          amount: createDineroAmountFromFloatWithDynamicCurrency(
            article?.subTotal || 0,
            digitAfterComma
          ),
          precision: digitAfterComma
        })
      );
    }, zero);
    invoiceManager?.set('subTotal', subTotal.toUnit());

    // Calculate total
    const total = articles.reduce((acc: any, article: any) => {
      return acc.add(
        dinero({
          amount: createDineroAmountFromFloatWithDynamicCurrency(
            article?.total || 0,
            digitAfterComma
          ),
          precision: digitAfterComma
        })
      );
    }, zero);

    let finalTotal = total;

    // Apply discount
    if (invoiceManager?.discountType === DISCOUNT_TYPE.PERCENTAGE) {
      const discountAmount = total.multiply((invoiceManager?.discount || 0) / 100);
      finalTotal = total.subtract(discountAmount);
    } else {
      const discountAmount = dinero({
        amount: createDineroAmountFromFloatWithDynamicCurrency(
          invoiceManager?.discount || 0,
          digitAfterComma
        ),
        precision: digitAfterComma
      });
      finalTotal = total.subtract(discountAmount);
    }

    invoiceManager?.set('total', finalTotal.toUnit());
  }, [
    articleManager?.articles,
    invoiceManager?.discount,
    invoiceManager?.discountType,
    digitAfterComma,
    taxes
  ]);
};