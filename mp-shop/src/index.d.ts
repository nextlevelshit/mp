declare global {
	interface Window {
		umami?: {
			track: (event: string, data?: Record<string, any>) => void;
		};
	}
}

export {};
