import React from 'react';
import { SystemSettings } from '@/components/settings/SystemSettings';
import TaxWithholdingMain from '@/components/settings/TaxWithholding/TaxWithholdingMain';

export default function Page() {
  return (
    <SystemSettings>
      <TaxWithholdingMain />
    </SystemSettings>
  );
}
import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});