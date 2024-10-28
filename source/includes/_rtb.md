# RTB

## RTB Query Parameters
`POST https://rtb.rtb.retreaver.com/rtbs.json?....`

Parameter | Mandatory | Description
--------- | ------- | -----------
key | Yes | Postback key, found on the campaign page where the Real Time Bidding Postback Key is issued.
publisher_id/source_id | Yes | The Source/Affiliate/Publisher this bid is going to be attributed to.
caller_number | Yes | The caller number.
inbound_number | No | If provided the `rtb` will expect the caller to call this number. If not provided the `rtb` will return a temporary number.
tags | No | Providing additional query parameters will result in tagging the `rtb` with those additional values. Please view the examples below.


## RTB Body Parameters

If you want you can use body params to send the parameters into `rtb`.

```shell
curl --request POST \
  --url https://retreaver.com/rtbs.json \
  --data '{
	"key": "7fc40342-f0a0-4e8f-bf09-b3887eedcb4a",
	"publisher_id": "retreaver_pub",
	"caller_number": "+18558485518"
}'
```

## Place a bid and tag it with zip code and age.

```shell
curl -X POST "https://rtb.retreaver.com/rtbs.json?key=7fc40342-f0a0-4e8f-bf09-b3887eedcb4a&publisher_id=retreaver_pub&caller_number=+18558485518&caller_zip=12344&age=25"
```

> The above command returns JSON structured like this:

```json
{
	"uuid": "c6e4ce37-9b49-46af-bd8e-16cb7753499d",
	"status": "reserved",
	"retreaver_payout": 5.0,
	"retreaver_seconds": 10,
	"inbound_number": "+18772435010",
	"expires_at": "2024-10-28T12:08:49.880Z"
}
```

### HTTP Request

`POST https://rtb.retreaver.com/rtbs.json?key=7fc40342-f0a0-4e8f-bf09-b3887eedcb4a&publisher_id=retreaver_pub&caller_number=+18558485518&caller_zip=12344&age=25.`

### Query Parameters

Parameter | Value
--------- | -------
key | 7fc40342-f0a0-4e8f-bf09-b3887eedcb4a
publisher_id | retreaver_pub
caller_number | +18558485518
caller_zip | 12344
age | 25



## Place a bid on a static inbound number.

```shell
curl -X POST "https://rtb.retreaver.com/rtbs.json?....&inbound_number=+12029795452"
```

> The above command returns JSON structured like this:

```json
{
	"uuid": "c6e4ce37-9b49-46af-bd8e-16cb7753499d",
	"status": "reserved",
	"retreaver_payout": 5.0,
	"retreaver_seconds": 10,
	"inbound_number": "+18772435010",
	"expires_at": "2024-10-28T12:08:49.880Z"
}
```

If you do not want to use a number pool and provide rtb using a static number you own in retreaver you, must provide it:

### HTTP Request

`POST "https://rtb.retreaver.com/rtbs.json?....&inbound_number=+12029795452"`

### Query Parameters

The redundant parameters from the previous example are omitted. Please view the previous example.

Parameter | Value
--------- | -------
... | ...
inbound_number | +12029795452


## Retreaver Ping Shield

```shell
curl -X POST "https://rtb.retreaver.com/rtbs.json?key=7fc40342-f0a0-4e8f-bf09-b3887eedcb4a&publisher_id=retreaver_pub&caller_number=+18558485518"
curl -X POST "https://rtb.retreaver.com/rtbs.json?key=7fc40342-f0a0-4e8f-bf09-b3887eedcb4a&publisher_id=retreaver_pub&caller_number=+18558485518"
```

> The above command returns JSON structured like this:

```json
{
	"uuid": "4454ffc8-c1b4-4420-81d2-4bbd1a1e132e",
	"status": "reserved",
	"retreaver_payout": 5.0,
	"retreaver_seconds": 10,
	"inbound_number": "+18778955221",
	"expires_at": "2024-10-28T12:29:04.397Z",
}

{
	"uuid": "4454ffc8-c1b4-4420-81d2-4bbd1a1e132e",
	"status": "reserved",
	"retreaver_payout": 5.0,
	"retreaver_seconds": 10,
	"inbound_number": "+18778955221",
	"expires_at": "2024-10-28T12:29:04.397Z",
	"retreaver_ping_shield": true
}
```
> Note that the response is the same, but the second on has '"retreaver_ping_shield": true' which indicates it has been shielded.

If a publisher tries to get an `rtb` for the same caller_number more than one time in less than the time it takes to expire the first `rtb` we will deploy a `ping_shield`.
Retreaver Ping Shield will cache the first `rtb` and shield you from pinging your buyers for the same caller.
