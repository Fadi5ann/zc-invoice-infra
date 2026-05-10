import { getI18nProps } from '@/lib/getStatic';
import type { GetStaticProps, NextPage } from 'next';

const BuyingQuotationsPage: NextPage = () => {
  return <div>Buying Quotations Page</div>;
};

export default BuyingQuotationsPage;

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});
