# Target Groups

Target Groups group Target objects and can be used in Campaign/Number routing settings, allowing you to easily manage
how calls are routed.


## Get all Target Groups

~~~shell
curl "https://api.retreaver.com/target_groups.json?api_key=woofwoofwoof&company_id=1"
~~~

> The above command returns JSON structured like this:

~~~json
[
  {
    "target_group": {
      "id": 1,
      "name": "test",
      "target_ids": [
        1,
        2,
        3
      ],
      "concurrency_cap": null,
      "calls_in_progress": 0,
      "behavior": 1,
      "priority": null,
      "weight": null,
      "caps": [
        {
          "id": 652980,
          "filled": 0,
          "cap": null,
          "type": "Daily"
        },
        {
          "id": 652978,
          "filled": 0,
          "cap": null,
          "type": "Hard"
        },
        {
          "id": 652979,
          "filled": 0,
          "cap": null,
          "type": "Hourly"
        },
        {
          "id": 652981,
          "filled": 0,
          "cap": null,
          "type": "Monthly"
        }
      ]
    }
  }
]
~~~



### HTTP Request

`GET https://api.retreaver.com/target_groups.json?api_key=woofwoofwoof&company_id=1`


## Get a specific Target Group


~~~shell
curl "https://api.retreaver.com/target_groups/1.json?api_key=woofwoofwoof&company_id=1"
~~~

> The above command returns JSON structured like this:

~~~json
{
  "target_group": {
    "id": 1,
    "name": "test",
    "target_ids": [
      1,
      2,
      3
    ],
    "concurrency_cap": null,
    "calls_in_progress": 0,
    "behavior": 1,
    "priority": null,
    "weight": null,
    "caps": [
      {
        "id": 652980,
        "filled": 0,
        "cap": null,
        "type": "Daily"
      },
      {
        "id": 652978,
        "filled": 0,
        "cap": null,
        "type": "Hard"
      },
      {
        "id": 652979,
        "filled": 0,
        "cap": null,
        "type": "Hourly"
      },
      {
        "id": 652981,
        "filled": 0,
        "cap": null,
        "type": "Monthly"
      }
    ]
  }
}
~~~


### HTTP Request

`GET https://api.retreaver.com/target_groups/1.json?api_key=woofwoofwoof&company_id=1`



## Create a Target Group

~~~shell
curl -s \
 -X POST \
 https://api.retreaver.com/target_groups.json?api_key=woofwoofwoof&company_id=1 \
 -H "Content-Type: application/json" \
 -d '{"target_group":{"target_ids": [1, 2, 3], "name":"test", "concurrency_cap": 5}}'
~~~

> The above command returns JSON structured like this:

~~~json
{
  "target_group": {
    "id": 1,
    "name": "test",
    "target_ids": [
      1,
      2,
      3
    ],
    "concurrency_cap": 5,
    "calls_in_progress": 0,
    "behavior": 1,
    "priority": null,
    "weight": null,
    "caps": [
      {
        "id": 652980,
        "filled": 0,
        "cap": null,
        "type": "Daily"
      },
      {
        "id": 652978,
        "filled": 0,
        "cap": null,
        "type": "Hard"
      },
      {
        "id": 652979,
        "filled": 0,
        "cap": null,
        "type": "Hourly"
      },
      {
        "id": 652981,
        "filled": 0,
        "cap": null,
        "type": "Monthly"
      }
    ]
  }
}
~~~

Creates a new Target Group.


### HTTP Request

`POST https://api.retreaver.com/target_groups.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"target_group":{"target_ids": [1, 2, 3], "name":"test", "concurrency_cap": 5}}`


### Parameters

Parameter | Type | Default | Required | Description
--------- | ---- | ------- | -------- | -----------
name | string | | required | A descriptive moniker for this target group so you'll know what it is.
priority | integer | null | if behavior = 2 | Used to set the priority of the group when dialing using simuldial. See Target documentation for more information.
weight | integer | null | if behavior = 2 | Used to set the weight of the group when dialing using simuldial. See Target documentation for more information.
concurrency_cap | integer | null | | Used to limit the maximum number of concurrent calls this target group can receive.
target_ids | integer array | [ ] | | A list of target IDs that will belong to this group.
behavior | integer | 1 | | 1 = Dial separately, 2 = Simuldial (dial all Targets within the group at the same time)

