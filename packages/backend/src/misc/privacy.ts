/*
 * SPDX-FileCopyrightText: Splamei
 * SPDX-License-Identifier: AGPL-3.0-only
 */

// Masks the last segment of IPs for privacy
export function maskIp(ip: string | undefined | null): string
{
    if (!ip) return '0.0.0.0';
  
    if (ip.includes('.'))
    {
        return ip.replace(/\.\d+$/, '.0');
    }
    else if (ip.includes(':'))
    {
        const parts = ip.split(':');
        return `${parts.slice(0, 3).join(':')}::`;
    }
  
    return ip;
}