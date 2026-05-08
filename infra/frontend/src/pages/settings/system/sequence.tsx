import React from 'react';
import { SystemSettings } from '@/components/settings/SystemSettings';
import { SequentialMain } from '@/components/settings/Sequentials/SequentialMain';

export default function Page() {
  return (
    <SystemSettings>
      <SequentialMain />
    </SystemSettings>
  );
}
import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});