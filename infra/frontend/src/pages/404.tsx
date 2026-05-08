import React from 'react';
import { Page404 } from '@/components/shared';

export default function page() {
  return (
    <div className="flex-1 flex flex-col overflow-hidden">
      <Page404 />
    </div>
  );
}
import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});