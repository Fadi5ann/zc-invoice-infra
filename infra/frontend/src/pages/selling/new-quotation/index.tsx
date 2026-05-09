import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';
import React from 'react';
import { QuotationCreateForm } from '@/components/selling/quotation/QuotationCreateForm';
import { useSearchParams } from 'next/navigation';

export default function Page() {
  const params = useSearchParams();
  const firmId = params.get('firmId') || undefined;
  return (
    <div className="flex-1 flex flex-col overflow-hidden">
      <QuotationCreateForm firmId={firmId} />
    </div>
  );
}

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});
