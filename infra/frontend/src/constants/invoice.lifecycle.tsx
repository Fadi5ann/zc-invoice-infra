import React from 'react';
import { INVOICE_STATUS } from '@/types';
import { Save, Check, Send, Copy, Download, Trash, RefreshCcw } from 'lucide-react';

export const INVOICE_LIFECYCLE_ACTIONS = {
  save: {
    label: 'commands.save',
    variant: 'default' as const,
    icon: <Save size={16} />,
    when: {
      membership: 'IN' as const,
      set: [INVOICE_STATUS.Nonexistent]
    }
  },
  draft: {
    label: 'commands.save_as_draft',
    variant: 'default' as const,
    icon: <Save size={16} />,
    when: {
      membership: 'IN' as const,
      set: [INVOICE_STATUS.Draft, INVOICE_STATUS.Validated]
    }
  },
  validated: {
    label: 'commands.validate',
    variant: 'default' as const,
    icon: <Check size={16} />,
    when: {
      membership: 'IN' as const,
      set: [INVOICE_STATUS.Draft]
    }
  },
  sent: {
    label: 'commands.send',
    variant: 'outline' as const,
    icon: <Send size={16} />,
    when: {
      membership: 'IN' as const,
      set: [INVOICE_STATUS.Validated]
    }
  },
  duplicate: {
    label: 'commands.duplicate',
    variant: 'outline' as const,
    icon: <Copy size={16} />,
    when: {
      membership: 'OUT' as const,
      set: [undefined, INVOICE_STATUS.Nonexistent]
    }
  },
  download: {
    label: 'commands.download',
    variant: 'outline' as const,
    icon: <Download size={16} />,
    when: {
      membership: 'OUT' as const,
      set: [undefined, INVOICE_STATUS.Nonexistent, INVOICE_STATUS.Draft]
    }
  },
  delete: {
    label: 'commands.delete',
    variant: 'outline' as const,
    icon: <Trash size={16} />,
    when: {
      membership: 'IN' as const,
      set: [INVOICE_STATUS.Draft]
    }
  },
  reset: {
    label: 'commands.reset',
    variant: 'outline' as const,
    icon: <RefreshCcw size={16} />,
    when: {
      membership: 'IN' as const,
      set: [INVOICE_STATUS.Nonexistent, INVOICE_STATUS.Draft]
    }
  }
};