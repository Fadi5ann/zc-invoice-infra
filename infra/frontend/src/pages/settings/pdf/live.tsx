import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';

import { PDFEditor } from '@/components/pdf/PDFTemplateEditor';

export default function Page() {
  return (
    <div className="flex-1 flex flex-col overflow-auto">
      <PdfSettings defaultValue={'live'} />
      <LiveEJSCompiler className="m-10" />
    </div>
  );
}

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});
