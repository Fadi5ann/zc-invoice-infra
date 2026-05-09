import { Html, Head, Main, NextScript } from 'next/document';
import Script from 'next/script';

export default function Document() {
  return (
    <Html lang="en">
      <Head />
      <body>
        <Main />
        <Script src="/static/ejs.min.js" strategy="afterInteractive" />
        <NextScript />
      </body>
    </Html>
  );
}
