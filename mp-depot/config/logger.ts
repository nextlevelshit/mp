import { winston } from "@strapi/logger";

export default {
	transports: [
		new winston.transports.Console({
			format: winston.format.combine(
				winston.format.printf(({ timestamp, level, message, ...rest }) => {
					let restString = JSON.stringify(rest, undefined, 2);
					restString = restString === "{}" ? "" : restString;

					return `${timestamp}Z ${level}: ${message} ${restString}`;
				})
			)
		})
	]
};
