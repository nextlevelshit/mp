export const scrollProgress = () => {
	const { documentElement, body } = document;
	const windowScroll = body.scrollTop || documentElement.scrollTop;
	const height = documentElement.scrollHeight - documentElement.clientHeight;
	return Math.round((windowScroll / height) * 100);
};
