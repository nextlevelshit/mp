#!/bin/bash

JSON_DATA='
{
  "subject": "Rechnung",
  "date": "\\today",
  "me": {
    "name": "MUELLERPRINTS",
    "street": "Rotenbergstr. 123",
    "city": "12345 Stuttgart",
    "email": "muellerprints@t-online.de",
    "url": "https://muellerprints.de"
  },
  "to": {
    "name": "Doris Müller",
    "address": [
      "Alexanderstr 123",
      "12345 Stuttgart"
    ]
  },
  "VAT": 20,
  "service": [
    {
      "description": "The first service provided",
      "price": 450.00
    },
    {
      "description": "And another one, with a list of details",
      "price": 245.00,
      "details": [
        "Some more detailed explanation",
        "of the service provided",
        "Looking good"
      ]
    },
    {
      "description": "The last service provided",
      "price": 245.00
    }
  ],
  "body": "**Gewählte Zahlungsart:** PayPal\n\nDie Rechnung wurde per **PayPall** bereits beglichen.\n\nVielen Dank für Ihren Einkauf"
}'

curl -X POST http://localhost:1111/mp-inkasso/invoice \
  -H "Content-Type: application/json" \
  -d "$JSON_DATA"
