import type { NextPage } from 'next';

const BuyingQuotationsPage: NextPage = () => {
  return <div>Buying Quotations Page</div>;
};

export default BuyingQuotationsPage;

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});