## Update a Target Group

~~~shell
curl -s \
 -X PUT \
 https://api.retreaver.com/target_groups/1.json \
 -H "Content-Type: application/json" \
 -d '{"target_group":{"name":"hello"}}'
~~~

> The above command returns JSON structured like this:

~~~json
{
  "target_group": {
    "id": 1,
    "name": "hello",
    "target_ids": [
      1,
      2,
      3
    ],
    "concurrency_cap": 5,
    "calls_in_progress": 0,
    "behavior": 1,
    "priority": null,
    "weight": null,
    "caps": [
      {
        "id": 652980,
        "filled": 0,
        "cap": null,
        "type": "Daily"
      },
      {
        "id": 652978,
        "filled": 0,
        "cap": null,
        "type": "Hard"
      },
      {
        "id": 652979,
        "filled": 0,
        "cap": null,
        "type": "Hourly"
      },
      {
        "id": 652981,
        "filled": 0,
        "cap": null,
        "type": "Monthly"
      }
    ]
  }
}
~~~

Changes any attributes you have passed in on the Target Group.

<aside class="notice">
You must replace <code>1</code> with the Retreaver ID of the Target Group you want to update.
</aside>


### HTTP Request


`PUT https://api.retreaver.com/target_groups/1.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"target_group":{"name":"hello"}}`



## Delete a Target Group


~~~shell
curl -X DELETE https://api.retreaver.com/target_groups/1.json?api_key=woofwoofwoof&company_id=1
~~~

Deletes the given Target Group.

### HTTP Request

`DELETE https://api.retreaver.com/target_groups/1.json?api_key=woofwoofwoof&company_id=1`


## Replacing Targets in a Target Group

~~~shell
curl -s \
 -X PUT \
 https://api.retreaver.com/target_groups/1.json \
 -H "Content-Type: application/json" \
 -d '{"target_group":{"target_ids":[5,6]}}'
~~~

> Upon reloading the Target, the following JSON is returned with the given targets:

~~~json
{
  "target_group": {
    "id": 1,
    "name": "hello",
    "target_ids": [
      5,
      6
    ],
    "concurrency_cap": 5,
    "calls_in_progress": 0,
    "behavior": 1,
    "priority": null,
    "weight": null,
    "caps": [
      {
        "id": 652980,
        "filled": 0,
        "cap": null,
        "type": "Daily"
      },
      {
        "id": 652978,
        "filled": 0,
        "cap": null,
        "type": "Hard"
      },
      {
        "id": 652979,
        "filled": 0,
        "cap": null,
        "type": "Hourly"
      },
      {
        "id": 652981,
        "filled": 0,
        "cap": null,
        "type": "Monthly"
      }
    ]
  }
}
~~~

To replace which Targets are in a Target Group, pass in an array of Target IDs as `target_ids`. All existing Targets
on the Target Group will be replaced with the Targets provided in this array.

This is the standard method of updating the Target ID list in which you have to pass in the entire list
each time. We also have 2 helper methods, below, for adding and removing Targets.


### HTTP Request


`PUT https://api.retreaver.com/target_groups/1.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"target_group":{"target_ids":[5,6]}}`



## Adding Targets to a Target Group

~~~shell
curl -s \
 -X PUT \
 https://api.retreaver.com/target_groups/1.json \
 -H "Content-Type: application/json" \
 -d '{"target_group":{"add_targets_by_id":[4]}}'
~~~

> Upon reloading the Target, the following JSON is returned with Target ID 4 added:

~~~json
{
  "target_group": {
    "id": 1,
    "name": "hello",
    "target_ids": [
      1,
      2,
      3,
      4
    ],
    "concurrency_cap": 5,
    "calls_in_progress": 0,
    "behavior": 1,
    "priority": null,
    "weight": null,
    "caps": [
      {
        "id": 652980,
        "filled": 0,
        "cap": null,
        "type": "Daily"
      },
      {
        "id": 652978,
        "filled": 0,
        "cap": null,
        "type": "Hard"
      },
      {
        "id": 652979,
        "filled": 0,
        "cap": null,
        "type": "Hourly"
      },
      {
        "id": 652981,
        "filled": 0,
        "cap": null,
        "type": "Monthly"
      }
    ]
  }
}
~~~

