# Reports
## Reports Parameters
`GET https://api.retreaver.com/api/v1/reports.json?....`

### Query Parameters

Parameter | Mandatory | Description
--------- | ------- | -----------
api_key | Yes | The api_key used to authenticate this request.
domain | Yes | The domain of the report. Currently only 'calls'
facet | Yes | One of: ['publisher', 'buyer', 'campaign', 'number', 'daily', 'tag_value']
created_at_start | Yes |
created_at_end | Yes |
page | No
per_page | No
tag_value_key | No | When faceting by tag_value you may want to provide a second facet to drill down on. [Example](#tag-value-name-report)

NOTE: created_at_start must be before created_at_end and the two must be smaller that 2 years apart.

## Tag Value Report
```shell
curl "https://api.retreaver.com/api/v1/reports.json?api_key=woofwoofwoof&facet=tag_value&domain=calls&created_at_start=2024-10-25&created_at_end=2024-10-28"
```

> The above command returns JSON structured like this:

```json
{
	"count": 3,
	"count_total": 3,
	"data": [
		{
			"id": "utm_campaign",
			"facet_name": "utm_campaign",
			"total_calls": 3,
			"repeat_count": 2.0,
			"duplicate_count": 0.0,
			"unique_calls": 1.0,
			"converted_count": 0.0,
			"revenue": 0.0,
			"payout": 0.0,
			"cost": 0.12,
			"total_duration": 3.666666666666667,
			"total_duration_percent": 0.4714045207910327,
			"rescued_count": 0.0,
			"rescued_revenue": 0.0,
			"connected_duration": 0.0,
			"connected_duration_percent": 0.0,
			"in_progress_count": 0.0,
			"profit": -0.12,
			"repeat_count_percent": 66.66666666666666,
			"duplicate_count_percent": 0,
			"converted_count_percent": 0,
			"rescued_count_percent": 0,
			"epc": 0,
			"cpc": 0
		}
	]
}
```

Get a report for all calls between 2024-10-25 and 2024-10-28 faceted by tag_value name.

`GET https://api.retreaver.com/api/v1/reports.json?api_key=woofwoofwoof&facet=tag_value&domain=calls&created_at_start=2024-10-25&created_at_end=2024-10-28`

Parameter | Value
--------- | -------
api_key | woofwoofwoof
domain | calls
facet | tag_value
created_at_start | 2024-10-25
created_at_end | 2024-10-28

## Tag Value Name Report
```shell
curl "https://api.retreaver.com/api/v1/reports.json?...&tag_value_key=utm_campaign"
```

> The above command returns JSON structured like this:

```json
{
	"count": 3,
	"count_total": 3,
	"data": [
		{
			"id": "ret_campaign_123",
			"facet_name": "ret_campaign_123",
			"total_calls": 2,
			"repeat_count": 2.0,
			"duplicate_count": 0.0,
			"unique_calls": 1.0,
			"converted_count": 0.0,
			"revenue": 0.0,
			"payout": 0.0,
			"cost": 0.12,
			"total_duration": 3.666666666666667,
			"total_duration_percent": 0.4714045207910327,
			"rescued_count": 0.0,
			"rescued_revenue": 0.0,
			"connected_duration": 0.0,
			"connected_duration_percent": 0.0,
			"in_progress_count": 0.0,
			"profit": -0.12,
			"repeat_count_percent": 66.66666666666666,
			"duplicate_count_percent": 0,
			"converted_count_percent": 0,
			"rescued_count_percent": 0,
			"epc": 0,
			"cpc": 0
		},
    {
			"id": "ret_campaign_456",
			"facet_name": "ret_campaign_456",
			"total_calls": 1,
			"repeat_count": 0,
			"duplicate_count": 0.0,
			"unique_calls": 1.0,
			"converted_count": 0.0,
			"revenue": 0.0,
			"payout": 0.0,
			"cost": 0.12,
			"total_duration": 3.666666666666667,
			"total_duration_percent": 0.4714045207910327,
			"rescued_count": 0.0,
			"rescued_revenue": 0.0,
			"connected_duration": 0.0,
			"connected_duration_percent": 0.0,
			"in_progress_count": 0.0,
			"profit": -0.12,
			"repeat_count_percent": 66.66666666666666,
			"duplicate_count_percent": 0,
			"converted_count_percent": 0,
			"rescued_count_percent": 0,
			"epc": 0,
			"cpc": 0
		}
	]
}
```

Get a report for all calls between 2024-10-25 and 2024-10-28 faceted by the tag 'utm_campaign'.

`GET https://api.retreaver.com/api/v1/reports.json?...&tag_value_key=utm_campaign`

The redundant parameters from the previous example are omitted. Please view the previous example.

Parameter | Value
--------- | -------
... | ...
tag_value_key | utm_campaign


## Not all tag values are indexed
```shell
curl "https://api.retreaver.com/api/v1/reports.json?...&tag_value_key=unindexed_tag_value"
```

> The above command returns JSON structured like this:

```json
{
	"count": 0,
	"count_total": 0,
	"data": []
}
```

To reduce the noise from billions of uninteresting values, we only report the values for Tags explicitly created for the company along with a few system Tags. To see a report on the values of 'unindexed_tag_value', please visit the Tags page and create a tag with key 'unindexed_tag_value'. We will start indexing it from today. Let us know if you would like us to re-index past calls.

`GET https://api.retreaver.com/api/v1/reports.json?...&tag_value_key=unindexed_tag_value`

The redundant parameters from the previous example are omitted. Please view the previous example.

Parameter | Value
--------- | -------
... | ...
tag_value_key | unindexed_tag_value
