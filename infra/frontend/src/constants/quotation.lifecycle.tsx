import React from 'react';
import { QUOTATION_STATUS } from '@/types';
import { Save, Check, Send, Copy, Download, Trash, RefreshCcw, FileText, X } from 'lucide-react';

export const QUOTATION_LIFECYCLE_ACTIONS = {
  save: {
    label: 'commands.save',
    variant: 'default' as const,
    icon: <Save size={16} />,
    when: {
      membership: 'IN' as const,
      set: [QUOTATION_STATUS.Nonexistent]
    }
  },
  draft: {
    label: 'commands.save_as_draft',
    variant: 'default' as const,
    icon: <Save size={16} />,
    when: {
      membership: 'IN' as const,
      set: [QUOTATION_STATUS.Draft, QUOTATION_STATUS.Validated]
    }
  },
  validated: {
    label: 'commands.validate',
    variant: 'default' as const,
    icon: <Check size={16} />,
    when: {
      membership: 'IN' as const,
      set: [QUOTATION_STATUS.Draft]
    }
  },
  sent: {
    label: 'commands.send',
    variant: 'outline' as const,
    icon: <Send size={16} />,
    when: {
      membership: 'IN' as const,
      set: [QUOTATION_STATUS.Validated]
    }
  },
  accepted: {
    label: 'commands.accept',
    variant: 'default' as const,
    icon: <Check size={16} />,
    when: {
      membership: 'IN' as const,
      set: [QUOTATION_STATUS.Sent]
    }
  },
  rejected: {
    label: 'commands.reject',
    variant: 'outline' as const,
    icon: <X size={16} />,
    when: {
      membership: 'IN' as const,
      set: [QUOTATION_STATUS.Sent]
    }
  },
  invoiced: {
    label: 'commands.invoice',
    variant: 'default' as const,
    icon: <FileText size={16} />,
    when: {
      membership: 'IN' as const,
      set: [QUOTATION_STATUS.Accepted]
    }
  },
  duplicate: {
    label: 'commands.duplicate',
    variant: 'outline' as const,
    icon: <Copy size={16} />,
    when: {
      membership: 'OUT' as const,
      set: [undefined, QUOTATION_STATUS.Nonexistent]
    }
  },
  download: {
    label: 'commands.download',
    variant: 'outline' as const,
    icon: <Download size={16} />,
    when: {
      membership: 'OUT' as const,
      set: [undefined, QUOTATION_STATUS.Nonexistent, QUOTATION_STATUS.Draft]
    }
  },
  delete: {
    label: 'commands.delete',
    variant: 'outline' as const,
    icon: <Trash size={16} />,
    when: {
      membership: 'IN' as const,
      set: [QUOTATION_STATUS.Draft]
    }
  },
  reset: {
    label: 'commands.reset',
    variant: 'outline' as const,
    icon: <RefreshCcw size={16} />,
    when: {
      membership: 'IN' as const,
      set: [undefined, QUOTATION_STATUS.Nonexistent, QUOTATION_STATUS.Draft]
    }
  }
};
