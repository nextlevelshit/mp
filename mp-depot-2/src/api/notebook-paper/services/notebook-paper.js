'use strict';

/**
 * notebook-paper service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::notebook-paper.notebook-paper');
