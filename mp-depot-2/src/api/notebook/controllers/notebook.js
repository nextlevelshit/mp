'use strict';

/**
 * notebook controller
 */

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::notebook.notebook');
