export default ({env}) => ({
  documentation: {
    enabled: true,
    config: {
      "openapi": "3.0.1",
      "info": {
        "version": "1.0.0",
        "title": "MUELLERPTINTS. Paperwork",
        "description": "API Documentation for MUELLERPRINTS. Paperwork",
        "termsOfService": false,
        "contact": false,
        "license": false,
        "externalDocs": false
      },
      "x-strapi-config": {
        "plugins": ["upload"],
        "path": "/documentation"
      },
      "servers": [
        {
          "url": "/api",
          "description": "Docker Container"
        },
        {
          "url": "http://localhost:5555/api",
          "description": "Local Development"
        }
      ],
      "security": [
        {
          "bearerAuth": []
        }
      ]
    }
  },
  'strapi-prometheus': {
    enabled: true,
    config: {
      // add prefix to all the prometheus metrics names.
      prefix: 'mp_depot',

      // use full url instead of matched url
      // true  => path label: `/api/models/1`
      // false => path label: `/api/models/:id`
      fullURL: false,

      // include url query in the url label
      // true  => path label: `/api/models?limit=1`
      // false => path label: `/api/models`
      includeQuery: false,

      // metrics that will be enabled, by default they are all enabled.
      enabledMetrics: {
        koa: true, // koa metrics
        process: true, // metrics regarding the running process
        http: true, // http metrics like response time and size
        apollo: true, // metrics regarding graphql
      },

      // interval at which rate metrics are collected in ms
      interval: 30_000,

      // set custom/default labels to all the prometheus metrics
      customLabels: {
        name: "strapi-prometheus",
      },
    }
  }
})
