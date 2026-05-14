import { Tax } from '@/types';
import { ColumnDef } from '@tanstack/react-table';
import { Badge } from '@/components/ui/badge';
import { Label } from '@/components/ui/label';
import { DataTableColumnHeader } from './data-table-column-header';
import { DataTableRowActions } from './data-table-row-actions';

export const getTaxColumns = (
  tSettings: any,
  tCommon: any,
  tCurrency: any
): ColumnDef<Tax>[] => {
  return [
    {
      accessorKey: 'label',
      header: ({ column }) => (
        <DataTableColumnHeader column={column} title="Label" attribute="label" />
      ),
      cell: ({ row }) => <Label>{row.original.label}</Label>,
      enableSorting: true,
      enableHiding: true
    },
    {
      accessorKey: 'value',
      header: ({ column }) => (
        <DataTableColumnHeader column={column} title="Value" attribute="value" />
      ),
      cell: ({ row }) => <Label>{row.original.value}</Label>,
      enableSorting: true,
      enableHiding: true
    },
    {
      accessorKey: 'type',
      header: ({ column }) => (
        <DataTableColumnHeader column={column} title="Type" attribute="type" />
      ),
      cell: ({ row }) => <Label>{(row.original as any).type}</Label>,
      enableSorting: true,
      enableHiding: true
    },
    {
      id: 'actions',
      cell: ({ row }) => {
        return (
          <div className="flex justify-end">
             <DataTableRowActions row={row} />
          </div>
        );
      }
    }
  ];
};
