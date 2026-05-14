import { GetServerSideProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';
import React from 'react';
import { ComingSoon, Page404 } from '@/components/shared';
import { useRouter } from 'next/router';
import { FirmDetails } from '@/components/contacts/enterprise/FirmDetails';

export default function Page() {
  const router = useRouter();
  const id = router.query.id as string;
  return (
    <FirmDetails firmId={id}>
      <ComingSoon />
    </FirmDetails>
  );
}

export const getServerSideProps: GetServerSideProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});
