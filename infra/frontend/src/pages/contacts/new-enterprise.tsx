import React from 'react';
import { EnterpriseCreateForm } from '@/components/contacts/enterprise/form/EnterpriseCreateForm';
import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),  
});
export default function Page() {
  return <EnterpriseCreateForm className="mx-5 lg:mx-10" />;
}
