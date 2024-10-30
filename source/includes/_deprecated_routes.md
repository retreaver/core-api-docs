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