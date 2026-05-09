import React from 'react';
import { SystemSettings } from '@/components/settings/SystemSettings';
import PaymentConditionMain from '@/components/settings/PaymentCondition/PaymentConditionMain';

export default function Page() {
  return (
    <SystemSettings>
      <PaymentConditionMain />
    </SystemSettings>
  );
}
import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});