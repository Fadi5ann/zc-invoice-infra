import React from 'react';

interface PdfSettingsProps {
  defaultValue?: string;
}

export const PdfSettings = ({ defaultValue }: PdfSettingsProps) => {
  return <div className="p-4 border-b">PDF Settings Navigation (Active: {defaultValue})</div>;
};
