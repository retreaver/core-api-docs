# Payout bid modification tables

<aside class="notice">
This is a detailed, rules-engine-shaped API. If you're setting up Payout Bid Modification for the first time, start with the conceptual guide at <a href="https://learn.retreaver.com/guides/payout-bid-modification" target="_blank">learn.retreaver.com/guides/payout-bid-modification</a> before working through the reference below.
</aside>

A Payout Bid Modification (PBM) table is a CSV of rules, uploaded to a Campaign, that adjusts the payout percentage of an RTB ping based on its attributes (caller state, revenue, a deterministic bucket assignment, or any other tag key) — for example, to run a Control/Treatment payout experiment, or to apply a rate card from a rules provider.

A table is **write-once**: `csv_data`, `salt`, and `table_version` can only be set on create. The only thing you can ever change afterward is `active` — flipping it is how you roll a campaign forward to a new table, or roll it back to a previous one. A campaign can have many uploaded tables (its upload history), but only one may be `active` at a time; activating one automatically deactivates whichever table was previously active for that campaign.

## The rule CSV format

Each row is one rule, evaluated top to bottom — the first matching row wins. Two columns are reserved:

Column | Meaning
------ | -------
rule_id | Carried through unchanged, used for logging/reporting.
payout_pct | The percentage of revenue to pay out when this rule matches (e.g. `70`), or the literal string `current` to leave the payout unmodified.

Every other column header is a real Retreaver tag key, used as-is — e.g. `caller_state`, `sub_id`, `revenue`, `system_affiliate_id`, or `pbm_bucket` (the ping's deterministic bucket assignment, 0-9999, used for percentage-based traffic splits). Each cell uses the same `key:operator:value` shorthand used elsewhere in Retreaver for tag conditions, minus the `key:` part (the column header already says which key):

- A plain value defaults to equality, e.g. `CO`.
- Prefix an operator for anything else, e.g. `!=CA`, `>=5000`, or `=~^(CO|NY|TX)$` to match a whole set of values in one row.
- `*`, or leaving the column out of a row entirely, means "no constraint" for that row.

The **same key can appear as more than one column** to AND multiple comparators together — e.g. two `pbm_bucket` columns, `>=5000` and `<7500`, express a bucket range (there's no dedicated `bucket_from`/`bucket_to` — it's just `pbm_bucket` twice, like any other tag key range).

<aside class="warning">
For Affiliates, Campaigns, and Targets there are two different keys, matching the <a href="#our-ids-vs-customer-ids">Our IDs vs Customer IDs</a> distinction elsewhere in this API — and picking the wrong one matches silently, it won't error:

Key | Matches on
--- | ----------
`system_affiliate_id`, `system_campaign_id`, `system_target_id` | Retreaver's own internal ID (the `id` in every JSON response in this API).
`affiliate_id`, `campaign_id`, `target_id` | The client-supplied external ID (`afid`/`cid`/`tid`) — the one set by whoever integrated with Retreaver on that object, not Retreaver's own ID.

If a rules provider is handing you rule CSVs keyed on Retreaver's own IDs (the normal case — it's what every other endpoint in this API calls `affiliate_id`/`campaign_id`/`target_id`), use the `system_*` column.
</aside>

~~~csv
rule_id,caller_state,pbm_bucket,pbm_bucket,payout_pct
1,=~^(CO|NY|TX)$,*,*,70
2,*,>=5000,<7500,60
3,*,*,*,current
~~~

Limits: at most 1000 rules per table, 1MB of CSV per upload.

## Create a Payout Bid Modification table

~~~shell
curl -s -X POST "https://api.retreaver.com/api/v5/campaigns/16728/payout_bid_modification_tables.json?api_key=woofwoofwoof" \
  -H "Content-Type: application/json" \
  -d '{
        "payout_bid_modification_table": {
          "csv_data": "rule_id,caller_state,pbm_bucket,pbm_bucket,payout_pct\n1,=~^(CO|NY|TX)$,*,*,70\n2,*,>=5000,<7500,60\n3,*,*,*,current\n",
          "active": true
        }
      }'
