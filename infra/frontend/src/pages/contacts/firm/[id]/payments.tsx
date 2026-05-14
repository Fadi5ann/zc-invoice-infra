import { GetServerSideProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';
import React from 'react';
import { useRouter } from 'next/router';
import { FirmDetails } from '@/components/contacts/enterprise/FirmDetails';
import { PaymentEmbeddedMain } from '@/components/selling/payment/PaymentEmbeddedMain';
import { useTranslation } from 'next-i18next';

export default function Page() {
  const router = useRouter();
  const id = router.query.id as string;

  const { t: tCommon, ready: commonReady } = useTranslation('common');
  const { t: tContact, ready: contactReady } = useTranslation('contacts');

  const routes = [
    { title: tCommon('menu.contacts'), href: '/contacts' },
    { title: tContact('firm.plural'), href: '/contacts/firms' },
    {
      title: `${tContact('firm.singular')} N°${id}`,
      href: '/contacts/firm?id=' + id
    }
  ];

  return (
    <FirmDetails firmId={id}>
      <PaymentEmbeddedMain firmId={parseInt(id)} routes={routes} />
    </FirmDetails>
  );
}

export const getServerSideProps: GetServerSideProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});
