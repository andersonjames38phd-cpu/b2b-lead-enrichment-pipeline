// B2B Lead Enrichment Pipeline - Node.js example.
//
// Install:
//   npm install apify-client
//
// Run:
//   APIFY_TOKEN=your_token node node.mjs

import { ApifyClient } from 'apify-client';

const TOKEN = process.env.APIFY_TOKEN ?? 'YOUR_TOKEN';
const ACTOR = 'Turboextract/b2b-lead-enrichment-pipeline';

const client = new ApifyClient({ token: TOKEN });

// 1. Start the actor and wait for it to finish
const runInput = {
    domains: ['apify.com', 'linear.app'],
    scrapeContactPage: true,
};

const run = await client.actor(ACTOR).call(runInput);

// 2. Pull dataset items
const { items } = await client.dataset(run.defaultDatasetId).listItems();

for (const item of items) {
    console.log(item.domain, '-', item.companyName);
    console.log('   tech:', item.techStack.join(', '));
}

console.log(`\n${items.length} domains returned.`);

// 3. Or stream item-by-item (useful for large jobs)
// for await (const item of client.dataset(run.defaultDatasetId).iterate()) {
//     console.log(item);
// }
