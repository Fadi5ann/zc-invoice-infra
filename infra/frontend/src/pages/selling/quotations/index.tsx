import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';
import { QuotationPortal } from '@/components/invoicing/quotation/QuotationPortal';

export default function Page() {
  return <QuotationPortal />;
}

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});
