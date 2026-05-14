import { describe, expect, it } from 'vitest';
import { cn, formatBytes } from './utils';

describe('utils', () => {
  it('formats 0 bytes as 0 Byte', () => {
    expect(formatBytes(0)).toBe('0 Byte');
  });

  it('formats bytes using the normal size scale', () => {
    expect(formatBytes(1024)).toBe('1 KB');
    expect(formatBytes(1536, { decimals: 1 })).toBe('1.5 KB');
  });

  it('formats bytes using the accurate size scale', () => {
    expect(formatBytes(1536, { decimals: 1, sizeType: 'accurate' })).toBe('1.5 KiB');
  });

  it('merges conflicting Tailwind classes correctly', () => {
    expect(cn('px-2', 'px-4')).toBe('px-4');
    expect(cn('font-bold', 'font-medium')).toBe('font-medium');
  });
});