~~~

> The above command returns JSON structured like this:

~~~json
{
  "id": 9001,
  "campaign_id": 16728,
  "table_version": 9001,
  "active": true,
  "salt": "acme_inc_2026-09-15",
  "csv_data": "rule_id,caller_state,pbm_bucket,pbm_bucket,payout_pct\n1,=~^(CO|NY|TX)$,*,*,70\n2,*,>=5000,<7500,60\n3,*,*,*,current\n",
  "created_at": "2026-09-15T18:04:22Z"
}
~~~

### HTTP Request

`POST https://api.retreaver.com/api/v5/campaigns/:campaign_id/payout_bid_modification_tables.json?api_key=woofwoofwoof`

`Content-Type: application/json`

### Parameters

Parameter | Type | Required | Description
--------- | ---- | -------- | -----------
csv_data | string | Yes | The rule CSV, as described above.
active | boolean | No | Defaults to `false`. Set `true` to activate this table immediately (deactivating whichever table was previously active on the campaign).
salt | string | No | Makes bucket assignment independently verifiable — the same `(salt, call_uuid)` pair always produces the same `pbm_bucket`, so whoever supplied the CSV can recompute it on their side and confirm the assignment. If you omit it, one is derived automatically from your company name and the upload date. To pull each call's actual `pbm_bucket` (and other `pbm_*` result fields) alongside its Call data for that verification, see [Example: merging Calls and RTB Inbounds by call_uuid](#example-merging-calls-and-rtb-inbounds-by-calluuid).
table_version | string | No | An optional label for this upload (e.g. to match a rules provider's own revision numbering), unique per campaign. If omitted, it defaults to this table's own `id`. This is a label only — it is never the lookup key; every route below identifies a table by `id`.

If `csv_data` doesn't parse (bad CSV, unknown operator, too many rules, over the size limit), the response is:

~~~json
{ "errors": ["Csv data could not be parsed into rules (...)"] }
~~~

## List a campaign's Payout Bid Modification tables

~~~shell
curl "https://api.retreaver.com/api/v5/campaigns/16728/payout_bid_modification_tables.json?api_key=woofwoofwoof"
~~~

> The above command returns JSON structured like this:

~~~json
[
  {
    "id": 9001,
    "campaign_id": 16728,
    "table_version": 9001,
    "active": true,
    "salt": "acme_inc_2026-09-15",
    "csv_data": "rule_id,caller_state,pbm_bucket,pbm_bucket,payout_pct\n1,=~^(CO|NY|TX)$,*,*,70\n2,*,>=5000,<7500,60\n3,*,*,*,current\n",
    "created_at": "2026-09-15T18:04:22Z"
  }
]
~~~

### HTTP Request

`GET https://api.retreaver.com/api/v5/campaigns/:campaign_id/payout_bid_modification_tables.json?api_key=woofwoofwoof`

Returned most-recently-uploaded first.

## Get a specific Payout Bid Modification table

~~~shell
curl "https://api.retreaver.com/api/v5/campaigns/16728/payout_bid_modification_tables/9001.json?api_key=woofwoofwoof"
~~~

### HTTP Request

`GET https://api.retreaver.com/api/v5/campaigns/:campaign_id/payout_bid_modification_tables/:id.json?api_key=woofwoofwoof`

Same response shape as create, above.

## Activate or roll back a table

The only field an update can change is `active`. To roll a campaign back to a previous upload, activate that older table's `id` — this deactivates whatever table is currently active on the campaign the same way creating with `active: true` does.

~~~shell
curl -s -X PUT "https://api.retreaver.com/api/v5/campaigns/16728/payout_bid_modification_tables/9001.json?api_key=woofwoofwoof" \
  -H "Content-Type: application/json" \
  -d '{ "payout_bid_modification_table": { "active": false } }'
~~~

### HTTP Request

`PUT https://api.retreaver.com/api/v5/campaigns/:campaign_id/payout_bid_modification_tables/:id.json?api_key=woofwoofwoof`

`Content-Type: application/json`

### Parameters

Parameter | Type | Required | Description
--------- | ---- | -------- | -----------
active | boolean | Yes | `true` to activate this table (deactivating the campaign's current one); `false` to deactivate it without activating anything else.

## Delete a Payout Bid Modification table

~~~shell
curl -X DELETE "https://api.retreaver.com/api/v5/campaigns/16728/payout_bid_modification_tables/9001.json?api_key=woofwoofwoof"
~~~

Returns an empty `200 OK` body on success.

### HTTP Request

`DELETE https://api.retreaver.com/api/v5/campaigns/:campaign_id/payout_bid_modification_tables/:id.json?api_key=woofwoofwoof`

<aside class="notice">
Deleting a table is permanent and removes it from the campaign's upload history — it does not deactivate-and-keep, the way updating <code>active</code> to <code>false</code> does. If you might want to roll back to it later, deactivate it instead of deleting it.
</aside>

## Script Example: a data-driven payout reduction, split as a Control/Treatment test

A common use of Payout Bid Modification is a payout experiment per publisher: pay less on part of a publisher's traffic and leave the rest as a control group, so the impact is measurable against a baseline instead of applied blind. This script builds one from real data — it reads the merged Calls + RTB Inbounds file from the [merge example](#example-merging-calls-and-rtb-inbounds-by-calluuid) in Exports, computes each publisher's actual current payout rate from their `claimed` traffic, and generates a table that pays 10% less than that rate on half of each publisher's traffic (bucket-split, so the split is stable and deterministic per call). The other half — the control group — gets no rule at all: a bucket you don't want to change is simply left out of the CSV, and the trailing catch-all row (`payout_pct=current`) covers it, rather than writing an explicit "current" row for every publisher.

<aside class="warning">
This is a demo, not a recommendation — a flat 10% cut, a straight sum(Payout)/sum(Revenue) rate, and an even 50/50 split are all one arbitrary, simple choice. The actual work in a payout experiment like this is everything this script glosses over: what "current rate" should mean for a publisher whose mix of traffic varies (by hour, by geography, by conversion type), how big a change is worth testing and for how long, what split gives you a statistically meaningful read, and how you pull fresh data and recompute as the experiment runs rather than uploading a rule once and forgetting it. Treat the shape here — receive data, calculate rules, upload — as the scaffolding, and put your own math into it.
</aside>

<aside class="warning">
The merged file's publisher-id column is RTB Inbounds' own <code>affiliate_id</code> — Retreaver's internal id, not a client-supplied one — so the generated rules key on <code>system_affiliate_id</code>, not <code>affiliate_id</code>. See the <a href="#the-rule-csv-format">warning above</a> about the two being different things.
</aside>

<aside class="warning">
That column's header text isn't fixed, because different accounts use different terminology: it's <code>Source ID</code> on the old/Enterprise nomenclature (the default), but <code>Publisher ID</code> on a Performance Marketing account — same <code>affiliate_id</code> field underneath, just labeled differently per company. The script checks for either.
</aside>

~~~ruby
# How to run:
#   ruby build_payout_reduction.rb <campaign_id> <calls_with_rtb_inbounds.csv>
#
# calls_with_rtb_inbounds.csv — from the merge example in Exports.
#
# This computes real numbers from your data and then activates a table immediately on
# real traffic — review the printed per-publisher rates before confirming.

require 'csv'
require 'json'
require 'net/http'
require 'uri'

API_KEY = "woofwoofwoof"
BASE_URL = "https://api.retreaver.com"
PAYOUT_REDUCTION = 0.10  # pay 10% less than the current rate
TREATMENT_BUCKETS = 0...5000  # half the 0-9999 bucket space; the rest is the control group

campaign_id, merged_csv_path = ARGV
if campaign_id.nil? || merged_csv_path.nil?
  abort "Usage: ruby #{$PROGRAM_NAME} <campaign_id> <calls_with_rtb_inbounds.csv>"
end

rows = CSV.read(merged_csv_path, headers: true)

# The publisher-id column is "Source ID" on the default (old/Enterprise) nomenclature, or
# "Publisher ID" on a Performance Marketing account — same affiliate_id field, different
# label per company. Accept either rather than assuming one.
publisher_id_header = (rows.headers || []).find { |h| ["Source ID", "Publisher ID"].include?(h) }
unless publisher_id_header
  abort "Could not find a 'Source ID' or 'Publisher ID' column in #{merged_csv_path}"
end

claimed = rows.select { |row| row["Status"] == "claimed" && row["Campaign ID"] == campaign_id }
abort "No claimed RTB Inbounds found for campaign #{campaign_id} in #{merged_csv_path}" if claimed.empty?

other_campaigns = rows.map { |row| row["Campaign ID"] }.uniq - [campaign_id]
puts "Note: ignoring other campaign(s) in this file: #{other_campaigns.join(', ')}" if other_campaigns.any?

# Sum Revenue/Payout per publisher across their claimed rows — see the aside above for why
# this becomes system_affiliate_id, not affiliate_id, in the rules.
totals = claimed.each_with_object(Hash.new { |h, k| h[k] = { revenue: 0.0, payout: 0.0 } }) do |row, sums|
  publisher_totals = sums[row[publisher_id_header]]
  publisher_totals[:revenue] += row["Revenue"].to_f
  publisher_totals[:payout] += row["Payout"].to_f
end

csv_rows = [["rule_id", "system_affiliate_id", "pbm_bucket", "pbm_bucket", "payout_pct"]]
rule_id = 0

puts "Payout changes for campaign #{campaign_id} (10% off on half of traffic, current rate on the other half):"

totals.each do |publisher_id, sums|
  next if sums[:revenue].zero? # no revenue, no rate to derive

  current_pct = (sums[:payout] / sums[:revenue] * 100).round(2)
  reduced_pct = (current_pct * (1 - PAYOUT_REDUCTION)).round(2)
  puts "  publisher #{publisher_id}: #{current_pct}% -> #{reduced_pct}% on bucket #{TREATMENT_BUCKETS}, unchanged on the rest"

  # Only the treatment half gets a rule. The control half is deliberately left OUT of the
  # rules entirely, rather than given its own "current" row — it falls through to the
  # catch-all below, same as any publisher/bucket we never wrote a rule for.
  rule_id += 1
  csv_rows << [rule_id, publisher_id, ">=#{TREATMENT_BUCKETS.begin}", "<#{TREATMENT_BUCKETS.end}", reduced_pct]
end

rule_id += 1
csv_rows << [rule_id, "*", "*", "*", "current"] # everything not matched above (control buckets, other publishers) stays unmodified

csv_data = csv_rows.map(&:to_csv).join
puts "\n#{csv_data}"

print "Press Enter to upload and activate this table now, or Ctrl+C to cancel... "
STDIN.gets

create_uri = URI.parse("#{BASE_URL}/api/v5/campaigns/#{campaign_id}/payout_bid_modification_tables.json?api_key=#{API_KEY}")
body = { payout_bid_modification_table: { csv_data: csv_data, active: true } }
response = JSON.parse(Net::HTTP.post(create_uri, body.to_json, "Content-Type" => "application/json").body)

if response["errors"]
  abort "Upload failed: #{response["errors"].join(", ")}"
end

puts "Uploaded and activated table id=#{response["id"]} (table_version=#{response["table_version"]}) on campaign #{campaign_id}."
~~~