To add Targets to a Target Group, pass in an array of Target IDs as `add_targets_by_id`. This is a helper
attribute provided so that you don't have to track which Targets are in each Group.


### HTTP Request


`PUT https://api.retreaver.com/target_groups/1.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"target_group":{"add_targets_by_id":[4]}}`



## Removing Targets from a Target Group

~~~shell
curl -s \
 -X PUT \
 https://api.retreaver.com/target_groups/1.json \
 -H "Content-Type: application/json" \
 -d '{"target_group":{"remove_targets_by_id":[1]}}'
~~~

> Upon reloading the Target, the following JSON is returned with Target ID 1 removed:

~~~json
{
  "target_group": {
    "id": 1,
    "name": "hello",
    "target_ids": [
      2,
      3
    ],
    "concurrency_cap": 5,
    "calls_in_progress": 0,
    "behavior": 1,
    "priority": null,
    "weight": null,
    "caps": [
      {
        "id": 652980,
        "filled": 0,
        "cap": null,
        "type": "Daily"
      },
      {
        "id": 652978,
        "filled": 0,
        "cap": null,
        "type": "Hard"
      },
      {
        "id": 652979,
        "filled": 0,
        "cap": null,
        "type": "Hourly"
      },
      {
        "id": 652981,
        "filled": 0,
        "cap": null,
        "type": "Monthly"
      }
    ]
  }
}
~~~

To remove Targets from a Target Group, pass in an array of Target IDs as `remove_targets_by_id`. This is a helper 
attribute provided so that you don't have to track which Targets are in each Group.


### HTTP Request


`PUT https://api.retreaver.com/target_groups/1.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"target_group":{"remove_targets_by_id":[1]}}`



## Changing a Target Group's Caps


~~~shell
curl -s \
 -X PUT \
 https://api.retreaver.com/target_groups/1.json \
 -H "Content-Type: application/json" \
 -d '{"target_group": { \
         "hard_cap_attributes": { \
             "cap": 100 \ 
             } \
         }' \
     }'
~~~

> The above command returns JSON structured like this:

~~~json
{
  "target_group": {
    "id": 1,
    "name": "test",
    "target_ids": [
      1,
      2,
      3
    ],
    "concurrency_cap": null,
    "calls_in_progress": 0,
    "behavior": 1,
    "priority": null,
    "weight": null,
    "caps": [
      {
        "id": 652980,
        "filled": 0,
        "cap": null,
        "type": "Daily"
      },
      {
        "id": 652978,
        "filled": 0,
        "cap": 100,
        "type": "Hard"
      },
      {
        "id": 652979,
        "filled": 0,
        "cap": null,
        "type": "Hourly"
      },
      {
        "id": 652981,
        "filled": 0,
        "cap": null,
        "type": "Monthly"
      }
    ]
  }
}
~~~


There are 4 types of caps: Hard Cap, Hourly Cap, Daily Cap, and Monthly Cap. Hard cap is a hard limit, and once it is reached, Targets in the Target Group will not receive more Calls until the Cap is reset. This is useful when routing Calls to buyers that have insertion orders for a set number of leads.

The other types of Cap reset periodically as expected.

You can modify these Caps by updating your Target Group with nested objects `hard_cap_attributes`, `hourly_cap_attributes`, `daily_cap_attributes`, and `monthly_cap_attributes`.

### HTTP Request

`PUT https://api.retreaver.com/target_groups/1.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

`{"target_group":{"hard_cap_attributes":{"cap":100}}}`


### Parameters

Parameter | Type | Default | Required | Description
--------- | ---- | ------- | -------- | -----------
cap | integer |  | required | The value for the cap.


## Resetting all Hard Caps on Targets in a Target Group

~~~shell
curl -s \
 -X POST \
 https://api.retreaver.com/target_groups/1/reset_cap.json?api_key=woofwoofwoof&company_id=1 \
 -H "Content-Type: application/json"
~~~

Clears any Calls contributing to the given Target Group's hard cap, resetting hard caps of all Targets within the Group to 0. Returns HTTP 200 on success.

### HTTP Request

`POST https://api.retreaver.com/target_groups/1/reset_cap.json?api_key=woofwoofwoof&company_id=1`

`Content-Type: application/json`

