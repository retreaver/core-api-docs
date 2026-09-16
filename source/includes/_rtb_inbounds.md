# RtbInbounds

RtbInbounds is the log of inbound [Real-Time Bidding](#real-time-bidding-rtb) reservations — one row per RTB ping your campaign received, whether it was claimed, expired, rejected, or resulted in no target. It's the same data shown on the RTB Inbounds dashboard in your account.

This endpoint returns a live, filtered page of recent rows. To pull a large historical range as a single file, use [Exports](#exports) instead.

## Get all RTB Inbounds

~~~shell
curl "https://api.retreaver.com/api/v5/rtb_inbounds.json?api_key=woofwoofwoof&campaign_id[]=123&created_at=last_7d"
~~~

> The above command returns JSON structured like this:

~~~json
{
  "rtb_inbounds": [
    {
      "call_uuid": "3d745a09-6e2b-4b8f-9e7d-9a2f6a9d9d21",
      "uuid": "8f0a2d13-9d3a-4b3e-9a7a-6b8e4b9d9a21",
      "postback_key_id": 456,
      "caller_number": "+15551234567",
      "affiliate_id": 789,
      "campaign_id": 123,
      "target_id": 321,
      "revenue": 12.5,
      "payout": 8.75,
      "status": "claimed",
      "duplicate_order": 0,
      "duplicate_original_uuid": "00000000-0000-0000-0000-000000000000",
      "caller_state": "TX",
      "caller_city": "Austin",
      "caller_zip": "78701",
      "caller_country": "US",
      "created_at": "2026-09-01T14:02:11Z",
      "confirmed_at": "2026-09-01T14:02:12Z",
      "ended_at": "2026-09-01T14:05:41Z",
      "time_to_resolve": 1.2,
      "fired_pixels_count": 2,
      "fired_pixels_error_count": 0,
      "pbm_table_version": "7",
      "pbm_rule_id": 2,
      "pbm_bucket": 6231,
      "pbm_variant": "treatment",
      "pbm_original_payout": 10.0,
      "pbm_percent_of_revenue": 70
    }
  ]
}
~~~

### HTTP Request

`GET https://api.retreaver.com/api/v5/rtb_inbounds.json?api_key=woofwoofwoof`

This endpoint is versioned like the rest of the API — `v2`, `v3`, `v4`, and `v5` all serve the same data.

### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
api_key | string | Required. The api_key used to authenticate this request.
campaign_id[] | integer array | Restrict to one or more of your campaigns.
affiliate_id[] | integer array | Restrict to one or more Sources.
target_id[] | integer array | Restrict to one or more Call Endpoints.
postback_key_id[] | integer array | Restrict to one or more postback (RTB) keys.
status[] | string array | One or more of: `expired`, `claimed`, `no-target`, `rejected`.
duplicate | boolean | `true` or `false` — restrict to duplicate (or non-duplicate) reservations.
caller_state | string | Two-letter US/CA state or province abbreviation.
caller_country | string | Two-letter country abbreviation.
revenue[] | [min, max] | Two-element array, e.g. `revenue[]=20&revenue[]=30`.
payout[] | [min, max] | Two-element array, same shape as `revenue[]`.
created_at | string | A relative window, e.g. `last_7d`. Takes precedence over the explicit bounds below when present.
created_at_start | datetime | Explicit range start (ISO 8601). Ignored if `created_at` is present.
created_at_end | datetime | Explicit range end (ISO 8601). Ignored if `created_at` is present. The window between start and end can't exceed 2 months.
page | integer | Page number. Defaults to 1.
with_filters | boolean | When `true`, the response also includes a `filters` object listing every valid campaign/publisher/target/postback-key/status value for your account, so you don't have to page those resources separately just to build a picker.

<aside class="notice">
Results are always returned 100 per page — <code>per_page</code> isn't configurable on this endpoint.
</aside>

You can only filter by IDs (campaign, affiliate, target, postback key) that your api_key's account already has access to; any other IDs passed are silently dropped from the filter.

### Response fields

Field | Description
----- | -----------
call_uuid | UUID of the Call this reservation belongs to. This is the join key back to [Calls](#paginated) — note it is *not* the same value as this reservation's own `uuid`. Not every reservation results in a Call (e.g. a `rejected` or `no-target` ping); when there is none, this is the all-zero UUID `00000000-0000-0000-0000-000000000000`, not `null`.
uuid | This RTB reservation's own identifier.
status | One of `expired`, `claimed`, `no-target`, `rejected` (plus some internal Ping Shield statuses).
revenue / payout | Dollar amounts for this reservation.
time_to_resolve | Seconds between the ping and its resolution.
duplicate_original_uuid | UUID of the original reservation this one duplicates, when `duplicate` is true. Otherwise the same all-zero UUID sentinel as `call_uuid` above, never `null`.
pbm_* | Only present when [Payout Bid Modification](#payout-bid-modification-tables) is enabled for the campaign's company — see that section for what each `pbm_*` field means.

<aside class="notice">
UUID columns on RtbInbounds and its Exports are never <code>null</code> — an absent UUID is always the all-zero sentinel <code>00000000-0000-0000-0000-000000000000</code>. Check against that string rather than for null/blank.
</aside>

### Pagination

Like every paginated index in this API, responses carry a `Link` header — see [Paginated](#paginated).
