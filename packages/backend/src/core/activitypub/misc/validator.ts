/*
 * SPDX-FileCopyrightText: syuilo and misskey-project
 * SPDX-License-Identifier: AGPL-3.0-only
 */

import type { Response } from 'node-fetch';

function parseContentTypeParameters(contentType: string): Map<string, string> {
	const params = new Map<string, string>();
	const parts = contentType.split(';').slice(1);

	for (const part of parts) {
		const trimmed = part.trim();
		if (trimmed === '') continue;

		const separatorIndex = trimmed.indexOf('=');
		if (separatorIndex === -1) continue;

		const key = trimmed.slice(0, separatorIndex).trim().toLowerCase();
		let value = trimmed.slice(separatorIndex + 1).trim().toLowerCase();

		if (value.startsWith('"') && value.endsWith('"') && value.length >= 2) {
			value = value.slice(1, -1);
		}

		params.set(key, value);
	}

	return params;
}

export function validateContentTypeSetAsActivityPub(response: Response): void {
	const contentType = (response.headers.get('content-type') ?? '').toLowerCase();

	if (contentType === '') {
		throw new Error('Validate content type of AP response: No content-type header');
	}

	const params = parseContentTypeParameters(contentType);
	const hasActivityStreamsProfile =
		params.get('profile') === 'https://www.w3.org/ns/activitystreams' ||
		params.get('@profile') === 'https://www.w3.org/ns/activitystreams';

	if (
		contentType.startsWith('application/activity+json') ||
		(contentType.startsWith('application/ld+json;') && hasActivityStreamsProfile)
	) {
		return;
	}
	throw new Error('Validate content type of AP response: Content type is not application/activity+json or application/ld+json');
}

const plusJsonSuffixRegex = /^\s*(application|text)\/[a-zA-Z0-9\.\-\+]+\+json\s*(;|$)/;

export function validateContentTypeSetAsJsonLD(response: Response): void {
	const contentType = (response.headers.get('content-type') ?? '').toLowerCase();

	if (contentType === '') {
		throw new Error('Validate content type of JSON LD: No content-type header');
	}
	if (
		contentType.startsWith('application/ld+json') ||
		contentType.startsWith('application/json') ||
		plusJsonSuffixRegex.test(contentType)
	) {
		return;
	}
	throw new Error('Validate content type of JSON LD: Content type is not application/ld+json or application/json');
}
