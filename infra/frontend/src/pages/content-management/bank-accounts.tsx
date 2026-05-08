import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';
import { BankAccountPortal } from '@/components/content-management/bank-accounts/BankAccountPortal';

export default function Page() {
  return <BankAccountPortal />;
}

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});
