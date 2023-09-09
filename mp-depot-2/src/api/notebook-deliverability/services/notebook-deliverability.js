'use strict';

/**
 * notebook-deliverability service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::notebook-deliverability.notebook-deliverability');
