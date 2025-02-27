---
title: Retreaver Core 0.1 API Reference

language_tabs:
  - shell: cURL

toc_footers:
  - <a href='https://retreaver.com/users/sign_up'>Sign Up for a Developer Key</a>
  - <a href='https://support.retreaver.com/'>Knowledge Base</a>

includes:
  - target_groups
  - rtb
  - reports
  - deprecated_routes
  - errors

search: true
---

# Introduction

The Retreaver Core API can be used to automate core business processes, like changing where calls are routed, and many other
features that would normally be accessed through our account portal.

If you're looking for information on tracking visitors and displaying phone numbers on your landing pages, please see
our [Retreaver.js](https://github.com/retreaver/retreaver-js) library.

The API can be used to automate core business processes, but does not currently support all functionality.

*Please note: We're currently working on a better, versioned replacement for this API. But don't worry, this API isn't going away.*

## Version

This is our *unversioned* API and for sake of clarity we'll refer to it henceforth as:

`Retreaver Core API`


## Multi-format

The Retreaver Core API can be accessed by JSON or XML. Simply change the file extension and Content-Type header to match your preferences.

We recommend using JSON since XML is archaic, has high overhead, and is generally awful.

Format | Content-Type     | Extension
------ | ---------------- | ---------
JSON   | application/json | json
XML    | text/xml         | xml


## Nomenclature

Retreaver has gone through many revisions and currently uses two new sets of terms to refer to objects. Please note, this API uses our Old nomenclature.

Old          | Performance Marketing Edition | Enterprise Edition
------------ | ----------------------------- | ------------------
Affiliate    | Publisher                     | Source
Target       | Buyer                         | Contact Handler/Call Endpoint
Target Group | Buyer Group                   | Handler Group


## Our IDs vs Customer IDs

For convenience, some objects can be accessed both by the IDs set by our customers and by our internal IDs.

Affiliates, Targets, and Campaigns can be accessed via customer editable IDs as "afid", "tid", and "cid" respectively.

The "id" property in the JSON/XML document refers to our internal ID.

Object    | Our Internal ID URL | Customer Editable ID URL | Customer Editable ID Accessor
--------- | ------------------- | ------------------------ | -----------------------------
Affiliate | /affiliates/{id}    | /affiliates/afid/{afid}  | afid
Target    | /targets/{id}       | /targets/tid/{tid}       | tid
Campaign  | /campaigns/{id}     | /campaigns/cid/{cid}     | cid

These URLs work with GET, PUT, and DELETE HTTP verbs.

Please note, in many sections of the documentation below, we are referring to the Customer Editable ID URL.


## Paginated

Retreaver is a RESTful paginated API that returns 25 results per page. Each relevant index response will have a [Link HTTP header](https://www.w3.org/wiki/LinkHeader) present.

`Link: <https://retreaver.com/calls.json?api_key=woofwoofwoof&company_id=1&sort_by=created_at&order=asc&page=6996>; rel="last", <https://retreaver.com/calls.json?api_key=woofwoofwoof&company_id=1&sort_by=created_at&order=asc&page=2>; rel="next"`

By parsing the Link header, you can determine the last, next, and previous pages.


## Trees

Please note, for brevity, in appropriate places we have truncated the API output by eliminating properties of certain objects. We're also trying to save some trees in case someone actually tries to print this.


# Authentication

> To authorize, use this code:

```shell
# With cURL, you can just pass the correct API key and company_id with each request.
curl "https://api.retreaver.com/call.json?api_key=woofwoofwoof&company_id=1"
```

> Make sure to replace `woofwoofwoof` with your API key.

Retreaver uses API keys to allow access to the API. You can register a new Retreaver Core API key at our [account portal](https://retreaver.com/users/sign_up).

If you have a Retreaver account, you can find your Core API key at the bottom of your [user page](https://retreaver.com/users/edit).

Retreaver expects for the API key to be included in all API requests to the server in a query string parameter that looks like the following:

`?api_key=woofwoofwoof`

<aside class="notice">
You must replace <code>woofwoofwoof</code> with your personal API key.
</aside>

If you have access to more than one company on Retreaver, you must also pass in the company ID of the company you want to work with:

`?api_key=woofwoofwoof&company_id=1`

You can [find your company ID here](https://retreaver.com/company). We suggest passing it in anyways.

<aside class="warning">
You should <strong>never, ever expose your Retreaver Core API key publicly</strong> as it can be used to access your entire Retreaver account without restriction!
</aside>

If you suspect your API key has been publicly exposed, [reset it](https://support.retreaver.com/faq/how-do-i-get-my-api-key/).

# Calls

Or, more precisely, phone calls.

## V1 - Get recent Calls

```shell
curl "https://api.retreaver.com/calls.json?api_key=woofwoofwoof&company_id=1"
```

> The above command returns JSON structured like this:

```json
[{
   "call":{
      "uuid":"addcf985-017e-4962-be34-cf5d55e74afc",
      "caller":"+17195220377",
      "caller_zip":"80920",
      "caller_state":"CO",
      "caller_city":"COLORADO SPRINGS",
      "caller_country":"US",
      "dialed_call_duration":193,
      "total_duration":204,
      "status":"finished",
      "start_time":"2012-04-29T12:29:40Z",
      "forwarded_time":"2012-04-29T12:29:51Z",
      "end_time":"2012-04-29T12:32:46Z",
      "cid":"0003",
      "afid":"03994",
      "sid":null,
      "dialed_number":"+18668987878",
      "updated_at":"2012-04-29T12:29:46Z",
      "created_at":"2012-04-29T12:29:40Z",
      "recording_url":"http://callpixels.com/recordings/87d43a5f5c88041687f9fd1bb6a58d6f/call_17192096019_1342303189.mp3"
   }
},
{
   "call":{
      "uuid":"8ae0aa38-0173-4e62-5342-cf5d55e74afe",
      "caller":"+14166686981",
      "caller_zip":null,
      "caller_state":"ON",
      "caller_city":"TORONTO",
      "caller_country":"CA",
      "dialed_call_duration":33,
      "total_duration":40,
      "status":"finished",
      "start_time":"2012-04-29T12:29:40Z",
      "forwarded_time":"2012-04-29T12:29:51Z",
      "end_time":"2012-04-29T12:32:46Z",
      "cid":"0003",
      "afid":"03994",
      "sid":null,
      "dialed_number":"+18668987878",
      "updated_at":"2012-04-29T12:29:46Z",
      "created_at":"2012-04-29T12:29:40Z",
      "recording_url":"http://callpixels.com/recordings/87d43a5f5c88041687f9fd1bb6a58d6f/call_17192096019_1342303189.mp3"
   }
}]
```

Provides access to the call log. The call log contains all the Calls which have been made through Numbers under your control.

### HTTP Request

`GET https://api.retreaver.com/calls.json?api_key=woofwoofwoof&company_id=1`

### Query Parameters

Parameter | Format | Default | Description
--------- | ------- | ------- | -----------
company_id | `123456` |  | Return any Calls associated to the specific company IF you have access to that company.
created_at_start | `YYYY-MM-DDTHH:MM:SS+HH:MM` | -4712-01-01T00:00:00+00:00 | Return any Calls that were created after this date.
created_at_end | `YYYY-MM-DDTHH:MM:SS+HH:MM` | 4712-01-01T00:00:00+00:00 | Return any Calls that were created before this date.
sort_by | `created_at` or `updated_at` | `created_at` | Calls will be sorted by this value. If you only want recently updated Calls, sort by `updated_at`. Note that calls sorted by `updated_at` will forcefully be returned in `desc` order even if order parameter is `asc`.
order | `asc` or `desc` | `desc` | Calls will be sorted in ascending or descending order of their `sort_by` column.
caller | `%2B13015236555` | | Return only calls from the specified caller number.
client_afid | `123456` | | Return calls for an affiliate.
client_cid | `123456` | | Return calls for a specific campaign.
client_tid | `123456` | | Return calls for a specific target.
sub_id | `123456` | | Return calls for a affiliate Sub ID.

## V1 - Enumerate through all calls

 > First page...

```shell
curl "https://api.retreaver.com/calls.json?api_key=woofwoofwoof&company_id=1&sort_by=created_at&order=asc&page=1"
```

> Second page...

```shell
curl "https://api.retreaver.com/calls.json?api_key=woofwoofwoof&company_id=1&sort_by=created_at&order=asc&page=2"
```

> etc...

To fetch all Calls on your Account, use the `sort_by` and `order` params to return your Calls in the order they were
created, and then paginate through all your calls.

### HTTP Request

`https://api.retreaver.com/calls.json?api_key=woofwoofwoof&company_id=1&sort_by=created_at&order=asc&page=1`

`https://api.retreaver.com/calls.json?api_key=woofwoofwoof&company_id=1&sort_by=created_at&order=asc&page=2`


## V1 - Enumerate through Calls in a specific date/time range.

```shell
curl "https://api.retreaver.com/calls.json?api_key=woofwoofwoof&company_id=1&created_at_start=2016-01-01T00:00:00+00:00&created_at_end=2016-01-02T00:00:00+00:00&page=1"
```

By passing in `created_at_start` and `created_at_end` parameters, you can control the start and end time of Calls returned.

The timestamp should be formatted according to [rfc3339](https://validator.w3.org/feed/docs/error/InvalidRFC3339Date.html)

### HTTP Request

`GET https://api.retreaver.com/calls.json?api_key=woofwoofwoof&company_id=1&created_at_start=2016-01-01T00:00:00+00:00&created_at_end=2016-01-02T00:00:00+00:00&page=1`

## V1 - Get a specific Call

```shell
curl "https://api.retreaver.com/calls/addcf985-017e-4962-be34-cf5d55e74afc.json?api_key=woofwoofwoof&company_id=1"
```

> The above command returns JSON structured like this:

```json
{
   "call":{
      "uuid":"addcf985-017e-4962-be34-cf5d55e74afc",
      "caller":"+17195220377",
      "caller_zip":"80920",
      "caller_state":"CO",
      "caller_city":"COLORADO SPRINGS",
      "caller_country":"US",
      "dialed_call_duration":193,
      "total_duration":204,
      "status":"finished",
      "start_time":"2012-04-29T12:29:40Z",
      "forwarded_time":"2012-04-29T12:29:51Z",
      "end_time":"2012-04-29T12:32:46Z",
      "cid":"0003",
      "afid":"03994",
      "sid":null,
      "dialed_number":"+18668987878",
      "updated_at":"2012-04-29T12:29:46Z",
      "created_at":"2012-04-29T12:29:40Z",
      "recording_url":"http://callpixels.com/recordings/87d43a5f5c88041687f9fd1bb6a58d6f/call_17192096019_1342303189.mp3"
   }
}
```

Calls can be accessed by their UUID.


### HTTP Request

`GET https://api.retreaver.com/calls/addcf985-017e-4962-be34-cf5d55e74afc.json?api_key=woofwoofwoof`


## V2 - Get recent Calls

```shell
curl "https://api.retreaver.com/api/v2/calls.json?api_key=woofwoofwoof"
```

> The above command returns JSON structured like this:

```json
[
  {
    "call": {
      "uuid": "f1abfb78-ab8a-4146-9946-8169fbcc6d6c",
      "caller": "+13015236555",
      "caller_number_sent": null,
      "caller_zip": "28379",
      "caller_state": "NC",
      "caller_city": "Rockingham",
      "caller_country": "US",
      "dialed_call_duration": 2,
      "total_duration": 14,
      "ivr_duration": 7,
      "hold_duration": 5,
      "status": "finished",
      "start_time": "2024-11-04T16:52:18.034Z",
      "forwarded_time": "2024-11-04T16:52:25.423Z",
      "end_time": "2024-11-04T16:52:32.882Z",
      "cid": "1",
      "afid": null,
      "sid": null,
      "dialed_number": "+12263399112",
      "revenue": 5.0,
      "payout": 5.0,
      "postback_value": null,
      "network_sale_timer_fired": null,
      "affiliate_sale_timer_fired": null,
      "target_sale_timer_fired": null,
      "hung_up_by": "caller",
      "duplicate": false,
      "payable_duplicate": false,
      "receivable_duplicate": false,
      "callpixels_target_id": 27449,
      "system_target_id": 27449,
      "system_campaign_id": 9872,
      "system_affiliate_id": null,
      "fired_pixels_count": 4,
      "charge_total": "0.08",
      "keys_pressed": [
        "1"
      ],
      "repeat": true,
      "affiliate_repeat": false,
      "target_repeat": true,
      "number_repeat": true,
      "visitor_url": "https://example.com",
      "company_id": 2,
      "conversions_determined_at": "2024-11-04T16:52:54.744Z",
      "updated_at": "2024-11-04T16:53:00.756Z",
      "created_at": "2024-11-04T16:52:18.177Z",
      "billable_minutes": 1,
      "upstream_call_uuid": null,
      "downstream_call_uuids": [],
      "target_group": {
        "id": 1639,
        "name": "Retreaver Team"
      },
      "recording_url": "https://example.com",
      "number": "+18886064349",
      "converted": true,
      "payable": true,
      "receivable": true,
      "conversion_seconds": null,
      "tid": null,
      "tags": {
        "attempt": "0192f817-6fdc-f8b3-eb07-526dd16e2ade,0192f817-9147-eee3-25ea-e189df86dc6e",
        "geo": "301,us,us-28379,us-nc",
        "id": "0192f817-6fdc-f8b3-eb07-526dd16e2ade,0192f817-9147-eee3-25ea-e189df86dc6e",
        "request_id": "0192f817-6fdc-f8b3-eb07-526dd16e2ade,0192f817-9147-eee3-25ea-e189df86dc6e",
        "status": "success",
        "system_target_id": "27449"
      },
      "fired_pixels": [
        {
          "fired_pixel": {
            "url": "https://example.com",
            "fire_order": 1,
            "batch_uuid": "39d94d6b-639a-486b-bb21-dbba5949dd2e",
            "created_at": "2024-11-04T16:52:55.182Z",
            "fired_at": null,
            "status": "new",
            "webhook_name": null
          }
        },
        {
          "fired_pixel": {
            "url": "https://example.com",
            "fire_order": 0,
            "batch_uuid": "343ccf9b-b3a1-4cd3-b2de-a351dcf40661",
            "created_at": "2024-11-04T16:52:26.948Z",
            "fired_at": "2024-11-04T16:52:26.947Z",
            "status": "fired",
            "webhook_name": "Test Webhook"
          }
        },
        {
          "fired_pixel": {
            "url": "https://example.com",
            "fire_order": 0,
            "batch_uuid": "4ef5f708-aa5f-4918-9790-ffbe890a517d",
            "created_at": "2024-11-04T16:52:27.154Z",
            "fired_at": "2024-11-04T16:52:27.087Z",
            "status": "fired",
            "webhook_name": "Test Webhook"
          }
        },
        {
          "fired_pixel": {
            "url": "https://example.com",
            "fire_order": 0,
            "batch_uuid": "982e0d22-dd8e-4476-8e89-d967285a6929",
            "created_at": "2024-11-04T16:52:18.589Z",
            "fired_at": "2024-11-04T16:52:18.533Z",
            "status": "fired",
            "webhook_name": "Test Webhook"
          }
        }
      ],
      "via": "inbound-dial",
      "rescued": false,
      "campaign_id": 9872,
      "campaign_name": "Retreaver Main - Sales & Support",
      "number_id": 4906092,
      "target_id": 27449,
      "affiliate_name": null,
      "connected": true,
      "profit_gross": "-0.08",
      "profit_net": 0.0,
      "target_name": "Taylor Anderson - Sales - +12263399112",
      "time_to_call_in_seconds": 168096,
      "time_to_connect_in_seconds": 12,
      "total_cost": "0.08"
    }
  },
  {
    "call": {
      "uuid": "f6e88162-c6f9-4dd5-9739-652bdfc86874",
      "caller": "+13015236555",
      "caller_number_sent": null,
      "caller_zip": "28379",
      "caller_state": "NC",
      "caller_city": "Rockingham",
      "caller_country": "US",
      "dialed_call_duration": 0,
      "total_duration": 31,
      "ivr_duration": 14,
      "hold_duration": 17,
      "status": "finished",
      "start_time": "2024-11-04T16:51:41.815Z",
      "forwarded_time": null,
      "end_time": "2024-11-04T16:52:14.092Z",
      "cid": "1",
      "afid": null,
      "sid": null,
      "dialed_number": "+16477159443",
      "revenue": null,
      "payout": null,
      "postback_value": null,
      "network_sale_timer_fired": null,
      "affiliate_sale_timer_fired": null,
      "target_sale_timer_fired": null,
      "hung_up_by": "caller",
      "duplicate": false,
      "payable_duplicate": false,
      "receivable_duplicate": false,
      "callpixels_target_id": null,
      "system_target_id": null,
      "system_campaign_id": 9872,
      "system_affiliate_id": null,
      "fired_pixels_count": 5,
      "charge_total": "0.07",
      "keys_pressed": [
        "1"
      ],
      "repeat": true,
      "affiliate_repeat": false,
      "target_repeat": null,
      "number_repeat": true,
      "visitor_url": "https://example.com",
      "company_id": 2,
      "conversions_determined_at": "2024-11-04T16:52:37.091Z",
      "updated_at": "2024-11-04T16:52:37.170Z",
      "created_at": "2024-11-04T16:51:41.969Z",
      "billable_minutes": 1,
      "upstream_call_uuid": null,
      "downstream_call_uuids": [],
      "target_group": {},
      "number": "+18886064349",
      "converted": false,
      "payable": false,
      "receivable": false,
      "conversion_seconds": null,
      "tid": null,
      "tags": {
        "attempt": "0192f816-e1ec-0db1-d23a-40362aa6bb75,0192f816-ff94-522c-ee88-7011550a8066",
        "geo": "301,us,us-28379,us-nc",
        "request_id": "0192f816-e1ec-0db1-d23a-40362aa6bb75,0192f816-ff94-522c-ee88-7011550a8066",
        "status": "success"
      },
      "fired_pixels": [
        {
          "fired_pixel": {
            "url": "https://example.com",
            "fire_order": 1,
            "batch_uuid": "e2a0b1ff-99bb-469d-9feb-c0f4bb8312e4",
            "created_at": "2024-11-04T16:52:37.296Z",
            "fired_at": null,
            "status": "new",
            "webhook_name": null
          }
        },
        {
          "fired_pixel": {
            "url": "https://example.com",
            "fire_order": 0,
            "batch_uuid": "35ef3cf1-771b-46cf-9a32-514c61e21530",
            "created_at": "2024-11-04T16:51:42.267Z",
            "fired_at": "2024-11-04T16:51:42.197Z",
            "status": "fired",
            "webhook_name": "Test Webhook"
          }
        },
        {
          "fired_pixel": {
            "url": "https://example.com",
            "fire_order": 0,
            "batch_uuid": "48553bc2-e979-432e-9d21-e78870175e7a",
            "created_at": "2024-11-04T16:51:50.561Z",
            "fired_at": "2024-11-04T16:51:50.560Z",
            "status": "fired",
            "webhook_name": "Test Webhook"
          }
        },
        {
          "fired_pixel": {
            "url": "https://example.com",
            "fire_order": 0,
            "batch_uuid": "6c0ca9ce-1b07-4216-8a95-dacd98a29230",
            "created_at": "2024-11-04T16:51:49.728Z",
            "fired_at": "2024-11-04T16:51:49.728Z",
            "status": "fired",
            "webhook_name": "Test Webhook"
          }
        },
        {
          "fired_pixel": {
            "url": "https://example.com",
            "fire_order": 0,
            "batch_uuid": "80871747-a08e-4ed9-9868-195ee2717663",
            "created_at": "2024-11-04T16:51:49.851Z",
            "fired_at": "2024-11-04T16:51:49.787Z",
            "status": "fired",
            "webhook_name": "Test Webhook"
          }
        }
      ],
      "via": "inbound-dial",
      "rescued": false,
      "campaign_id": 9872,
      "campaign_name": "Retreaver Main - Sales & Support",
      "number_id": 4906092,
      "target_id": null,
      "affiliate_name": null,
      "connected": false,
      "profit_gross": "-0.07",
      "profit_net": 0,
      "target_name": null,
      "time_to_call_in_seconds": 168132,
      "time_to_connect_in_seconds": 31,
      "total_cost": "0.07"
    }
  }
]
```

Provides access to the call log. The call log contains all the Calls which have been made through Numbers under your control.

### What's new in V2?

In addition to all of the attributes, that were returned by V1, this version also returns the following fields:

attribute | Format  | Description
--------- |  ------- | -----------
affiliate_name | `"abcdef"` | The full name of the affiliate that sent the call.
campaign_id | `123456` | The ID of the campaign the call was sent to.
campaign_name | `"abcdef"` | The name of the campaign the call was sent to.
connected | `true` or `false` | Whether the caller was successfully connected to a target.
number_id | `123456` | The ID of the number that the call was received on.
profit_gross | `0.00` | The gross profit on the call. This is calculated based on the following formula: `(revenue of the call) - (payout of the call) - (total cost of the call)`
profit_net | `0.00` | The net profit on the call. This is calculated based on the following formula: `(revenue of the call) - (payout of the call)`
target_id | `123456` | The target that the caller was connected to.
target_name | `"John Doe"` | The full name of the target that the caller was connected to.
time_to_call_in_seconds | `10` | The time it took for the caller to actually make the call.
time_to_connect_in_seconds | `10` | The time it took for the caller to get connected to a buyer. This is calculated based on the following formula: `(IVR duration of the call) + (hold duration of the call)`
total_cost | `0.00` | The total cost of the call.

### HTTP Request

`GET https://api.retreaver.com/api/v2/calls.json?api_key=woofwoofwoof`

### Query Parameters

Parameter | Format | Default | Description
--------- | ------- | ------- | -----------
company_id | `123456` |  | Return any Calls associated to the specific company IF you have access to that company.
created_at_start | `YYYY-MM-DDTHH:MM:SS+HH:MM` | -4712-01-01T00:00:00+00:00 | Return any Calls that were created after this date.
created_at_end | `YYYY-MM-DDTHH:MM:SS+HH:MM` | 4712-01-01T00:00:00+00:00 | Return any Calls that were created before this date.
sort_by | `created_at` or `updated_at` | `created_at` | Calls will be sorted by this value. If you only want recently updated Calls, sort by `updated_at`. Note that calls sorted by `updated_at` will forcefully be returned in `desc` order even if order parameter is `asc`.
order | `asc` or `desc` | `desc` | Calls will be sorted in ascending or descending order of their `sort_by` column.
caller | `%2B13015236555` | | Return only calls from the specified caller number.
client_afid | `123456` | | Return calls for an affiliate.
client_cid | `123456` | | Return calls for a specific campaign.
client_tid | `123456` | | Return calls for a specific target.
sub_id | `123456` | | Return calls for a affiliate Sub ID.

## V2 - Enumerate through all calls

 > First page...

```shell
curl "https://api.retreaver.com/api/v2/calls.json?api_key=woofwoofwoof&page=1"
```

> Second page...

```shell
curl "https://api.retreaver.com/api/v2/calls.json?api_key=woofwoofwoof&page=2"
```

> etc...

To fetch all Calls on your Account, use the `sort_by` and `order` params to return your Calls in the order they were
created, and then paginate through all your calls.

### HTTP Request

`https://api.retreaver.com/api/v2/calls.json?api_key=woofwoofwoof&company_id=1&sort_by=created_at&order=asc&page=1`

`https://api.retreaver.com/api/v2/calls.json?api_key=woofwoofwoof&company_id=1&sort_by=created_at&order=asc&page=2`


## V2 - Enumerate through Calls in a specific date/time range.

```shell
curl "https://api.retreaver.com/calls.json?api_key=woofwoofwoof&company_id=1&created_at_start=2016-01-01T00:00:00+00:00&created_at_end=2016-01-02T00:00:00+00:00&page=1"
```

By passing in `created_at_start` and `created_at_end` parameters, you can control the start and end time of Calls returned.

The timestamp should be formatted according to [rfc3339](https://validator.w3.org/feed/docs/error/InvalidRFC3339Date.html)

### HTTP Request

`GET https://api.retreaver.com/api/v2/calls.json?api_key=woofwoofwoof&company_id=1&created_at_start=2016-01-01T00:00:00+00:00&created_at_end=2016-01-02T00:00:00+00:00&page=1`

## V2 - Get a specific Call

```shell
curl "https://api.retreaver.com/api/v2/calls/94079290-93f3-4527-9e78-88653aaf3c49.json?api_key=woofwoofwoof"
```

> The above command returns JSON structured like this:

```json
{
  "call": {
    "uuid": "94079290-93f3-4527-9e78-88653aaf3c49",
    "caller": "+13015236555",
    "caller_number_sent": null,
    "caller_zip": "28379",
    "caller_state": "NC",
    "caller_city": "Rockingham",
    "caller_country": "US",
    "dialed_call_duration": 0,
    "total_duration": 43,
    "ivr_duration": 26,
    "hold_duration": 17,
    "status": "finished",
    "start_time": "2024-11-04T16:46:10.400Z",
    "forwarded_time": null,
    "end_time": "2024-11-04T16:46:54.037Z",
    "cid": "1",
    "afid": null,
    "sid": null,
    "dialed_number": "+16477159443",
    "revenue": null,
    "payout": null,
    "postback_value": null,
    "network_sale_timer_fired": null,
    "affiliate_sale_timer_fired": null,
    "target_sale_timer_fired": null,
    "hung_up_by": "caller",
    "duplicate": false,
    "payable_duplicate": false,
    "receivable_duplicate": false,
    "callpixels_target_id": null,
    "system_target_id": null,
    "system_campaign_id": 9872,
    "system_affiliate_id": null,
    "fired_pixels_count": 5,
    "charge_total": "0.07",
    "keys_pressed": [
      "1"
    ],
    "repeat": true,
    "affiliate_repeat": false,
    "target_repeat": null,
    "number_repeat": true,
    "visitor_url": "https://example.com",
    "company_id": 2,
    "conversions_determined_at": "2024-11-04T16:47:14.698Z",
    "updated_at": "2024-11-04T16:47:14.944Z",
    "created_at": "2024-11-04T16:46:10.547Z",
    "billable_minutes": 1,
    "upstream_call_uuid": null,
    "downstream_call_uuids": [],
    "target_group": {},
    "number": "+18886064349",
    "converted": false,
    "payable": false,
    "receivable": false,
    "conversion_seconds": null,
    "tid": null,
    "tags": {
      "geo": "301,us,us-28379,us-nc",
      "request_id": "0192f811-d35d-85a4-7722-b3e39a2b3b6e,0192f812-0a4b-ab38-b471-e8332fac7ceb",
      "robodial_blacklist": "0",
      "status": "success"
    },
    "fired_pixels": [
      {
        "fired_pixel": {
          "url": "https://example.com",
          "fire_order": 1,
          "batch_uuid": "8530a03a-a661-4247-b80c-d4f3e4a52802",
          "created_at": "2024-11-04T16:47:15.071Z",
          "fired_at": null,
          "status": "new",
          "webhook_name": null
        }
      },
      {
        "fired_pixel": {
          "url": "https://example.com",
          "fire_order": 0,
          "batch_uuid": "dce85836-8b98-4b03-91f6-b29ca9494aa9",
          "created_at": "2024-11-04T16:46:10.937Z",
          "fired_at": "2024-11-04T16:46:10.793Z",
          "status": "fired",
          "webhook_name": "Webhook 1"
        }
      },
      {
        "fired_pixel": {
          "url": "https://example.com",
          "fire_order": 0,
          "batch_uuid": "c1b0c797-00bc-43ae-a5c4-4f58b2aa9278",
          "created_at": "2024-11-04T16:46:24.788Z",
          "fired_at": "2024-11-04T16:46:24.787Z",
          "status": "fired",
          "webhook_name": "Webhook 2"
        }
      },
      {
        "fired_pixel": {
          "url": "https://example.com",
          "fire_order": 0,
          "batch_uuid": "3c117e83-6d94-43fa-971b-25e3599e59f9",
          "created_at": "2024-11-04T16:46:24.920Z",
          "fired_at": "2024-11-04T16:46:24.849Z",
          "status": "fired",
          "webhook_name": "Webhook 3"
        }
      },
      {
        "fired_pixel": {
          "url": "https://example.com",
          "fire_order": 0,
          "batch_uuid": "7023c382-a52c-42f1-9339-a69e03942d5d",
          "created_at": "2024-11-04T16:46:25.874Z",
          "fired_at": "2024-11-04T16:46:25.873Z",
          "status": "fired",
          "webhook_name": "Webhook 4"
        }
      }
    ],
    "via": "inbound-dial",
    "rescued": false,
    "campaign_id": 9872,
    "campaign_name": "Retreaver Main - Sales & Support",
    "number_id": 4906092,
    "target_id": null,
    "affiliate_name": null,
    "connected": false,
    "profit_gross": "-0.07",
    "profit_net": 0,
    "target_name": null,
    "time_to_call_in_seconds": 168463,
    "time_to_connect_in_seconds": 43,
    "total_cost": "0.07"
  }
}
```

Calls can be accessed by their UUID.


### HTTP Request

`GET https://api.retreaver.com/api/v2/calls/addcf985-017e-4962-be34-cf5d55e74afc.json?api_key=woofwoofwoof&company_id=1`



# Affiliates

Entering Affiliates into our system allows you to attribute calls back to the Affiliate who created them, and to update any external tracking systems.

If you're not in affiliate marketing, Affiliate objects can be used for whatever source attribution is relevant. Affiliates exist for your reference.


## Get all Affiliates


```shell
curl "https://api.retreaver.com/affiliates.xml?api_key=woofwoofwoof&company_id=1"
```

> The above command returns XML structured like this:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<affiliates type="array">
  <affiliate>
    <afid>0002</afid>
    <first-name>Nancy</first-name>
    <last-name>Drew</last-name>
    <company-name>Acme</last-name>
    <updated-at type="datetime">2012-05-03T15:56:01Z</updated-at>
    <created-at type="datetime">2012-05-03T15:56:01Z</created-at>
  </affiliate>
</affiliates>
```


Provides a complete list of Affiliates.

### HTTP Request

`GET https://api.retreaver.com/affiliates.xml?api_key=woofwoofwoof&company_id=1`


## Get a specific Affiliate by your ID

```shell
curl "https://api.retreaver.com/affiliates/afid/0002.json?api_key=woofwoofwoof&company_id=1"
```

Finds an Affiliate by AFID.


### HTTP Request

`GET https://api.retreaver.com/affiliates/afid/0002.xml?api_key=woofwoofwoof&company_id=1`


## Create an Affiliate

```shell
curl -s \
    -X POST \
    https://api.retreaver.com/affiliates.json?api_key=woofwoofwoof&company_id=1 \
    -H "Content-Type: application/json" \
    -d '{"affiliate":{"first_name":"Nancy", "last_name":"Drew", "afid":"0002"}}'
```

Creates an Affiliate.

### HTTP Request

`POST https://api.retreaver.com/affiliates.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"affiliate":{"first_name":"Nancy", "last_name":"Drew", "afid":"0002"}}`


### Parameters

Parameter | Type | Default | Required | Description
--------- | ---- | ------- | -------- | -----------
afid | string | null | required | The affiliate's ID. This should align with any external tracking systems you may be using.
first_name | string | null |   | The affiliate's first name, for your reference.
last_name | string | null |   | Their last name.
company_name | string | null |   | Their company name.


## Update an Affiliate


```shell
curl -s \
    -X PUT \
    https://api.retreaver.com/affiliates/afid/002.json \
    -H "Content-Type: application/json" \
    -d '{"affiliate":{"first_name":"Nathan"}}'
```

> The above command returns JSON structured like this:

```json
{
  "affiliate": {
    "afid": "002",
    "first_name": "Nathan",
    "last_name": "Drew",
    "company_name": null,
    "updated_at": "2012-05-03T20:20:03Z",
    "created_at": "2012-05-03T14:29:37Z"
  }
}
```

Changes any attributes you have passed in on the Affiliate.


<aside class="notice">
You must replace <code>0002</code> with the afid of the Affiliate you want to delete.
</aside>


### HTTP Request

`PUT https://api.retreaver.com/affiliates/afid/0002.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"affiliate":{"first_name":"Nathan"}}`



## Remove an affiliate

```shell
curl -X DELETE https://api.retreaver.com/affiliates/afid/0002.json?api_key=woofwoofwoof&company_id=1
```

Deletes the given Affiliate. You must delete any Numbers the Affiliate has before deleting the Affiliate.




# Targets

Targets are the destination phone numbers that calls are routed to, for instance, your call center.


## Get all Targets

```shell
curl "https://api.retreaver.com/targets.json?api_key=woofwoofwoof&company_id=1"
```

> The above command returns JSON structured like this:

```json
[{
   "target": {
     "id": 6588,
     "number": "+18668987878",
     "sip_username": null,
     "sip_password": null,
     "cid_number_id": 10,
     "obfuscate_cid": false,
     "created_at": "2014-08-14T20:46:01.158-04:00",
     "updated_at": "2016-06-28T13:02:52.964-04:00",
     "object_key": "40a9a73ff97cb35a0a16d1ec89fd9eddcf3727df932cea9f0f7a5a8ba1684fed",
     "tid": null,
     "priority": 1,
     "weight": 1,
     "timeout_seconds": 15,
     "timer_offset": 0,
     "send_digits": null,
     "concurrency_cap": null,
     "calls_in_progress": 0,
     "inband_signals": false,
     "time_zone": "Eastern Time (US & Canada)",
     "paused": false,
     "paused_at": null,
     "name": "Jason Cell"
   }
}]
```



### HTTP Request

`GET https://api.retreaver.com/targets.json?api_key=woofwoofwoof&company_id=1`


## Get a specific Target


```shell
curl "https://api.retreaver.com/targets/6588.json?api_key=woofwoofwoof&company_id=1"
```

> The above command returns JSON structured like this:

```json
{
   "target": {
     "id": 6588,
     "number": "+18668987878",
     "sip_username": null,
     "sip_password": null,
     "cid_number_id": 10,
     "obfuscate_cid": false,
     "created_at": "2014-08-14T20:46:01.158-04:00",
     "updated_at": "2016-06-28T13:02:52.964-04:00",
     "object_key": "40a9a73ff97cb35a0a16d1ec89fd9eddcf3727df932cea9f0f7a5a8ba1684fed",
     "tid": null,
     "priority": 1,
     "weight": 1,
     "timeout_seconds": 15,
     "timer_offset": 0,
     "send_digits": null,
     "concurrency_cap": null,
     "calls_in_progress": 0,
     "inband_signals": false,
     "time_zone": "Eastern Time (US & Canada)",
     "paused": false,
     "paused_at": null,
     "name": "Jason Cell"
   }
}
```


### HTTP Request

`GET https://api.retreaver.com/targets/6588.json?api_key=woofwoofwoof&company_id=1`



## Create a Target

```shell
curl -s \
 -X POST \
 https://api.retreaver.com/targets.json?api_key=woofwoofwoof&company_id=1 \
 -H "Content-Type: application/json" \
 -d '{"target":{"number":"+18668987878", "name":"Retreaver Support"}}'
```

> The above command returns JSON structured like this:

```json
{
    "target": {
        "id": 22592,
        "number": "+18668987878",
        "sip_username": null,
        "sip_password": null,
        "cid_number_id": null,
        "obfuscate_cid": false,
        "created_at": "2016-06-28T23:13:51.434Z",
        "updated_at": "2016-06-28T23:13:51.434Z",
        "object_key": "97bbce7555b96322e81155eb4b1ff5aa9a6a1ffc478a7ab21ed2e830483f0b20",
        "tid": null,
        "priority": 1,
        "weight": 1,
        "timeout_seconds": 30,
        "timer_offset": 0,
        "send_digits": null,
        "concurrency_cap": null,
        "calls_in_progress": 0,
        "inband_signals": false,
        "time_zone": "UTC",
        "paused": false,
        "paused_at": null,
        "name": "Retreaver Support",
        "caps": [
            {
                "id": 707900,
                "filled": 0,
                "cap": null,
                "type": "Daily"
            },
            {
                "id": 707898,
                "filled": 0,
                "cap": null,
                "type": "Hard"
            },
            {
                "id": 707899,
                "filled": 0,
                "cap": null,
                "type": "Hourly"
            },
            {
                "id": 707901,
                "filled": 0,
                "cap": null,
                "type": "Monthly"
            }
        ],
        "business_hours": [
            {
                "id": 156838,
                "target_id": 22592,
                "work_day": true,
                "time_open": 0,
                "time_close": 2400,
                "day_of_week": 0,
                "invert": false,
                "created_at": "2016-06-28T23:13:52.924Z",
                "updated_at": "2016-06-28T23:13:52.924Z"
            },
            {
                "id": 156839,
                "target_id": 22592,
                "work_day": true,
                "time_open": 0,
                "time_close": 2400,
                "day_of_week": 1,
                "invert": false,
                "created_at": "2016-06-28T23:13:53.093Z",
                "updated_at": "2016-06-28T23:13:53.093Z"
            },
            {
                "id": 156840,
                "target_id": 22592,
                "work_day": true,
                "time_open": 0,
                "time_close": 2400,
                "day_of_week": 2,
                "invert": false,
                "created_at": "2016-06-28T23:13:53.281Z",
                "updated_at": "2016-06-28T23:13:53.281Z"
            },
            {
                "id": 156841,
                "target_id": 22592,
                "work_day": true,
                "time_open": 0,
                "time_close": 2400,
                "day_of_week": 3,
                "invert": false,
                "created_at": "2016-06-28T23:13:53.684Z",
                "updated_at": "2016-06-28T23:13:53.684Z"
            },
            {
                "id": 156842,
                "target_id": 22592,
                "work_day": true,
                "time_open": 0,
                "time_close": 2400,
                "day_of_week": 4,
                "invert": false,
                "created_at": "2016-06-28T23:13:53.846Z",
                "updated_at": "2016-06-28T23:13:53.846Z"
            },
            {
                "id": 156843,
                "target_id": 22592,
                "work_day": true,
                "time_open": 0,
                "time_close": 2400,
                "day_of_week": 5,
                "invert": false,
                "created_at": "2016-06-28T23:13:54.008Z",
                "updated_at": "2016-06-28T23:13:54.008Z"
            },
            {
                "id": 156844,
                "target_id": 22592,
                "work_day": true,
                "time_open": 0,
                "time_close": 2400,
                "day_of_week": 6,
                "invert": false,
                "created_at": "2016-06-28T23:13:54.165Z",
                "updated_at": "2016-06-28T23:13:54.165Z"
            }
        ],
        "tag_values": []
    }
}
```

Creates a new Target.


### HTTP Request

`POST https://api.retreaver.com/targets.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"target":{"number":"+18668987878", "name":"Retreaver Support"}}`


### Parameters

Parameter | Type | Default | Required | Description
--------- | ---- | ------- | -------- | -----------
name | string | | | A descriptive moniker for this target so you'll know what it is.
number | string | | required | Either a phone number or `sip:user@domain.com` formatted SIP endpoint. PSTN numbers should be [E.164 formatted](https://en.wikipedia.org/wiki/E.164).
sip_username | string | | | The SIP username, if using SIP-authentication to call a SIP endpoint.
sip_password | string | | | The SIP password, if using SIP-authentication to call a SIP endpoint.
tid | string | | | Your own internal ID for this target.
priority | integer | 1 | | The target with the lowest priority value gets considered first when routing calls to a set of targets.
weight | integer | 1 | | When more than one target has the same priority, the cumulative weight of the targets being considered is used to randomize their order.
timeout_seconds | integer | 30 | | The maximum number of seconds we'll wait while the target number is ringing before moving on.
inband_signals | boolean | false | | Enables detection of in-band ringing in conjunction with `timer_offset`.
timer_offset | integer | 0 | | Offsets any timers on Tracking URLs or Conversion Criteria when routing to this target. Can be used to simplify campaign management.
send_digits | string | | | Send these digits as DTMF tones when the call recipient picks up. Use `w` to make a 0.5 second pause. This can be used to bypass IVR systems.
concurrency_cap | integer | null | | Used to limit the maximum number of concurrent calls a target can receive.
paused | boolean | false | | Targets which are paused will not be considered when routing calls.
time_zone | string | UTC | | The time zone used when determining if a call is occuring during business hours.
business_hours_attributes | array | | | An optional array of business hours. Targets are set to be open 24/7 by default.

**Nested Attribute: Business Hours**

We'll only attempt to route calls to your target during its Business Hours. These hours are based on the Target `time_zone`. Note that when *updating* business hours on a Target, you must pass in the existing `id` attribute that gets created on this request.

Parameter | Type | Default | Required | Description
--------- | ---- | ------- | -------- | -----------
day_of_week | integer | | required | A zero-indexed day of the week, with 0 being Sunday and 6 being Saturday.
work_day | boolean | true | | Whether or not the target is open on this day.
time_open | integer | 0 | | The 24 hour time the target opens, formatted `HHMM`.
time_close | integer | 2400 | | The 24 hour time the target closes, formatted `HHMM`.
inverted | boolean | false | | Open hours become closed! Closed become open! Oh the insanity! Great if you have overnight shifts.

### Valid Time Zones

[Need to map IANA time zones to our format?](https://gist.github.com/jaygen/f6caa3305ec812344cc81175843f5ab0)

&nbsp; | &nbsp; | &nbsp; | &nbsp; | &nbsp;
---------------- | ------ | ------ | ------ | ------
International Date Line West|Midway Island|American Samoa|Hawaii|Alaska
Pacific Time (US & Canada)|Tijuana|Mountain Time (US & Canada)|Arizona|Chihuahua
Mazatlan|Central Time (US & Canada)|Saskatchewan|Guadalajara|Mexico City
Monterrey|Central America|Eastern Time (US & Canada)|Indiana (East)|Bogota
Lima|Quito|Atlantic Time (Canada)|Caracas|La Paz
Santiago|Newfoundland|Brasilia|Buenos Aires|Montevideo
Georgetown|Greenland|Mid-Atlantic|Azores|Cape Verde Is.
Dublin|Edinburgh|Lisbon|London|Casablanca
Monrovia|UTC|Belgrade|Bratislava|Budapest
Ljubljana|Prague|Sarajevo|Skopje|Warsaw
Zagreb|Brussels|Copenhagen|Madrid|Paris
Amsterdam|Berlin|Bern|Rome|Stockholm
Vienna|West Central Africa|Bucharest|Cairo|Helsinki
Kyiv|Riga|Sofia|Tallinn|Vilnius
Athens|Istanbul|Minsk|Jerusalem|Harare
Pretoria|Moscow|St. Petersburg|Volgograd|Kuwait
Riyadh|Nairobi|Baghdad|Tehran|Abu Dhabi
Muscat|Baku|Tbilisi|Yerevan|Kabul
Ekaterinburg|Islamabad|Karachi|Tashkent|Chennai
Kolkata|Mumbai|New Delhi|Kathmandu|Astana
Dhaka|Sri Jayawardenepura|Almaty|Novosibirsk|Rangoon
Bangkok|Hanoi|Jakarta|Krasnoyarsk|Beijing
Chongqing|Hong Kong|Urumqi|Kuala Lumpur|Singapore
Taipei|Perth|Irkutsk|Ulaanbaatar|Seoul
Osaka|Sapporo|Tokyo|Yakutsk|Darwin
Adelaide|Canberra|Melbourne|Sydney|Brisbane
Hobart|Vladivostok|Guam|Port Moresby|Magadan
Solomon Is.|New Caledonia|Fiji|Kamchatka|Marshall Is.
Auckland|Wellington|Nuku'alofa|Tokelau Is.|Chatham Is.
Samoa| | | | |


## Update a Target

```shell
curl -s \
 -X PUT \
 https://api.retreaver.com/targets/22592.json \
 -H "Content-Type: application/json" \
 -d '{"target":{"paused":true}}'
```

> The above command returns JSON structured like this:

```json
{
    "target": {
        "id": 22592,
        "number": "+18668987878",
        "sip_username": null,
        "sip_password": null,
        "cid_number_id": null,
        "created_at": "2016-06-28T23:13:51.434Z",
        "updated_at": "2016-06-28T23:30:00.529Z",
        "paused": true,
        "paused_at": "2016-06-28T23:30:01.251Z",
        "name": "Retreaver Support"
    }
}
```

Changes any attributes you have passed in on the Target.

<aside class="notice">
You must replace <code>22592</code> with the Retreaver ID of the Target you want to delete.
</aside>


### HTTP Request


`PUT https://api.retreaver.com/targets/22592.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"target":{"paused":true}}`



## Remove a Target


```shell
curl -X DELETE https://api.retreaver.com/targets/22592.json?api_key=woofwoofwoof&company_id=1
```

Deletes the given Target.

### HTTP Request

`DELETE https://api.retreaver.com/targets/22592.json?api_key=woofwoofwoof&company_id=1`



## Tagging a Target

```shell
curl -s \
 -X PUT \
 https://api.retreaver.com/targets/22592.json \
 -H "Content-Type: application/json" \
 -d '{"target":{"tag_list":"<<<calling_about:support>>>,<<<calling_about:other>>>"}}'
```

> Upon reloading the Target, the following JSON is returned with the tags included:

```json
{
    "target": {
        "id": 22592,
        "number": "+18668987878",
        "name": "Retreaver Support",
        "tag_values": [
            {
                "key": "calling_about",
                "value": "support",
                "operator": "==",
                "id": 67589
            },
            {
                "key": "calling_about",
                "value": "other",
                "operator": "==",
                "id": 67591
            }
        ]
    }
}
```

To set tags on a Target, pass in a comma delineated, triple-angle-bracket enclosed string of tags as the `tag_list` value.

The system will create/find whatever tags you have set given this input without you having to track tag IDs. You must include the full list of tags you want set any time a tag_list parameter is passed in. To clear the tags, just pass in a blank string.

There is a limit of 100 tags added in this manner, but the system will automatically concatenate US zip `geo` tags.


### HTTP Request


`PUT https://api.retreaver.com/targets/22592.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"target":{"tag_list":"<<<calling_about:support>>>,<<<calling_about:other>>>"}}`



## Changing a Target's Caps


```shell
curl -s \
 -X PUT \
 https://api.retreaver.com/targets/22592.json \
 -H "Content-Type: application/json" \
 -d '{"target": { \
         "hard_cap_attributes": { \
             "cap": 100 \
             } \
         }' \
     }'
```

> The above command returns JSON structured like this:

```json
{
    "target": {
        "id": 22592,
        "number": "+18668987878",
        "name": "Retreaver Support",
        "caps": [
            {
                "id": 707900,
                "filled": 0,
                "cap": null,
                "type": "Daily"
            },
            {
                "id": 707898,
                "filled": 0,
                "cap": 100,
                "type": "Hard"
            },
            {
                "id": 707899,
                "filled": 0,
                "cap": null,
                "type": "Hourly"
            },
            {
                "id": 707901,
                "filled": 0,
                "cap": null,
                "type": "Monthly"
            }
        ]
    }
}
```


There are 4 types of caps: Hard Cap, Hourly Cap, Daily Cap, and Monthly Cap. Hard cap is a hard limit, and once it is reached, the target will not receive more Calls until the Cap is reset. This is useful when routing Calls to buyers that have insertion orders for a set number of leads.

The other types of Cap reset periodically as expected.

You can modify these Caps by updating your Target with nested objects `hard_cap_attributes`, `hourly_cap_attributes`, `daily_cap_attributes`, and `monthly_cap_attributes`.

### HTTP Request

`PUT https://api.retreaver.com/targets/22592.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"target":{"hard_cap_attributes":{"cap":100}}}`


### Parameters

Parameter | Type | Default | Required | Description
--------- | ---- | ------- | -------- | -----------
cap | integer |  | required | The value for the cap.


## Resetting a Hard Cap

```shell
curl -s \
 -X POST \
 https://api.retreaver.com/targets/22592/reset_cap.json?api_key=woofwoofwoof&company_id=1 \
 -H "Content-Type: application/json"
```

Clears any Calls contributing to the given Target's hard cap, resetting it to 0. Returns HTTP 200 on success.

### HTTP Request

`POST https://api.retreaver.com/targets/22592/reset_cap.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`



# Campaigns

By configuring a Campaign, you can reuse the settings of the Campaign when creating Numbers. Campaigns should be configured before creating Numbers.


## Get all Campaigns

```shell
curl "https://api.retreaver.com/campaigns.json?api_key=woofwoofwoof&company_id=1"
```

> The above command returns JSON structured like this:

```json
[{
"campaign":{
   "cid":"111",
   "name":"SuperFuntime",
   "updated_at":"2012-07-15T03:40:24Z",
   "created_at":"2012-04-16T13:50:21Z",
   "record_calls":true,
   "record_seconds":3600,
   "dedupe_seconds":86400,
   "affiliate_can_pull_number":false,
   "show_key":"5e2ba674a8a1fb34dddcf850139ffdd9",
   "greeting":{
      "message":"Hi There! Press one to continue.",
      "voice_gender":"Female"
   },
   "timers":[
      {
         "timer":{
            "id":195,
            "seconds":0,
            "url":"http://www.thertrack.com/click.track?CID=[campaign_id]&AFID=[affiliate_id]&SID=[sub_id]"
         }
      },
      {
         "timer":{
            "id":199,
            "seconds":90,
            "url":"http://www.thertrack.com/pixel.track?CID=[campaign_id]&AFID=[affiliate_id]&SID=[sub_id]&MerchantReferenceID=[caller_id]-[called_number]-[call_duration]"
         }
      }
   ],
   "menu_options":[
      {
         "menu_option":{
            "id":61,
            "option":"1",
            "target_cid":null,
            "target_number":"+18987748833"
         }
      }
   ]
}
}]
```

List all the Campaigns in your Account.


### HTTP Request

`GET https://api.retreaver.com/campaigns.json?api_key=woofwoofwoof&company_id=1`


## Get a specific Campaign


```shell
curl "https://api.retreaver.com/campaigns/cid/0044.json?api_key=woofwoofwoof&company_id=1"
```

> The above command returns JSON structured like this:

```json
{
   "campaign":{
      "cid":"0044",
      "name":"SuperFuntime",
      "updated_at":"2012-07-15T03:40:24Z",
      "created_at":"2012-04-16T13:50:21Z",
      "record_calls":true,
      "record_seconds":3600,
      "dedupe_seconds":86400,
      "affiliate_can_pull_number":false,
      "show_key":"5e2ba674a8a1fb34dddcf850139ffdd9",
      "greeting":{
         "message":"Hi There! Press one to continue.",
         "voice_gender":"Female"
      },
      "timers":[
         {
            "timer":{
               "id":195,
               "seconds":0,
               "url":"http://www.thertrack.com/click.track?CID=[campaign_id]&AFID=[affiliate_id]&SID=[sub_id]"
            }
         },
         {
            "timer":{
               "id":199,
               "seconds":90,
               "url":"http://www.thertrack.com/pixel.track?CID=[campaign_id]&AFID=[affiliate_id]&SID=[sub_id]&MerchantReferenceID=[caller_id]-[called_number]-[call_duration]"
            }
         }
      ],
      "menu_options":[
         {
            "menu_option":{
               "id":61,
               "option":"1",
               "target_cid":null,
               "target_number":"+18987748833"
            }
         }
      ]
   }
}
```

Get a campaign by your ID.

### HTTP Request

`GET https://api.retreaver.com/campaigns/cid/0044.json?api_key=woofwoofwoof&company_id=1`



## Create a Campaign

```shell
curl -s \
    -X POST \
    https://api.retreaver.com/campaigns.json \
    -H "Content-Type: application/json" \
    -d '{ \
            "campaign": { \
                "cid": "000333", \
                "name": "MyCampaign", \
                "message": "Thanks for calling, please press one to continue.", \
                "voice_gender": "Male", \
                "timers_attributes": [{ \
                    "seconds": 0, \
                    "url": "http://callpixels.com/click.html" \
                }, { \
                    "seconds": 90, \
                    "url": "http://callpixels.com/sale.html" \
                }], \
                "menu_options_attributes": [{ \
                    "option": "1", \
                    "target_number": "+16474570424" \
                   } \
                ] \
            } \
        }' \
```

> The above command returns JSON structured like this:

```json
{
   "campaign":{
      "cid":"0044",
      "name":"MyCampaign",
      "updated_at":"2012-07-15T03:34:00Z",
      "created_at":"2012-07-15T03:34:00Z",
      "record_calls":true,
      "record_seconds":3600,
      "dedupe_seconds":0,
      "affiliate_can_pull_number":false,
      "show_key":"5e2ba674a8a1fb34dddcf850139ffdd9",
      "greeting":{
         "message":"Thanks for calling, please press one to continue.",
         "voice_gender":"Male"
      },
      "timers":[
         {
            "timer":{
               "id":217,
               "seconds":0,
               "url":"http://callpixels.com/click.html"
            }
         },
         {
            "timer":{
               "id":218,
               "seconds":90,
               "url":"http://callpixels.com/sale.html"
            }
         }
      ],
      "menu_options":[
         {
            "menu_option":{
               "id":77,
               "option":"1",
               "target_cid":null,
               "target_number":"+16474570424"
            }
         }
      ]
   }
}
```

Create a new Campaign.


### HTTP Request

`POST https://api.retreaver.com/campaigns.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"campaign":{"cid":"0044","name":"MyCampaign","message":"Thanks for calling, please press one to continue.","voice_gender":"Male","timers_attributes":[{"seconds":0,"url":"http://callpixels.com/click.html"},{"seconds":90,"url":"http://callpixels.com/sale.html"}],"menu_options_attributes":[{"option":"1","target_number":"+16474570424"}]}}`


### Parameters

Parameter | Type | Default | Required | Description
--------- | ---- | ------- | -------- | -----------
cid | string | Random 8 characters |   | Your internal campaign ID that will be referenced in the future.
name | string |  |  | A name for the campaign for your reference.
dedupe_seconds | integer | 0 (Disabled) |  | Prevent a repeat caller from causing any Connect (timer.seconds == 0) or Sale (timer.seconds > 0) timer from firing within n seconds. Does not affect < 0 second timers.
affiliate_can_pull_number | boolean | false | |  Allow affiliates to access this campaign via our LinkTrust integration.
record_calls | boolean | true | | Toggles call recording on and off.
message | string |  |  | *Text-to-speech*  A message you want read aloud to the caller when they dial your number. Make sure to tell them to press one to continue.
voice_gender | string | Male |  | *Text-to-speech*  Male or Female, the gender of the text-to-speech voice you want.
message_file | file |  |  | *Audio File* An audio file you would like played for the caller when they dial your number. Use this field with multipart/form-data submissions.
message_file_b64_data | string |  |  | *Audio File* A Base64-encoded audio file. Only use this field if you're not using the message_file field.
message_file_b64_filename | string | |  | *Audio File* The original file name for the Base64-encoded audio file. Something like 'memo.flac'. We suggest using the highest quality audio available.
repeat | integer | 4 |  | The number of times to repeat the greeting.
timers_attributes | array | | | An array of timers.
menu_option_attributes | array | | | An array of menu options.
destroy_nested | boolean | false |  | When set, causes existing timers and menu_options to be destroyed. Existing timers and menu options can be updated by including their unique ID. Alternatively, you can simply remove all the existing timers and menu options by setting this to true and resubmit all the values.

**Nested Attribute: Timer**

We will fire any 0 second timer ('click timer') before firing a sale timer (> 0 seconds). Only the highest second value sale timer that is applicable to this call will be fired. If you have timers for 30 seconds and 90 seconds and the call lasts 2 minutes, only the 90 second sale timer will be fired.

Parameter | Type | Default | Required | Description
--------- | ---- | ------- | -------- | -----------
seconds | integer |  | required | The minimum length of time the call must last for this pixel to be fired. If set to 0, the pixel will fire at the beginning of the call, much like a click.
url | string |  | required | The URL that should be called for this timer. The URL does not have to be a pixel, and will be passed any cookies that were set on the 0-second timer. Our bot follows redirects intelligently.


**Nested Attribute: Menu Option**

Menu options are used to route calls based on what button the caller presses on their phone. Menu options can redirect a caller to a different phone number or another CallPixels campaign. You must provide at least one menu option, and you must provide an option for '1', which is the option used to route calls when there is no greeting configured.

Parameter | Type | Default | Required | Description
--------- | ---- | ------- | -------- | -----------
option | string |  | required | The button the caller will press. The default menu option for a campaign is the one for button press '1', so if you aren't using an IVR and want the call to forward instantly, set the option to '1'. (1 2 3 4 5 6 7 8 9 0 * #)
target_number | string |  |  | A phone number to redirect the caller to. All > 0 second timers will start when the call is answered.
target_cid | string |  |  | A campaign ID to redirect the caller to. The campaign must be configured in the system. If this value is set, it will overrride the target number. This option can be used to allow the caller to replay the greeting.



## Update a Campaign

```shell
curl -s \
    -X PUT \
    https://api.retreaver.com/campaigns/cid/0044.json \
    -H "Content-Type: application/json" \
    -d '{"campaign":{"name":"My Other Campaign"}}'
```

> The above command returns JSON structured like this:

```json
{
   "campaign":{
      "cid":"0044",
      "name":"My Other Campaign",
      "updated_at":"2012-07-15T03:34:00Z",
      "created_at":"2012-07-15T03:34:00Z",
      "record_calls":true,
      "record_seconds":3600,
      "dedupe_seconds":0,
      "affiliate_can_pull_number":false,
      "show_key":"5e2ba674a8a1fb34dddcf850139ffdd9",
      "greeting":{
         "message":"Thanks for calling, please press one to continue.",
         "voice_gender":"Male"
      },
      "timers":[
         {
            "timer":{
               "id":217,
               "seconds":0,
               "url":"http://callpixels.com/click.html"
            }
         },
         {
            "timer":{
               "id":218,
               "seconds":90,
               "url":"http://callpixels.com/sale.html"
            }
         }
      ],
      "menu_options":[
         {
            "menu_option":{
               "id":77,
               "option":"1",
               "target_cid":null,
               "target_number":"+16474570424"
            }
         }
      ]
   }
}
```

Changes any attributes you have passed in on the Campaign.

<aside class="notice">
You must replace <code>0044</code> with the cid of the Campaign you want to update.
</aside>


### HTTP Request


`PUT https://api.retreaver.com/campaigns/cid/0044.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"affiliate":{"first_name":"Nathan"}}`



## Remove a Campaign


```shell
curl -X DELETE https://api.retreaver.com/campaigns/cid/0044.json?api_key=woofwoofwoof&company_id=1
```

Delete a Campaign by CID. You must delete all the Numbers belonging to that Campaign first.





# Numbers

Numbers are the physical phone numbers that you want routed to a Campaign. A Number can be routed directly to the Target phone number, or it can be screened with a greeting which requires the caller to press a button to continue. The IVR can be configured to have options that forward to other Campaigns if desired.

Numbers can be set to use the settings of an existing Campaign.


## Get all Numbers

```shell
curl "https://api.retreaver.com/numbers.json?api_key=woofwoofwoof&company_id=1"
```

> The above command returns JSON structured like this:

```json
[{
    "number":{
       "id":5,
       "number":"+16479311232",
       "toll_free":false,
       "updated_at":"2012-05-03T13:53:23Z",
       "created_at":"2012-04-18T06:05:05Z",
       "sid":"superaffiliate",
       "afid":"0001",
       "cid":"111",
       "uses_campaign_settings":true,
       "greeting":{
          "message":"Hi There! Press one to continue.",
          "voice_gender":"Female",
          "inherited":true
       },
       "timers":[
          {
             "id":113,
             "seconds":0,
             "url":"http://www.thertrack.com/click.track?CID=[campaign_id]&AFID=[affiliate_id]&SID=[sub_id]",
             "inherited":true
          },
          {
             "id":114,
             "seconds":5,
             "url":"http://www.thertrack.com/pixel.track?CID=[campaign_id]&AFID=[affiliate_id]&SID=[sub_id]&MerchantReferenceID=[caller_id]-[called_number]-[call_duration]",
             "inherited":true
          }
       ],
       "menu_options":[
          {
             "menu_option":{
                "id":44,
                "option":"1",
                "target_cid":null,
                "target_number":"+18667878878",
                "inherited":true
             }
          }
       ]
    }
}]
```

Get all Numbers belonging to the Company.


### HTTP Request

`GET https://api.retreaver.com/numbers.json?api_key=woofwoofwoof&company_id=1`


### Parameters

Parameter | Default | Description
--------- | ------- | -----------
cid | null | Restrict results to Numbers that belong to the given Campaign ID.
afid | null | Restrict results to Numbers that belong to the given Affiliate ID.
sid | null | Restrict results to Numbers that belong to the given SubID.


## Get a specific Number


```shell
curl "https://api.retreaver.com/numbers/5.json?api_key=woofwoofwoof&company_id=1"
```

> The above command returns JSON structured like this:

```json
{
   "number":{
      "id":5,
      "number":"+16479311232",
      "toll_free":false,
      "updated_at":"2012-05-03T13:53:23Z",
      "created_at":"2012-04-18T06:05:05Z",
      "sid":"superaffiliate",
      "afid":"0001",
      "cid":"111",
      "uses_campaign_settings":true,
      "greeting":{
         "message":"Hi There! Press one to continue.",
         "voice_gender":"Female",
         "inherited":true
      },
      "timers":[
         {
            "id":113,
            "seconds":0,
            "url":"http://www.thertrack.com/click.track?CID=[campaign_id]&AFID=[affiliate_id]&SID=[sub_id]",
            "inherited":true
         },
         {
            "id":114,
            "seconds":5,
            "url":"http://www.thertrack.com/pixel.track?CID=[campaign_id]&AFID=[affiliate_id]&SID=[sub_id]&MerchantReferenceID=[caller_id]-[called_number]-[call_duration]",
            "inherited":true
         }
      ],
      "menu_options":[
         {
            "menu_option":{
               "id":44,
               "option":"1",
               "target_cid":null,
               "target_number":"+18667878878",
               "inherited":true
            }
         }
      ]
   }
}
```

Get a Number by our internal ID.

### HTTP Request

`GET https://api.retreaver.com/numbers/5.json?api_key=woofwoofwoof&company_id=1`


## Create a Number

```shell
curl -s \
    -X POST \
    https://api.retreaver.com/numbers.json \
    -H "Content-Type: application/json" \
    -d '{"number":{"type":"Toll-free","desired_text":"TEST","afid":"0002","cid":"0001","sid":"superaffiliate"}}'
```

> The above command returns JSON structured like this:

```json
{
   "number":{
      "id":79,
      "number":"+18008378206",
      "toll_free":true,
      "updated_at":"2012-07-15T03:15:42Z",
      "created_at":"2012-07-15T03:15:42Z",
      "sid":"superaffiliate",
      "afid":"0002",
      "cid":"0001",
      "uses_campaign_settings":true,
      "greeting":{
         "audio_file_name":"greeting.flac",
         "audio_file_content_type":"application/octet-stream",
         "audio_file_size":4990865,
         "audio_file_updated_at":"2012-07-15T01:30:34Z",
         "inherited":true
      },
      "timers":[
         {
            "timer":{
               "id":201,
               "seconds":0,
               "url":"http://callpixels.com.go2cloud.org/aff_c?offer_id=[campaign_id]&aff_id=[affiliate_id]&aff_sub=[sub_id]",
               "inherited":true
            }
         },
         {
            "timer":{
               "id":202,
               "seconds":90,
               "url":"http://callpixels.com.go2cloud.org/[has_offers_code]?adv_sub=[call_log_id]-[caller_id]-[called_number]-[call_duration]-[call_recording_url]",
               "inherited":true
            }
         }
      ],
      "menu_options":[
         {
            "menu_option":{
               "id":66,
               "option":"1",
               "target_cid":null,
               "target_number":"+18884899999",
               "inherited":true
            }
         },
         {
            "menu_option":{
               "id":71,
               "option":"2",
               "target_cid":"399944",
               "target_number":null,
               "inherited":true
            }
         }
      ]
   }
}
```

Creates a new phone Number.



### HTTP Request

`POST https://api.retreaver.com/numbers.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"number":{"type":"Toll-free","desired_text":"TEST","afid":"0002","cid":"0001","sid":"superaffiliate"}}`


### Parameters

Parameter | Type | Default | Required | Description
--------- | ---- | ------- | -------- | -----------
type | string | Toll-free | required | Toll-free or Local, the kind of number that is desired. Defaults to Toll-free.
desired_text | string |  |  | If you would like us to attempt to get a number that contains a specific word, enter it here. We will fall back to normal numbers if a number containing your word is not found.
country | string | US |  | For Local numbers only, the 2 character country code for the country you would like the number to be in. Defaults to US. Possible values: US CA AT BE DK FI FR GB IE IT NL PL SE
afid | string | | required | The affiliate ID this number belongs to. If not found, we will create a new affiliate with this AFID.
cid | string | | required | The campaign ID this number belongs to. You must set up the campaign before creating a number for it.
sid | string | | |  The SubID this number belongs to.
destroy_nested | boolean | false | | When set, causes existing timers and menu_options on this number to be destroyed.

### Optional Parameters

Parameter | Type | Default | Required | Description
--------- | ---- | ------- | -------- | -----------
message | string |  |  | *Text-to-speech*  A message you want read aloud to the caller when they dial your number. Make sure to tell them to press one to continue.
voice_gender | string | Male |  | *Text-to-speech*  Male or Female, the gender of the text-to-speech voice you want.
message_file | file |  |  | *Audio File* An audio file you would like played for the caller when they dial your number. Use this field with multipart/form-data submissions.
message_file_b64_data | string |  |  | *Audio File* A Base64-encoded audio file. Only use this field if you're not using the message_file field.
message_file_b64_filename | string | |  | *Audio File* The original file name for the Base64-encoded audio file. Something like 'memo.flac'. We suggest using the highest quality audio available.
repeat | integer | 4 |  | The number of times to repeat the greeting.
timers_attributes | array | | | An array of timers.
menu_options_attributes | array | | | An array of menu options.


**Nested Attribute: Timer**

Only include Timers if you want to override the Campaign settings. For more information on Timers, see [Campaign](#create-a-campaign).

If you do include Timers, the `inherited` attribute on them will be set to `false`.


Parameter | Type | Default | Required | Description
--------- | ---- | ------- | -------- | -----------
seconds | integer |  | required | The minimum length of time the call must last for this pixel to be fired. If set to 0, the pixel will fire at the beginning of the call, much like a click.
url | string |  | required | The URL that should be called for this timer. The URL does not have to be a pixel, and will be passed any cookies that were set on the 0-second timer. Our bot follows redirects intelligently.


**Nested Attribute: Menu Option**

Only include Menu Options if you want to override the Campaign settings. See [Campaign](#create-a-campaign) for more details.

If you do include Menu Options, the `inherited` attribute on them will be set to `false`.


Parameter | Type | Default | Required | Description
--------- | ---- | ------- | -------- | -----------
option | string |  | required | The button the caller will press. The default menu option for a campaign is the one for button press '1', so if you aren't using an IVR and want the call to forward instantly, set the option to '1'. (1 2 3 4 5 6 7 8 9 0 * #)
target_number | string |  |  | A phone number to redirect the caller to. All > 0 second timers will start when the call is answered.
target_cid | string |  |  | A campaign ID to redirect the caller to. The campaign must be configured in the system. If this value is set, it will overrride the target number. This option can be used to allow the caller to replay the greeting.



## Update a Number

```shell
curl -s \
    -X PUT \
    https://api.retreaver.com/numbers/79.json?api_key=woofwoofwoof&company_id=1 \
    -H "Content-Type: application/json" \
    -d '{"number":{"afid":"0005"}}'
```

> The above command returns JSON structured like this:

```json
{
   "number":{
      "id":79,
      "number":"+15558237206",
      "toll_free":true,
      "updated_at":"2012-07-15T03:15:42Z",
      "created_at":"2012-07-15T03:15:42Z",
      "sid":"superaffiliate",
      "afid":"0005",
      "cid":"0001",
      "uses_campaign_settings":true,
      "greeting":{
         "audio_file_name":"greeting.flac",
         "audio_file_content_type":"application/octet-stream",
         "audio_file_size":4990865,
         "audio_file_updated_at":"2012-07-15T01:30:34Z",
         "inherited":true
      },
      "timers":[
         {
            "timer":{
               "id":201,
               "seconds":0,
               "url":"http://callpixels.com.go2cloud.org/aff_c?offer_id=[campaign_id]&aff_id=[affiliate_id]&aff_sub=[sub_id]",
               "inherited":true
            }
         },
         {
            "timer":{
               "id":202,
               "seconds":90,
               "url":"http://callpixels.com.go2cloud.org/[has_offers_code]?adv_sub=[call_log_id]-[caller_id]-[called_number]-[call_duration]-[call_recording_url]",
               "inherited":true
            }
         }
      ],
      "menu_options":[
         {
            "menu_option":{
               "id":66,
               "option":"1",
               "target_cid":null,
               "target_number":"+18884899999",
               "inherited":true
            }
         },
         {
            "menu_option":{
               "id":71,
               "option":"2",
               "target_cid":"399944",
               "target_number":null,
               "inherited":true
            }
         }
      ]
   }
}
```

Updates the Number with any attributes you have passed in.

<aside class="notice">
You must replace <code>79</code> with the Retreaver ID of the Number you want to update.
</aside>


### HTTP Request


`PUT https://api.retreaver.com/numbers/79.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"number":{"afid":"0005"}}`



## Remove a Number


```shell
curl -X DELETE https://api.retreaver.com/numbers/79.json?api_key=woofwoofwoof&company_id=1
```

Deletes the given number. Numbers will be deprovisioned within 24 hours. Do not delete Numbers if you are porting them to another provider,
until you have confirmed that the port has completed.



# Number Pools

Number Pools are used to dynamically assign Numbers whenever a user visits your website. Number Pools are used in lieu of static Numbers when
you want to track many different attributes.


## Get all Number Pools

```shell
curl "https://api.retreaver.com/number_pools.json?api_key=woofwoofwoof&company_id=1"
```

> The above command returns JSON structured like this:

```json
[{
     "number_pool": {
         "id": 1,
         "numbers_count": 0,
         "type": "Toll-free",
         "country": "CA",
         "max_pool_size": 10,
         "buffer_seconds": 0,
         "updated_at": "2013-04-25T16:16:51Z",
         "created_at": "2013-04-25T16:16:51Z",
         "google_analytics": false,
         "hide_embedded_access": false,
         "afid": "0001",
         "cid": "111",
         "reserve_size": 1
     }
 }]
```

Returns all the Number Pools you have in our system.


### HTTP Request

`GET https://api.retreaver.com/number_pools.json?api_key=woofwoofwoof&company_id=1`

### Parameters

Parameter | Default | Description
--------- | ------- | -----------
cid | null | Restrict results to Number Pools that belong to the given Campaign ID.
afid | null | Restrict results to Number Pools that belong to the given Affiliate ID.


## Get a specific Number Pool


```shell
curl "https://api.retreaver.com/number_pools/1.json?api_key=woofwoofwoof&company_id=1"
```

> The above command returns JSON structured like this:

```json
{
    "number_pool": {
        "id": 1,
        "numbers_count": 0,
        "type": "Toll-free",
        "country": "CA",
        "max_pool_size": 10,
        "buffer_seconds": 0,
        "updated_at": "2013-04-25T16:16:51Z",
        "created_at": "2013-04-25T16:16:51Z",
        "google_analytics": false,
        "hide_embedded_access": false,
        "afid": "0001",
        "cid": "111",
        "reserve_size": 1
    }
}
```

Returns a single Number Pool based on our internal ID.


### HTTP Request

`GET https://api.retreaver.com/number_pools/1.json?api_key=woofwoofwoof&company_id=1`


## Create a Number Pool

```shell
curl -s \
    -X POST \
    https://api.retreaver.com/number_pools.json?api_key=woofwoofwoof&company_id=1 \
    -H "Content-Type: application/json" \
    -d '{ \
            "number_pool": { \
                "cid": "111", \
                "max_pool_size": 100, \
                "hide_embedded_access": true, \
                "google_analytics": true \
            } \
        }'
```

> The above command returns JSON structured like this:

```json
{
    "number_pool": {
        "id": 49,
        "numbers_count": 0,
        "country": "US",
        "max_pool_size": 100,
        "buffer_seconds": 0,
        "updated_at": "2013-04-25T16:53:52Z",
        "created_at": "2013-04-25T16:53:52Z",
        "hide_embedded_access": true,
        "google_analytics": true,
        "afid": null,
        "cid": "111",
        "type": "Toll-free",
        "reserve_size": 1,
        "google_analytics_paths": [
            {
                "name": "Network timer (always)",
                "path": "/callpixels/8ddc04aa-0020-45eb-89df-ed45b8ed43a7"
            },
            {
                "name": "Network timer (connect)",
                "path": "/callpixels/18135f62-00ff-4818-941d-d88b6a93f27d"
            }
        ]
    }
}
```


Creates a new Number Pool.


### HTTP Request

`POST https://api.retreaver.com/number_pools.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"number_pool":{"cid":"111","max_pool_size":100,"hide_embedded_access":true,"google_analytics":true}}`


### Parameters

Parameter | Type | Default | Required | Description
--------- | ---- | ------- | -------- | -----------
cid | string | | required | The campaign ID this number pool belongs to. You must set up the campaign before creating a number pool for it.
type | string | Toll-free | | Toll-free or Local, the type of number that is desired for this number pool.
country | string| US | | For Local number pools only, the 2 character country code for the country you would like the numbers to be in. Possible values: US CA AT BE DK FI FR GB IE IT NL PL SE
afid | string | | | The affiliate ID this number pool belongs to. You must set up the affiliate before you create the number pool.
max_pool_size | integer | 10 | | The maximum number of numbers you want in this number pool.
buffer_seconds | integer | 0 | | The number of seconds for a number to retain its assignment after the visitor has left your site.
hide_embedded_access | boolean | false | | When true, will not show the embedded affiliate phone number management interface for this campaign.
google_analytics | boolean | false | | Enables our Google Analytics integration. Incompatible with number pools that have an assigned affiliate.
reserve_size | integer | 1 | | The number of numbers to pre-provision and hold in reserve. Allows numbers to be instantly assigned and helps avoid delays in provisioning numbers.



## Update a Number Pool

```shell
curl -s \
    -X PUT \
    https://api.retreaver.com/number_pools/49.json \
    -H "Content-Type: application/json" \
    -d '{"number_pool":{"max_pool_size":"1000"}}'
```

> The above command returns JSON structured like this:

```json
{
    "number_pool": {
        "id": 49,
        "numbers_count": 0,
        "country": "US",
        "max_pool_size": 1000,
        "buffer_seconds": 0,
        "updated_at": "2013-04-25T18:53:52Z",
        "created_at": "2013-04-25T16:53:52Z",
        "hide_embedded_access": true,
        "google_analytics": true,
        "afid": null,
        "cid": "111",
        "type": "Toll-free",
        "reserve_size": 1,
        "google_analytics_paths": [
            {
                "name": "Network timer (always)",
                "path": "/callpixels/8ddc04aa-0020-45eb-89df-ed45b8ed43a7"
            },
            {
                "name": "Network timer (connect)",
                "path": "/callpixels/18135f62-00ff-4818-941d-d88b6a93f27d"
            }
        ]
    }
}
```

Updates the Number Pool with any attributes you have passed in.

<aside class="notice">
You must replace <code>49</code> with the Retreaver ID of the Number Pool you want to update.
</aside>


### HTTP Request


`PUT https://api.retreaver.com/number_pools/49.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"number_pool":{"max_pool_size":"1000"}}`



## Remove a Number Pool


```shell
curl -X DELETE https://api.retreaver.com/number_pools/49.json?api_key=woofwoofwoof&company_id=1
```

Deletes the given Number Pool.

<aside class="warning">
This will also delete all Numbers associated with this Number Pool!
</aside>







# Companies

Company exists to allow resellers to separate their resources by Company. AFID and CID collisions will not occur between Companies.


## Get the active Company

```shell
curl "https://api.retreaver.com/company.json?api_key=woofwoofwoof"
```

> The above command returns JSON structured like this:

```json
{
    "company": {
        "id": 1,
        "name": "Retreaver",
        "created_at": "2012-04-17T22:58:17.000Z",
        "updated_at": "2024-12-19T11:00:37.896Z",
        "embedded_key": "6e1a3c121f83dad4c0bef78414b9e597",
        "per_number": "1.0",
        "use_global_suppression_list": true,
        "balance": "100.0",
        "owner_user_name": "Alice Bob"
    }
}
```

Returns the currently active Company. This is the Company that will be modified if a request is sent in without a specific company_id.

<aside class="warning">
You should always pass in the <code>company_id</code> parameter when requesting other objects, because switching Companies in the web interface will also switch Companies in the API.
</aside>

### HTTP Request

`GET https://api.retreaver.com/company.json?api_key=woofwoofwoof`


## Get a specific Company

```shell
curl "https://api.retreaver.com/companies/1.json?api_key=woofwoofwoof"
```

> The above command returns JSON structured like this:

```json
{
    "company": {
        "id": 1,
        "name": "Retreaver",
        "created_at": "2012-04-17T22:58:17.000Z",
        "updated_at": "2024-12-19T11:00:37.896Z",
        "embedded_key": "6e1a3c121f83dad4c0bef78414b9e597",
        "per_number": "1.0",
        "use_global_suppression_list": true,
        "balance": "100.0",
        "owner_user_name": "Alice Bob"
    }
}
```

Returns the Company matching our internal ID.

### HTTP Request

`GET https://api.retreaver.com/companies/1.json?api_key=woofwoofwoof`


## Get all Companies

```shell
curl "https://api.retreaver.com/companies.json?api_key=woofwoofwoof"
```

> The above command returns JSON structured like this:

```json
[
    {
        "company": {
            "id": 1,
            "name": "Foo Corp",
            "created_at": "2015-10-08T15:23:31.777Z",
            "updated_at": "2016-09-15T02:55:46.690Z",
            "embedded_key": "6e1a3c121f83dad4c0bef78414b9e597",
            "per_number": "1.0",
            "use_global_suppression_list": true,
            "balance": "200.0",
            "owner_user_name": "Alice Bob"
        }
    },
    {
        "company": {
            "id": 2,
            "name": "Example Co",
            "created_at": "2015-10-11T17:18:22.675Z",
            "updated_at": "2016-09-15T02:55:46.708Z",
            "embedded_key": "6e1a3c121f83dad4c0bef78414b9e597",
            "per_number": "1.0",
            "use_global_suppression_list": true,
            "balance": "100.0",
            "owner_user_name": "Charlie Smith"
        }
    }
 ]
```

Provides a complete list of Companies accessible via your Account.


### HTTP Request

`GET https://api.retreaver.com/companies.json?api_key=woofwoofwoof`


## Create a Company

```shell
curl -s \
    -X POST \
    https://api.retreaver.com/companies.json \
    -H "Content-Type: application/json" \
    -d '{"company":{"name":"Retreaver"}}'
```

> The above command returns JSON structured like this:

```json
{
    "company": {
        "id": 1,
        "name": "Retreaver",
        "created_at": "2025-01-28T12:18:44.131Z",
        "updated_at": "2025-01-28T12:18:44.131Z",
        "embedded_key": "6e1a3c121f83dad4c0bef78414b9e597",
        "per_number": "1.0",
        "use_global_suppression_list": true,
        "balance": "100.0",
        "owner_user_name": "Alice Bob"
    }
}
```

Creates a Company.

<aside class="info">
The Companies you create each have their own Accounts and payment settings.
</aside>


### HTTP Request

`POST https://api.retreaver.com/companies.json?api_key=woofwoofwoof`

`Content-Type: application/json`

`{"company":{"name":"CallPixels.com"}}`


### Parameters

Parameter | Type | Default | Required | Description
--------- | ---- | ------- | -------- | -----------
name | string |  | required | The company name.


## Update a Company

```shell
curl -s \
    -X PUT \
    https://api.retreaver.com/companies/1.json \
    -H "Content-Type: application/json" \
    -d '{"company":{"name":"Retreaver"}}'
```

> The above command returns JSON structured like this:

```json
{
    "company": {
        "id": 1,
        "name": "Retreaver",
        "created_at": "2025-01-28T12:18:44.131Z",
        "updated_at": "2025-01-28T12:34:27.103Z",
        "embedded_key": "6e1a3c121f83dad4c0bef78414b9e597",
        "per_number": "1.0",
        "use_global_suppression_list": true,
        "balance": "100.0",
        "owner_user_name": "Alice Bob"
    }
}
```

Updates the given Company with any attributes you have passed in.

<aside class="notice">
You must replace <code>2</code> with the Retreaver ID of the Company you want to update.
</aside>


### HTTP Request


`PUT https://api.retreaver.com/companies/2.json?api_key=woofwoofwoof`

`Content-Type: application/json`

`{"company":{"name":"Retreaver"}}`



## Remove a Company


```shell
curl -X DELETE https://api.retreaver.com/companies/2.json?api_key=woofwoofwoof
```

Deletes the given Company. You must delete any Numbers and Number Pools the Company has first.


### HTTP Request


`DELETE https://api.retreaver.com/companies/2.json?api_key=woofwoofwoof`


# Contacts

Contacts allow you to tie individual Calls from many Contact Numbers back to one person. You can also tag Contacts, and calls from their Contact Numbers will automatically inherit the tags.


## Get all Contacts


```shell
curl "https://api.retreaver.com/contacts.json?api_key=woofwoofwoof&company_id=1"
```

> The above command returns JSON structured like this:

```json
[{
    "contact": {
        "id": 2,
        "contact_numbers": [
            {
                "number": "+18668987878",
                "description": "Landline",
                "id": 2
            }
        ],
        "tag_values": [
            {
                "key": "name",
                "value": "Retreaver Support",
                "operator": "==",
                "id": 154060720
            }
        ]
    }
}]
```


Provides a complete list of Contacts.

### HTTP Request

`GET https://api.retreaver.com/contacts.json?api_key=woofwoofwoof&company_id=1`


## Get a Specific Contact by ID

```shell
curl "https://api.retreaver.com/contacts/2.json?api_key=woofwoofwoof&company_id=1"
```

> The above command returns JSON structured like this:

```json
{
    "contact": {
        "id": 2,
        "contact_numbers": [
            {
                "number": "+18668987878",
                "description": "Landline",
                "id": 2
            }
        ],
        "tag_values": [
            {
                "key": "name",
                "value": "Retreaver Support",
                "operator": "==",
                "id": 154060720
            }
        ]
    }
}
```

Finds a Contact by its Retreaver ID.


### HTTP Request

`GET https://api.retreaver.com/contacts/2.json?api_key=woofwoofwoof&company_id=1`


## Create a Contact

```shell
curl -s \
    -X POST \
    https://api.retreaver.com/contacts.json \
    -H "Content-Type: application/json" \
    -d '{"contact":{"tag_list":"<<<name:Retreaver Support>>>","contact_numbers_attributes":[{"number":"8668987878", "description":"Landline"}]}}'
```

> The above command returns JSON structured like this:

```json
{
    "contact": {
        "id": 2,
        "contact_numbers": [
            {
                "number": "+18668987878",
                "description": "Landline",
                "id": 2
            }
        ],
        "tag_values": [
            {
                "key": "name",
                "value": "Retreaver Support",
                "operator": "==",
                "id": 154060720
            }
        ]
    }
}
```

Creates a Contact and associated Contact Number(s).

### HTTP Request

`POST https://api.retreaver.com/contacts.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"contact":{"tag_list":"<<<name:Retreaver Support>>>","contact_numbers_attributes":[{"number":"8668987878", "description":"Landline"}]}}`


### Parameters

Parameter | Type | Default | Required | Description
--------- | ---- | ------- | -------- | -----------
tag_list | string | | | See notes below.
contact_numbers_attributes | array | | required | An array of Contact Numbers.


**Nested Attribute: Contact Number**

These are the phone numbers that are associated with your Contact.


Parameter | Type | Default | Required | Description
--------- | ---- | ------- | -------- | -----------
number | string | | required |  Either a phone number or `sip:user@domain.com` formatted SIP endpoint. PSTN numbers should be [E.164 formatted](https://en.wikipedia.org/wiki/E.164).
description | string | | | A description of the phone number, like 'Home', 'Mobile', 'Work', 'iPhone', etc.

### tag_list notes

To set tags on a Contact, pass in a comma delineated, triple-angle-bracket enclosed string of tags as the `tag_list` value.

The system will create/find whatever tags you have set given this input without you having to track tag IDs. You must include the full list of tags you want set any time a tag_list parameter is passed in. To clear the tags, just pass in a blank string.

There is a limit of 100 tags added in this manner, but the system will automatically concatenate US zip `geo` tags.


## Update a Contact


```shell
curl -s \
    -X PUT \
    https://api.retreaver.com/contacts/2.json?api_key=woofwoofwoof&company_id=1 \
    -H "Content-Type: application/json" \
    -d '{"contact":{"contact_numbers_attributes":[{"id":2,"number":"+18001234567"}]}}'
```

> The above command returns JSON structured like this:

```json
{
    "contact": {
        "id": 2,
        "contact_numbers": [
            {
                "number": "+18001234567",
                "description": "Landline",
                "id": 2
            }
        ],
        "tag_values": [
            {
                "key": "name",
                "value": "Retreaver Support",
                "operator": "==",
                "id": 154060720
            }
        ]
    }
}
```

Changes any attributes you have passed in on the Contact. To change a Contact Number, you must pass in the ID of the
existing Contact Number, or see [below](#update-a-contact-number-by-phone-number) for an easier method.


### HTTP Request

`PUT https://api.retreaver.com/contacts/2.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"contact":{"contact_numbers_attributes":[{"id":2,"number":"+18001234567"}]}}`



## Remove a Contact

```shell
curl -X DELETE https://api.retreaver.com/contacts/2.json?api_key=woofwoofwoof&company_id=1
```

Deletes the given Contact and all Contact Numbers associated with it.


### HTTP Request


`DELETE https://api.retreaver.com/contacts/2.json?api_key=woofwoofwoof&company_id=1`


## Get a specific Contact by phone number

```shell
curl "https://api.retreaver.com/contact_numbers/+18001234567/contact.json?api_key=woofwoofwoof&company_id=1"
```

> The above command returns JSON structured like this:

```json
{
    "contact": {
        "id": 2,
        "contact_numbers": [
            {
                "number": "+18001234567",
                "description": "Landline",
                "id": 2
            }
        ],
        "tag_values": [
            {
                "key": "name",
                "value": "Retreaver Support",
                "operator": "==",
                "id": 154060720
            }
        ]
    }
}
```

Finds a Contact by phone number.


### HTTP Request

`GET https://api.retreaver.com/contact_numbers/+18001234567/contact.json?api_key=woofwoofwoof&company_id=1`


## Update a Contact by phone number


```shell
curl -s \
    -X PUT \
    https://api.retreaver.com/contact_numbers/+18001234567/contact.json?api_key=woofwoofwoof&company_id=1 \
    -H "Content-Type: application/json" \
    -d '{"contact":{"tag_list":"<<<name:Invalid Number>>>"}}'
```

> The above command returns JSON structured like this:

```json
{
    "contact": {
        "id": 2,
        "contact_numbers": [
            {
                "number": "+18001234567",
                "description": "Landline",
                "id": 2
            }
        ],
        "tag_values": [
            {
                "key": "name",
                "value": "Invalid Number",
                "operator": "==",
                "id": 154060721
            }
        ]
    }
}
```

Updates a Contact by phone number.


### HTTP Request

`PUT https://api.retreaver.com/contact_numbers/+18001234567/contact.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"contact":{"tag_list":"<<<name:Invalid Number>>>"}}`


## Delete a Contact by phone number

```shell
curl -X DELETE https://api.retreaver.com/contact_numbers/+18001234567/contact.json?api_key=woofwoofwoof&company_id=1
```

Deletes the contact associated with the phone number and all other contact numbers associated with the contact.


### HTTP Request


`DELETE https://api.retreaver.com/contact_numbers/+18001234567/contact.json?api_key=woofwoofwoof&company_id=1`


# Contact Numbers

A convenience API for removing and updating Contact Numbers.

## Delete a Contact Number from a Contact by phone number

```shell
curl -X DELETE https://api.retreaver.com/contact_numbers/+18668987878.json?api_key=woofwoofwoof&company_id=1
```

Deletes the contact number from the Contact it is associated with, as long as the Contact has more than one Contact Number.

### HTTP Request


`DELETE https://api.retreaver.com/contact_numbers/+18668987878.json?api_key=woofwoofwoof&company_id=1`


## Update a Contact Number by phone number

```shell
curl -s \
    -X PUT \
    https://api.retreaver.com/contact_numbers/+18001234567.json?api_key=woofwoofwoof&company_id=1 \
    -H "Content-Type: application/json" \
    -d '{"contact_number":{"number":"+18005551234"}}'
```

> The above command returns JSON structured like this:

```json
{
    "contact_number": {
        "number": "+18005551234",
        "description": "Landline",
        "id": 2
    }
}
```

Easily updates a Contact Number.

### HTTP Request

`PUT https://api.retreaver.com/contact_numbers/+18001234567.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"contact_number":{"number":"+18005551234"}}`


# Suppressed Numbers

Manage the company's Suppressed Numbers, including creating, updating, deleting, and retrieving suppressed numbers.

<aside  class="notice">
Suppressed Numbers exist regardless of whether or not there is a corresponding Contact Number or Contact.
</aside>

## Check whether or not the company has any Suppressed Numbers

 Returns a boolean value (```true ```/```false```) whether the Company has any suppressed numbers.

```shell
curl https://api.retreaver.com/suppressed_numbers/check.json?api_key=woofwoofwoof&company_id=1
```

> The above command returns JSON structured like this:

```json
{ "suppressed_numbers_exist": true }
```

Returns true if the Company has any numbers suppressed.

### HTTP Request

`GET https://api.retreaver.com/suppressed_numbers/check.json?api_key=woofwoofwoof&company_id=1`

## Get all Suppressed Numbers for a Company

Get information about all of the numbers that are currently suppressed in a company.

```shell
curl https://api.retreaver.com/suppressed_numbers.json?api_key=woofwoofwoof&company_id=1
```

> The above command returns JSON structured like this:

<aside class="notice">
    The Campaign ID `cid` will be returned only if the Suppressed Number is associated with a Campaign.
</aside>

```json
[
  {
    "suppressed_number": {
      "id": 18996945,
      "number": "+13213749611",
      "created_at": "2024-09-30T21:09:54.769Z",
      "can_resubscribe": true,
      "company_id": 1,
      "cid": 159
    }
  },
  {
    "suppressed_number": {
      "id": 18996946,
      "number": "+13216065590",
      "created_at": "2024-09-30T21:09:54.769Z",
      "can_resubscribe": true,
      "company_id": 1,
      "cid": 111
    }
  },
  {
    "suppressed_number": {
      "id": 18996947,
      "number": "+13216437667",
      "created_at": "2024-09-30T21:09:54.769Z",
      "can_resubscribe": true,
      "company_id": 1,
    }
  }
]
```

### HTTP Request

`GET https://api.retreaver.com/suppressed_numbers.json?api_key=woofwoofwoof&company_id=1`

## Get a specific Suppressed Number

Returns information about the Suppressed Number in the company, by the provided number. The number should be in the format: `+13216065590`

```shell
curl https://api.retreaver.com/suppressed_numbers/+13216065590.json?api_key=woofwoofwoof&company_id=1
```

> The above command returns JSON structured like this:

<aside class="notice">
    The Campaign ID `cid` will be returned only if the Suppressed Number is associated with a Campaign.
</aside>

```json
{
  "suppressed_number": {
    "id": 18996946,
    "number": "+13216065590",
    "created_at": "2024-09-30T21:09:54.769Z",
    "can_resubscribe": true,
    "company_id": 1,
    "cid": 111
  }
}
```

### HTTP Request

`GET https://api.retreaver.com/suppressed_numbers/+13216065590.json?api_key=woofwoofwoof&company_id=1`

## Delete a number from the company's Suppressed Numbers

Deletes the provided  number  from the company's suppressed numbers. The number should be in the format: `+13216065590`

```shell
curl -X DELETE https://api.retreaver.com/suppressed_numbers/+13216065590.json?api_key=woofwoofwoof&company_id=1
```

### HTTP Request

`DELETE https://api.retreaver.com/suppressed_numbers/+13216065590.json?api_key=woofwoofwoof&company_id=1`

## Create a Suppressed Number for a Company

Adds a number to the company's Suppressed Numbers. The `can_resubscribe` value toggles whether or not the caller can unblock themselves by pressing 7 if there is a "Caller Blocked" Prompt on the Campaign/Number they are calling.

The entire body of the post is optional, simply posting to `https://api.retreaver.com/suppressed_numbers/+13216065590.json?api_key=woofwoofwoof&company_id=1` would block `+13216065590`; `can_resubscribe` is `true` by default. The intended use case is to allow callers to restore contact with a company after choosing to be routed to a "Add caller to suppressed numbers and hang up" routing option.

```shell
curl -s \
    -X POST \
    https://api.retreaver.com/suppressed_numbers/+13216065590.json?api_key=woofwoofwoof&company_id=1 \
    -H "Content-Type: application/json" \
    -d '{"suppressed_number": {"can_resubscribe": false}}'
```

> The above command returns JSON structured like this:

```json
{
  "id": 18996958,
  "company_id": 1,
  "affiliate_id": null,
  "campaign_id": null,
  "number": "+13216065590",
  "created_at": "2024-10-11T08:50:59.981Z",
  "updated_at": "2024-10-11T08:50:59.981Z",
  "can_resubscribe": false
}
```

### HTTP Request

`POST https://api.retreaver.com/suppressed_numbers/+13216065590.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"suppressed_number": {"can_resubscribe": false}}`

## Update a Suppressed Number for a Company

By sending a `PUT` request you can update properties such as `can_resubscribe` and `campaign_id` for an already created Suppressed Number. The number should be in the format: `+13216065590`.

```shell
curl -s \
    -X POST \
    https://api.retreaver.com/suppressed_numbers/+13216065590.json?api_key=woofwoofwoof&company_id=1 \
    -H "Content-Type: application/json" \
    -d '{"suppressed_number": {"can_resubscribe": false}}'
```

### HTTP request

`PUT http://api.retreaver.com/suppressed_numbers/+13216065590.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"can_resubscribe": false, "campaign_id": "116dc0f6"}`


# Static Caller Numbers

Static Caller Numbers are used to tell Retreaver that calls from a certain CallerID should be handled separately. Use
Static Caller Numbers when you have a call center sending you many calls with the same CallerID. Retreaver will either
prompt the caller for the caller's real number, or will randomize the CallerID for use with our call control API.

## Get all Static Caller Numbers


```shell
curl "https://api.retreaver.com/static_caller_numbers.json?api_key=woofwoofwoof&company_id=1"
```

> The above command returns JSON structured like this:

```json
[{
    "static_caller_number": {
        "id": 1234,
        "number": "+18668987878",
        "created_at": "2013-10-02T14:36:14.166-04:00"
    }
}]
```


Provides a complete list of Static Numbers.

### HTTP Request

`GET https://api.retreaver.com/static_caller_numbers.json?api_key=woofwoofwoof&company_id=1`


## Create a Static Caller Number

```shell
curl -s \
    -X POST \
    https://api.retreaver.com/static_caller_numbers.json?api_key=woofwoofwoof&company_id=1 \
    -H "Content-Type: application/json" \
    -d '{"static_caller_number":{"number":"+18668987878"}}'
```

Creates a Static Caller Number.

### HTTP Request

`POST https://api.retreaver.com/static_caller_numbers.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"static_caller_number": {"number": "+18668987878"}}`


### Parameters

Parameter | Type | Default | Required | Description
--------- | ---- | ------- | -------- | -----------
number | string | null | required | A phone number in [E.164 format](https://en.wikipedia.org/wiki/E.164).


## Delete a Static Caller Number

```shell
curl -X DELETE https://api.retreaver.com/static_caller_numbers/1234.json?api_key=woofwoofwoof&company_id=1
```

Removes the Static Caller Number.

### HTTP Request

`DELETE https://api.retreaver.com/static_caller_numbers/1234.json?api_key=woofwoofwoof&company_id=1`
