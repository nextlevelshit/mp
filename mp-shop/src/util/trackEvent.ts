import debug from "debug";

const logger = debug("app:i:track-event");
const verbose = debug("app:v:track-event");

export const trackEvent = (event: string, data?: Record<string, any>) => {
	if (window.umami) {
		window.umami.track(event, data);
	} else {
		verbose("No tracking available");
	}
}
