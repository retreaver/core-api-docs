---
title: Retreaver Core 0.1 API Reference

language_tabs:
  - shell: cURL

toc_footers:
  - <a href='https://retreaver.com/users/sign_up'>Sign Up for a Developer Key</a>
  - <a href='https://support.retreaver.com/'>Knowledge Base</a>

includes:
  - errors

search: true
---

# Introduction

The Retreaver Core API can be used to automate core business processes, like changing where calls are routed, and many other
features that would normally be accessed through our account portal.

If you're looking for information on tracking visitors and displaying phone numbers on your landing pages, please see
our [Retreaver.js](https://github.com/retreaver/retreaver-js) library.

The API can be used to automate core business processes, but does not currently support all functionality.

*Please note: We're currently working on a versioned replacement for this API. This API isn't going away, but soon we'll be promoting the new API and if you bring this one up you'll cause flashbacks and general anxiety. If you're building an API, this is a very poor example of what an API should look like.*

## Version

This is our *unversioned* API and for sake of clarity we'll refer to it henceforth as: 

`Retreaver Core 0.1`


## Multi-format

The Retreaver Core API can be accessed by JSON or XML. Simply change the file extension and Content-Type header to match your preferences.

We recommend using JSON since XML is archaic, has high overhead, and is generally awful.

Format | Content-Type     | Extension
------ | ---------------- | ---------
JSON   | application/json | json
XML    | text/xml         | xml


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

<aside class="warning">
You should <strong>never, ever expose your Retreaver Core API key publicly</strong> as it can be used to access your entire Retreaver account without restriction!
</aside>

If you suspect your API key has been publicly exposed, [reset it](https://support.retreaver.com/faq/how-do-i-get-my-api-key/).

# Calls

Or, more precisely, phone calls.

## Get Recent Calls

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

Provides access to the call log. The call log contains all the calls which have been made through Numbers under your control.

### HTTP Request

`GET https://retreaver.com/calls.json?api_key=woofwoofwoof&company_id=1`

### Query Parameters

Parameter | Default | Description
--------- | ------- | -----------
created_at_start | -4712-01-01T00:00:00+00:00 | Return any calls that were created after this date.
created_at_end | 4712-01-01T00:00:00+00:00 | Return any calls that were created before this date.
order | desc | `asc` or `desc`, for ascending or descending.
sort_by | created_at | `created_at` or `updated_at`, calls will be sorted by this value. If you only want recently updated calls, sort by updated_at. 

## Enumerate through all calls
 
 > First page...
 
```shell
curl "https://api.retreaver.com/calls.json?api_key=woofwoofwoof&company_id=1&sort_by=created_at&order=asc&page=1"
```

> Second page...
 
```shell
curl "https://api.retreaver.com/calls.json?api_key=woofwoofwoof&company_id=1&sort_by=created_at&order=asc&page=2"
```

> etc...

To fetch all calls on your account, use the `sort_by` and `order` params to return your calls in the order they were
created, and then paginate through all your calls.

### HTTP Request

`https://api.retreaver.com/calls.json?api_key=woofwoofwoof&company_id=1&sort_by=created_at&order=asc&page=1`

`https://api.retreaver.com/calls.json?api_key=woofwoofwoof&company_id=1&sort_by=created_at&order=asc&page=2`


## Enumerate through calls in a specific date/time range.

```shell
curl "https://api.retreaver.com/calls.json?api_key=woofwoofwoof&company_id=1&created_at_start=2016-01-01T00:00:00+00:00&created_at_end=2016-01-02T00:00:00+00:00&page=1"
```

By passing in `created_at_start` and `created_at_end` parameters, you can control the start and end time of calls returned.

The timestamp should be formatted according to [rfc3339](https://validator.w3.org/feed/docs/error/InvalidRFC3339Date.html)

### HTTP Request

`GET https://api.retreaver.com/calls.json?api_key=woofwoofwoof&company_id=1&created_at_start=2016-01-01T00:00:00+00:00&created_at_end=2016-01-02T00:00:00+00:00&page=1`

## Get a Specific Call

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

`GET https://retreaver.com/calls/addcf985-017e-4962-be34-cf5d55e74afc.json?api_key=woofwoofwoof&company_id=1`




# Affiliates

Entering affiliates into our system allows you to attribute calls back to the affiliate who created them, and to update any external tracking systems. 

If you're not in affiliate marketing, affiliate objects can be used for whatever source attribution is relevant. Affiliates exist for your reference.


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


Provides a complete list of affiliates.

### HTTP Request

`GET https://retreaver.com/affiliates.xml?api_key=woofwoofwoof&company_id=1`


## Get a Specific Affiliate by ID

```shell
curl "https://api.retreaver.com/affiliates/afid/0002.json?api_key=woofwoofwoof&company_id=1"
```

Finds an affiliate by AFID.


### HTTP Request

`GET https://api.retreaver.com/affiliates/afid/0002.xml?api_key=woofwoofwoof&company_id=1`


## Create an Affiliate

```shell
curl -s \
    -X POST \
    https://api.retreaver.com/affiliates.json \
    -H "Content-Type: application/json" \
    -d '{"affiliate":{"first_name":"Nancy", "last_name":"Drew", "afid":"0002"}}'
```

Creates an affiliate.

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
You must replace <code>0002</code> with the afid of the affiliate you want to delete.
</aside>


### HTTP Request

`PUT https://api.retreaver.com/affiliates/afid/0002.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"affiliate":{"first_name":"Nathan"}}`



## Remove an affiliate

```shell
curl -X DELETE https://api.retreaver.com/affiliates/afid/0002.json?api_key=woofwoofwoof&company_id=1
```

Deletes the given affiliate. You must delete any numbers the affiliate has before deleting the affiliate.




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

`GET https://retreaver.com/targets.json?api_key=woofwoofwoof&company_id=1`


## Get a Specific Target


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

Creates a new target.


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

We'll only attempt to route calls to your target during its business hours. These hours are based on the target `time_zone`. Note that when *updating* business hours on a target, you must pass in the existing `id` attribute that gets created on this request.

Parameter | Type | Default | Required | Description
--------- | ---- | ------- | -------- | -----------
day_of_week | integer | | required | A zero-indexed day of the week, with 0 being Sunday and 6 being Saturday. 
work_day | boolean | true | | Whether or not the target is open on this day.
time_open | integer | 0 | | The 24 hour time the target opens, formatted `HHMM`.
time_close | integer | 2400 | | The 24 hour time the target closes, formatted `HHMM`.
inverted | boolean | false | | Open hours become closed! Closed become open! Oh the insanity! Great if you have overnight shifts.

### Valid Time Zones

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
You must replace <code>22592</code> with the Retreaver ID of the target you want to delete.
</aside>


### HTTP Request


`PUT https://api.retreaver.com/targets/22592.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"target":{"paused":true}}`



## Remove a Target


```shell
curl -X DELETE https://api.retreaver.com/targets/22592.json?api_key=woofwoofwoof&company_id=1
```

Deletes the given target.

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

> Upon reloading the target, the following JSON is returned with the tags included:

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

To set tags on a target, pass in a comma delimitated, triple-angle-bracket enclosed string of tags as the `tag_list` value.

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


There are 4 types of caps: Hard Cap, Hourly Cap, Daily Cap, and Monthly Cap. Hard cap is a hard limit, and once it is reached, the target will not receive more calls until the cap is reset. This is useful when routing calls to buyers that have insertion orders for a set number of leads.

The other types of cap reset periodically as expected.

You can modify these caps by updating your target with nested objects `hard_cap_attributes`, `hourly_cap_attributes`, `daily_cap_attributes`, and `monthly_cap_attributes`.

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

Clears any calls contributing to the given target's hard cap, resetting it to 0. Returns HTTP 200 on success.

### HTTP Request

`POST https://api.retreaver.com/targets/22592/reset_cap.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`



# Campaigns

By configuring a campaign, you can reuse the settings of the campaign when creating numbers. Campaigns should be configured before creating numbers.


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

List all the campaigns in your account.


### HTTP Request

`GET https://retreaver.com/campaigns.json?api_key=woofwoofwoof&company_id=1`


## Get a Specific Campaign


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


### HTTP Request

`GET https://retreaver.com/campaigns/cid/0044.json?api_key=woofwoofwoof&company_id=1`



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

Create a new campaign. 


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
You must replace <code>0044</code> with the cid of the campaign you want to update.
</aside>


### HTTP Request


`PUT https://api.retreaver.com/campaigns/cid/0044.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"affiliate":{"first_name":"Nathan"}}`



## Remove a Campaign


```shell
curl -X DELETE https://api.retreaver.com/campaigns/cid/0044.json?api_key=woofwoofwoof&company_id=1
```

Delete a campaign by CID. You must delete all the numbers belonging to that campaign first.












# Numbers

Numbers are the physical phone numbers that you want routed to a campaign. A number can be routed directly to the target phone number, or it can be screened with a greeting which requires the caller to press a button to continue. The IVR can be configured to have options that forward to other campaigns if desired.

Numbers can be set to use the settings of an existing campaign.


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



### HTTP Request

`GET https://retreaver.com/numbers.json?api_key=woofwoofwoof&company_id=1`


### Parameters

Parameter | Default | Description
--------- | ------- | -----------
cid | null | Restrict results to numbers that belong to the given Campaign ID.
afid | null | Restrict results to numbers that belong to the given Affiliate ID.
sid | null | Restrict results to numbers that belong to the given SubID.


## Get a Specific Number


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


### HTTP Request

`GET https://retreaver.com/numbers/5.json?api_key=woofwoofwoof&company_id=1`


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

Creates a new phone number.



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
menu_option_attributes | array | | | An array of menu options.
  
  
**Nested Attribute: Timer**

Only include Timers if you want to override the campaign settings. For more information on Timers, see [Campaign](#create-a-campaign).

If you do include timers, the `inherited` attribute on them will be set to `false`.


Parameter | Type | Default | Required | Description
--------- | ---- | ------- | -------- | -----------
seconds | integer |  | required | The minimum length of time the call must last for this pixel to be fired. If set to 0, the pixel will fire at the beginning of the call, much like a click.
url | string |  | required | The URL that should be called for this timer. The URL does not have to be a pixel, and will be passed any cookies that were set on the 0-second timer. Our bot follows redirects intelligently.


**Nested Attribute: Menu Option**

Only include Menu Options if you want to override the campaign settings. See [Campaign](#create-a-campaign) for more details.

If you do include menu options, the `inherited` attribute on them will be set to `false`.


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
You must replace <code>79</code> with the Retreaver ID of the number you want to update.
</aside>


### HTTP Request


`PUT https://api.retreaver.com/numbers/79.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"number":{"afid":"0005"}}`



## Remove a Number


```shell
curl -X DELETE https://api.retreaver.com/numbers/79.json?api_key=woofwoofwoof&company_id=1
```

Deletes the given number. Numbers will be deprovisioned within 24 hours. Do not delete numbers if you are porting them to another provider, 
until you have confirmed that the port has completed.



# Number Pools

Number pools are used to dynamically assign numbers whenever a user visits your website. Number pools are used in lieu of static numbers when 
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

Returns all the number pools you have in our system.


### HTTP Request

`GET https://retreaver.com/number_pools.json?api_key=woofwoofwoof&company_id=1`

### Parameters

Parameter | Default | Description
--------- | ------- | -----------
cid | null | Restrict results to number pools that belong to the given Campaign ID.
afid | null | Restrict results to number pools that belong to the given Affiliate ID.


## Get a Specific Number Pool


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

Returns a single number pool based on our internal ID.


### HTTP Request

`GET https://retreaver.com/number_pools/1.json?api_key=woofwoofwoof&company_id=1`


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


Creates a new number pool.


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
You must replace <code>49</code> with the Retreaver ID of the number pool you want to update.
</aside>


### HTTP Request


`PUT https://api.retreaver.com/number_pools/49.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"number_pool":{"max_pool_size":"1000"}}`



## Remove a Number Pool


```shell
curl -X DELETE https://api.retreaver.com/number_pools/49.json?api_key=woofwoofwoof&company_id=1
```

Deletes the given number pool.

<aside class="warning">
This will also delete all numbers associated with this pool!
</aside>







# Companies

Company exists to allow resellers to separate their resources by company. AFID and CID collisions will not occur between companies.


## Get the Active Company

```shell
curl "https://api.retreaver.com/company.json?api_key=woofwoofwoof"
```

> The above command returns JSON structured like this:

```json
{
    "company": {
        "id": 1,
        "name": "CallPixels",
        "default_click_url": "http://callpixels.com/?a=[affiliate_id]&c=[campaign_id]&cp=js&s1=[sub_id]",
        "default_sale_url": "http://callpixels.com/p.ashx?o=[campaign_id]&t=[call_log_id]-[caller_id]-[called_number]-[call_duration]-[call_recording_url]",
        "created_at": "2012-04-15T05:44:10Z",
        "updated_at": "2012-05-07T15:32:44Z"
    }
}
```

Returns the currently active company. This is the company that will be modified if a request is sent in without a specific company_id.

<aside class="warning">
You should always pass in the <code>company_id</code> parameter when requesting other objects, because switching companies in the web interface will also switch companies in the API.
</aside>

### HTTP Request

`GET https://retreaver.com/company.json?api_key=woofwoofwoof`


## Get a Specific Company

```shell
curl "https://api.retreaver.com/companies/1.json?api_key=woofwoofwoof"
```

> The above command returns JSON structured like this:

```json
{
    "company": {
        "id": 1,
        "name": "CallPixels",
        "default_click_url": "http://callpixels.com/?a=[affiliate_id]&c=[campaign_id]&cp=js&s1=[sub_id]",
        "default_sale_url": "http://callpixels.com/p.ashx?o=[campaign_id]&t=[call_log_id]-[caller_id]-[called_number]-[call_duration]-[call_recording_url]",
        "created_at": "2012-04-15T05:44:10Z",
        "updated_at": "2012-05-07T15:32:44Z"
    }
}
```

Returns the company matching our internal ID.

### HTTP Request

`GET https://retreaver.com/companies/1.json?api_key=woofwoofwoof`


## Get all Companies

```shell
curl "https://api.retreaver.com/companies.json?api_key=woofwoofwoof"
```

> The above command returns JSON structured like this:

```json
[{
     "company": {
         "id": 1,
         "name": "CallPixels",
         "default_click_url": "http://callpixels.com/?a=[affiliate_id]&c=[campaign_id]&cp=js&s1=[sub_id]",
         "default_sale_url": "http://callpixels.com/p.ashx?o=[campaign_id]&t=[call_log_id]-[caller_id]-[called_number]-[call_duration]-[call_recording_url]",
         "created_at": "2012-04-15T05:44:10Z",
         "updated_at": "2012-05-07T15:32:44Z"
     }
 }]
```

Provides a complete list of companies accessible via your account.


### HTTP Request

`GET https://retreaver.com/companies.json?api_key=woofwoofwoof`


## Create a Company

```shell
curl -s \
    -X POST \
    https://api.retreaver.com/companies.json \
    -H "Content-Type: application/json" \
    -d '{"company":{"name":"CallPixels.com"}}'
```

> The above command returns JSON structured like this:

```json
{
     "company": {
         "id": 1,
         "name": "CallPixels",
         "default_click_url": "http://callpixels.com/?a=[affiliate_id]&c=[campaign_id]&cp=js&s1=[sub_id]",
         "default_sale_url": "http://callpixels.com/p.ashx?o=[campaign_id]&t=[call_log_id]-[caller_id]-[called_number]-[call_duration]-[call_recording_url]",
         "created_at": "2012-04-15T05:44:10Z",
         "updated_at": "2012-05-07T15:32:44Z"
     }
}
```

Creates a company.

<aside class="info">
The companies you create each have their own accounts and payment settings.
</aside>


### HTTP Request

`POST https://api.retreaver.com/companies.json?api_key=woofwoofwoof`

`Content-Type: application/json`

`{"company":{"name":"CallPixels.com"}}`


### Parameters

Parameter | Type | Default | Required | Description
--------- | ---- | ------- | -------- | -----------
name | string |  | required | The company name.
default_click_url | string | | | The default click URL to set as a Timer @ 0 seconds when creating a campaign.
default_sale_url | string | | | The default sale URL to set as a Timer @ 90 seconds when creating a campaign 


## Update a Company

```shell
curl -s \
    -X PUT \
    https://api.retreaver.com/companies/2.json \
    -H "Content-Type: application/json" \
    -d '{"company":{"name":"Retreaver"}}'
```

> The above command returns JSON structured like this:

```json
{
     "company": {
         "id": 2,
         "name": "Retreaver",
         "default_click_url": "http://callpixels.com/?a=[affiliate_id]&c=[campaign_id]&cp=js&s1=[sub_id]",
         "default_sale_url": "http://callpixels.com/p.ashx?o=[campaign_id]&t=[call_log_id]-[caller_id]-[called_number]-[call_duration]-[call_recording_url]",
         "created_at": "2012-04-15T05:44:10Z",
         "updated_at": "2012-05-07T15:32:44Z"
     }
}
```

Updates the given company with any attributes you have passed in.

<aside class="notice">
You must replace <code>2</code> with the Retreaver ID of the company you want to update.
</aside>


### HTTP Request


`PUT https://api.retreaver.com/companies/2.json?api_key=woofwoofwoof`

`Content-Type: application/json`

`{"company":{"name":"Retreaver"}}`



## Remove a Company


```shell
curl -X DELETE https://api.retreaver.com/companies/2.json?api_key=woofwoofwoof
```

Deletes the given company. You must delete any numbers and number pools the company has first.


### HTTP Request


`DELETE https://api.retreaver.com/companies/2.json?api_key=woofwoofwoof`






