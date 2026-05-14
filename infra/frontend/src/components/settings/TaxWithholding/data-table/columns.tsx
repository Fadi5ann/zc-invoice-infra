import { CreateTaxWithholdingDto } from '@/types';
import { ColumnDef } from '@tanstack/react-table';
import { DataTableRowActions } from '@/components/shared/data-table/data-table-row-actions';
import { DataTableColumnHeader } from './data-table-column-header';
import { DataTableConfig } from '@/components/shared/data-table/types';

export const getTaxWithholdingColumns = (
  t: Function,
  context: DataTableConfig<CreateTaxWithholdingDto>
): ColumnDef<CreateTaxWithholdingDto>[] => {
  const translate = (value: string) => {
    return t(value);
  };

  return [
    {
      accessorKey: 'id',
      header: ({ column }) => (
        <DataTableColumnHeader column={column} title="ID" attribute="id" />
      ),
      cell: ({ row }) => <div>{row.original.id}</div>,
      enableSorting: true,
      enableHiding: true
    },
    {
      accessorKey: 'label',
      header: ({ column }) => (
        <DataTableColumnHeader
          column={column}
          title={translate('withholding.attributes.label') || 'Label'}
          attribute="label"
        />
      ),
      cell: ({ row }) => <div className="font-bold">{row.original.label}</div>,
      enableSorting: true,
      enableHiding: true
    },
    {
      accessorKey: 'rate',
      header: ({ column }) => (
        <DataTableColumnHeader
          column={column}
          title={translate('withholding.attributes.rate') || 'Rate'}
          attribute="rate"
        />
      ),
      cell: ({ row }) => <div>{row.original.rate}%</div>,
      enableSorting: true,
      enableHiding: true
    },
    {
      id: 'actions',
      cell: ({ row }) => (
        <div className="flex justify-end">
          <DataTableRowActions row={row} context={context} />
        </div>
      )
    }
  ];
};
