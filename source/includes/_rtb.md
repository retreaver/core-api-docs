# Real-Time Bidding (RTB)

The Retreaver Real-Time Bidding (RTB) API enables publishers to send requests to Retreaver and receive confirmation on whether a call buyer(endpoint) is available.

Each response includes key details such as:

	The destination phone number to route the call to
	The expected payout
	The required duration (in seconds) of the call

To learn more about the scenarios you can implement with the RTB API, see the guide:
<a href="https://help.retreaver.com/hc/en-us/articles/27282552552340-Working-with-the-Retreaver-Real-Time-Bidding-API">Working with the Retreaver Real-Time Bidding API</a>

## Create a reservation

> Passing data as URL Params

~~~shell
curl -X POST "https://rtb.retreaver.com/rtbs.json?" \
  -d "key=7fc40342-f0a0-4e8f-bf09-b3887eedcb41" \
  -d "publisher_id=retreaver_pub" \
  -d "caller_number=+18558485518"
~~~

> or as JSON Body

~~~shell
curl -X POST "https://rtb.retreaver.com/rtbs.json" \
  -d '{
	"key": "7fc40342-f0a0-4e8f-bf09-b3887eedcb41",
	"publisher_id": "retreaver_pub",
	"caller_number": "+18558485518"
}'
~~~


The request checks for availability and bidding, and then creates a reservation. This reservation is stored for a limited number of seconds.

If additional requests are sent for the same caller number while the reservation is active, the API will return the same reservation. For more details, see the documentation on Retreaver Ping Shield.

Note: A reservation can have different statuses. Creating a reservation does not necessarily mean that an agent is immediately available.

Parameter | Mandatory | Description
--------- | ------- | -----------
key | Yes | Postback key, found on the campaign page where the Real Time Bidding Postback Key is issued.
publisher_id/source_id | Yes | The Source/Affiliate/Publisher this bid is going to be attributed to.
caller_number | Yes | The caller number.
inbound_number | No | If provided the `rtb` will expect the caller to call this number. If not provided the `rtb` will return a temporary number.
tags | No | Providing additional query parameters will result in tagging the `rtb` with those additional values. Please view the examples below.

If you want you can use body params to send the parameters into `rtb`.


### Pass additional data

Additional information could be passed along as params to the request. In this case 'age' and 'caller_zip'.

~~~shell
curl -X POST "https://rtb.retreaver.com/rtbs.json" \
  -d '{
	"key": "7fc40342-f0a0-4e8f-bf09-b3887eedcb41",
	"publisher_id": "retreaver_pub",
	"caller_number": "+18558485518",
	"caller_zip": 12344,
	"age": 25
}'
~~~

> The above command returns JSON structured like this:

~~~json
{
	"uuid": "c6e4ce37-9b49-46af-bd8e-16cb7753499d",
	"status": "reserved",
	"retreaver_payout": 5.0,
	"retreaver_seconds": 10,
	"inbound_number": "+18772435010",
	"expires_at": "2024-10-28T12:08:49.880Z"
}
~~~

#### Parameters

Parameter | Value
--------- | -------
key | 7fc40342-f0a0-4e8f-bf09-b3887eedcb41
publisher_id | retreaver_pub
caller_number | +18558485518
caller_zip | 12344
age | 25



### Place a bid on a static inbound number.

~~~shell
curl -X POST "https://rtb.retreaver.com/rtbs.json" \
 	-d '{
		"key": "7fc40342-f0a0-4e8f-bf09-b3887eedcb41",
		"publisher_id": "retreaver_pub",
		"caller_number": "+18558485518",
		"inbound_number": "+12029795452"
		}'
~~~

> The above command returns JSON structured like this:

~~~json
{
	"uuid": "c6e4ce37-9b49-46af-bd8e-16cb7753499d",
	"status": "reserved",
	"retreaver_payout": 5.0,
	"retreaver_seconds": 10,
	"inbound_number": "+18772435010",
	"expires_at": "2024-10-28T12:08:49.880Z"
}
~~~


