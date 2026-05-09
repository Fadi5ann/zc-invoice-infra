import React from 'react';
import { InterlocutorPortal } from '@/components/contacts/interlocutor/InterlocutorPortal';
import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),  
});
export default function Page() {
  return <InterlocutorPortal />;
}
