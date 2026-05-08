import React from 'react';
import { SystemSettings } from '@/components/settings/SystemSettings';
import TaxMain from '@/components/settings/Tax/TaxMain';

export default function Page() {
  return (
    <SystemSettings>
      <TaxMain />
    </SystemSettings>
  );
}
import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});