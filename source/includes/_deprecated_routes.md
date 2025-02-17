# DEPRECATED ROUTES

## Check whether or not you have any Suppressed Numbers

<aside class="warning">
    This route is no longer supported. Please use <a href="https://retreaver.github.io/core-api-docs/#check-whether-or-not-the-company-has-any-suppressed-numbers">the updated route</a> for all future requests.
</aside>

```shell
curl https://api.retreaver.com/suppression_list/check.json?api_key=woofwoofwoof&company_id=1
```

> The above command returns JSON structured like this:


```json
{"suppression_list":true}
```

Returns true if the Company has any numbers suppressed.

### HTTP Request

`GET https://api.retreaver.com/suppression_list/check.json?api_key=woofwoofwoof&company_id=1`

## Delete a Contact Number from the Suppression List by phone number

<aside class="warning">
    This route is no longer supported. Please use <a href="https://retreaver.github.io/core-api-docs/#delete-a-number-from-the-company-39-s-suppressed-numbers">the updated route</a> for all future requests.
</aside>

```shell
curl -X DELETE https://api.retreaver.com/contact_numbers/+18668987878/suppressed_number.json?api_key=woofwoofwoof&company_id=1
```

Removes the Contact Number from your Suppression List.

### HTTP Request

`DELETE https://api.retreaver.com/contact_numbers/+18668987878/suppressed_number.json?api_key=woofwoofwoof&company_id=1`

## Suppress a Contact Number by phone number

<aside class="warning">
    This route is no longer supported. Please use <a href="https://retreaver.github.io/core-api-docs/#create-a-suppressed-number-for-a-company">the updated route</a> for all future requests.
</aside>

```shell
curl -s \
    -X POST \
    https://api.retreaver.com/contact_numbers/+18668987878/suppressed_number.json?api_key=woofwoofwoof&company_id=1 \
    -H "Content-Type: application/json" \
    -d '{"suppressed_number":{"can_resubscribe":false}}'
```

> The above command returns JSON structured like this:

```json
{
    "suppressed_number": {
        "id": 502997,
        "number": "+18668987878",
        "can_resubscribe": false,
        "created_at": "2013-10-02T14:36:14.166-04:00"
    }
}
```

Adds a Contact Number to the Company's Suppression List. The `can_resubscribe` value toggles whether or not the contact
can unblock themselves by pressing 7 if there is a "Caller Blocked" Prompt on the Campaign/Number they are calling.

The entire body of the post is optional, simply posting to
`https://api.retreaver.com/contact_numbers/+18668987878/suppressed_number.json?api_key=woofwoofwoof&company_id=1`
would block +18668987878; `can_resubscribe` is `true` by default. The intended use case is to allow callers to restore
contact with a company after choosing to be routed to a "add caller to suppression list and hang up" routing option.

### HTTP Request

`POST https://api.retreaver.com/contact_numbers/+18668987878/suppressed_number.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"suppressed_number": {"can_resubscribe": false}}`

## Get the active Company - DEPRECATED

<aside class="warning">
    This route is no longer supported. Please use <a href="https://retreaver.github.io/core-api-docs/#get-the-active-company">the updated route</a> for all future requests.
</aside>


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

Returns the currently active Company. This is the Company that will be modified if a request is sent in without a specific company_id.

### HTTP Request

`GET https://api.retreaver.com/company.json?api_key=woofwoofwoof`

## Get a specific Company - DEPRECATED

<aside class="warning">
    This route is no longer supported. Please use <a href="https://retreaver.github.io/core-api-docs/#get-a-specific-company">the updated route</a> for all future requests.
</aside>


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

Returns the Company matching our internal ID.

### HTTP Request

`GET https://api.retreaver.com/companies/1.json?api_key=woofwoofwoof`

## Get all Companies - DEPRECATED

<aside class="warning">
    This route is no longer supported. Please use <a href="https://retreaver.github.io/core-api-docs/#get-all-companies">the updated route</a> for all future requests.
</aside>


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

Provides a complete list of Companies accessible via your Account.


### HTTP Request

`GET https://api.retreaver.com/companies.json?api_key=woofwoofwoof`

## Create a Company - DEPRECATED

<aside class="warning">
    This route is no longer supported. Please use <a href="https://retreaver.github.io/core-api-docs/#create-a-company">the updated route</a> for all future requests.
</aside>


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
default_click_url | string | | | The default click URL to set as a Timer @ 0 seconds when creating a campaign.
default_sale_url | string | | | The default sale URL to set as a Timer @ 90 seconds when creating a campaign


## Update a Company - DEPRECATED

<aside class="warning">
    This route is no longer supported. Please use <a href="https://retreaver.github.io/core-api-docs/#update-a-company">the updated route</a> for all future requests.
</aside>


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

Updates the given Company with any attributes you have passed in.

<aside class="notice">
    You must replace <code>2</code> with the Retreaver ID of the Company you want to update.
</aside>


### HTTP Request


`PUT https://api.retreaver.com/companies/2.json?api_key=woofwoofwoof`

`Content-Type: application/json`

`{"company":{"name":"Retreaver"}}`