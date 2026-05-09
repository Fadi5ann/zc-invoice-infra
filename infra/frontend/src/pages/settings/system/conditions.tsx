import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';
import React from 'react';
import { SystemSettings } from '@/components/settings/SystemSettings';
import { DefaultConditionMain } from '@/components/settings/DefaultCondition/DefaultConditionMain';

export default function Page() {
  return (
    <SystemSettings>
      <DefaultConditionMain />
    </SystemSettings>
  );
}

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});