If you do not want to use a number pool and provide rtb using a static number you own in retreaver you, must provide it:

#### Parameters

Parameter | Value
--------- | -------
key | 7fc40342-f0a0-4e8f-bf09-b3887eedcb41
publisher_id | retreaver_pub
caller_number | +18558485518
caller_zip | 12344
age | 25
inbound_number | +12029795452

## Confirm a reservation


`PUT/PATCH https://rtb.retreaver.com/rtbs/{reservation_uuid}`

~~~shell
curl -X PUT "https://rtb.retreaver.com/rtbs/c6e4ce37-9b49-46af-bd8e-16cb7753499d.json" \
  -d '{
	"key": "7fc40342-f0a0-4e8f-bf09-b3887eedcb41",
	"status": "confirmed"
}'
~~~

> the reservation is confirmed

~~~json
{
	"uuid": "c6e4ce37-9b49-46af-bd8e-16cb7753499d",
	"status": "confirmed",
	"retreaver_payout": 5.0,
	"retreaver_seconds": 10,
	"inbound_number": "+18772435010",
	"expires_at": "2024-10-28T12:08:49.880Z"
}
~~~

> the reservation is 'no-target' if it can not be confirmed

~~~json
{
	"uuid": "c6e4ce37-9b49-46af-bd8e-16cb7753499d",
	"status": "no-target",
}
~~~

Call buyers (endpoints) on Retreaver can be limited by various caps, such as Concurrency Cap, Hourly Cap, Weekly Cap, and Monthly Cap.

When a reservation is created in Retreaver, it is not immediately counted against these caps. This is because most reservations do not result in actual calls.

To apply a reservation to the caps, it must first be confirmed.

To confirm the resevration send a PUT/PATCH request


#### Parameters

Parameter | Value   | Description
--------- | ------- | ---------
reservation_uuid | c6e4ce37-9b49-46af-bd8e-16cb7753499d | The reservation UUID that we are confirming. It is received from the first request when the reservation is created.
key | 7fc40342-f0a0-4e8f-bf09-b3887eedcb41 | The postback key
status | "confirmed" | 'confirmed' will confirm the reservation

<aside class="notice">
Reservations can be automatically applied to caps if this behavior is enabled on the postback key.

Otherwise, they must be explicitly confirm by sending a PUT/PATCH request to the reservation URL with a status="confirmed" param.
</aside>

<aside class="notice">
Important: It is possible that a reservation cannot be confirmed if the caps are filled in the time between creation and confirmation.
Make sure you check the response from the request and see what the status is.
</aside>


<aside class="warning">
When a reservation is confirmed, the publisher is <strong>expected to place the call</strong>. Failing to do so may lead to penalties in both the short and long term, since holding a reservation ties up an agent and wastes their time.
</aside>


## Retreaver Ping Shield

~~~shell
curl -X POST "https://rtb.retreaver.com/rtbs.json" \
 -d '{
 	"key": 7fc40342-f0a0-4e8f-bf09-b3887eedcb41"
 	"publisher_id": "retreaver_pub",
 	"caller_number": "+18558485518"
 }'

curl -X POST "https://rtb.retreaver.com/rtbs.json" \
 -d '{
 	"key": 7fc40342-f0a0-4e8f-bf09-b3887eedcb41"
 	"publisher_id": "retreaver_pub",
 	"caller_number": "+18558485518"
 }'
~~~

> The above command returns JSON structured like this:

~~~json
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
~~~
> Note that the response is the same, but the second on has '"retreaver_ping_shield": true' which indicates it has been shielded.

If a publisher sends multiple RTB requests for the same caller_number before the initial reservation expires, Retreaver Ping Shield will activate.

Ping Shield caches the first response and prevents unnecessary processing of duplicate requests. This ensures that buyers are not pinged multiple times for the same caller on the same postback key, while still returning the original reservation to the publisher.
