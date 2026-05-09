import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';
import { QuotationCreateForm } from '@/components/invoicing/quotation/forms/QuotationCreateForm';

export default function Page() {
  return <QuotationCreateForm />;
}

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});
