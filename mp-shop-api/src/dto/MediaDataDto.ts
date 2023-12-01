import { MediaData } from "../util/types";

export class MediaDataDto {
	private readonly mediaData: MediaData;

	constructor(mediaData: MediaData) {
		this.mediaData = mediaData;
	}

	get id(): number {
		return this.mediaData.id;
	}

	get name(): string {
		return this.mediaData.attributes.name;
	}

	get alternativeText(): string | null {
		return this.mediaData.attributes.alternativeText;
	}

	get caption(): string | null {
		return this.mediaData.attributes.caption;
	}

	get width(): number | null {
		return this.mediaData.attributes.width;
	}

	get height(): number | null {
		return this.mediaData.attributes.height;
	}

	get formats(): {
		[key: string]: {
			ext: string;
			url: string;
			hash: string;
			mime: string;
			size: number;
			width: number;
			height: number;
		} | null;
	} | null {
		return this.mediaData.attributes.formats;
	}

	get hash(): string {
		return this.mediaData.attributes.hash;
	}

	get ext(): string {
		return this.mediaData.attributes.ext;
	}

	get mime(): string {
		return this.mediaData.attributes.mime;
	}

	get size(): number {
		return this.mediaData.attributes.size;
	}

	get url(): string {
		return this.mediaData.attributes.url;
	}

	get previewUrl(): string | null {
		return this.mediaData.attributes.previewUrl;
	}

	get provider(): string {
		return this.mediaData.attributes.provider;
	}

	get providerMetadata(): any | null {
		return this.mediaData.attributes.provider_metadata;
	}

	get dto(): MediaDataDtoData {
		return {
			id: this.id,
			name: this.name,
			alternativeText: this.alternativeText,
			caption: this.caption,
			width: this.width,
			height: this.height,
			formats: this.formats,
			hash: this.hash,
			ext: this.ext,
			mime: this.mime,
			size: this.size,
			url: this.url,
			previewUrl: this.previewUrl,
			provider: this.provider,
			providerMetadata: this.providerMetadata
		};
	}
}

export interface MediaDataDtoData {
	id: number;
	name: string;
	alternativeText: string | null;
	caption: string | null;
	width: number | null;
	height: number | null;
	formats: {
		[key: string]: {
			ext: string;
			url: string;
			hash: string;
			mime: string;
			size: number;
			width: number;
			height: number;
		} | null;
	} | null;
	hash: string;
	ext: string;
	mime: string;
	size: number;
	url: string;
	previewUrl: string | null;
	provider: string;
	providerMetadata: any | null;
}
