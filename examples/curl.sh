#!/usr/bin/env bash
# B2B Lead Enrichment Pipeline - curl examples
# Replace YOUR_TOKEN with an Apify API token (https://console.apify.com/account/integrations).

set -euo pipefail

ACTOR="Turboextract~b2b-lead-enrichment-pipeline"
TOKEN="${APIFY_TOKEN:-YOUR_TOKEN}"

# 1. A few domains with contact/about pages
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
      "domains": [
        "apify.com",
        "linear.app"
      ],
      "scrapeContactPage": true
    }'

# 2. Large list, homepage only (faster)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
      "domains": [
        "stripe.com",
        "notion.so",
        "vercel.com"
      ],
      "scrapeContactPage": false,
      "maxDomains": 500
    }'

# 3. Synchronous run - get items in the same response (small jobs only)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/run-sync-get-dataset-items?token=${TOKEN}&format=json" \
  -H "Content-Type: application/json" \
  -d '{
      "domains": [
        "apify.com"
      ]
    }'
