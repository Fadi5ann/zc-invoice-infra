import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';
import React from 'react';
import ActivityMain from '@/components/settings/Activity/ActivityMain';
import { SystemSettings } from '@/components/settings/SystemSettings';

export default function Page() {
  return (
    <SystemSettings>
      <ActivityMain />
    </SystemSettings>
  );
}

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});
