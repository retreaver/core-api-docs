By entering your affiliates in our system, you can more easily manage your existing numbers. Affiliates exist for your reference.

# GET /affiliates

Provides a complete list of affiliates.

**Resource URL**
@note http://callpixels.com/affiliates.format

# GET /affiliates/afid/0002

Finds an affiliate by AFID.

**Resource URL**
@note http://callpixels.com/affiliates/afid/0002.format

**Response**
~~~~
XML
<?xml version="1.0" encoding="UTF-8"?>
<affiliates type="array">
  <affiliate>
    <afid>0002</afid>
    <first-name>Nancy</first-name>
    <last-name>Drew</last-name>
    <updated-at type="datetime">2012-05-03T15:56:01Z</updated-at>
    <created-at type="datetime">2012-05-03T15:56:01Z</created-at>
  </affiliate>
</affiliates>
~~~~

# POST /affiliates

Creates an affiliate.

**Resource URL**
@note http://callpixels.com/affiliates.format

##Parameters
@param afid {string} The affiliate's AFID.
@param [first_name] {string} The affiliate's first name, for your reference.
@param [last_name] {string} The affiliate's last name, for your reference.

**Request**
~~~~
JSON
{"affiliate":{"first_name":"Nancy", "last_name":"Drew", "afid":"0002"}}
~~~~
**Response**
~~~~
JSON
{
  "affiliate": {
    "afid": "0002",
    "first_name": "Nancy",
    "last_name": "Drew",
    "updated_at": "2012-05-03T15:56:01Z",
    "created_at": "2012-05-03T15:56:01Z"
  }
}
~~~~

# DELETE /affiliates/afid/0002

Deletes the given affiliate. You must delete any numbers the affiliate has before deleting the affiliate.

**Resource URL**
@note http://callpixels.com/affiliates/afid/0002.format

# PUT /affiliates/afid/0002

Updates the given affiliate.

**Resource URL**
@note http://callpixels.com/affiliates/afid/007.format

**Request**
http://callpixels.com/affiliates/afid/007.json?api_key=FromMyAccountPage
~~~~
JSON
{"affiliate":{"first_name":"James"}}
~~~~

**Response**
~~~~
JSON
{
  "affiliate": {
    "afid": "007",
    "first_name": "James",
    "last_name": "Bond",
    "updated_at": "2012-05-03T20:20:03Z",
    "created_at": "2012-05-03T14:29:37Z"
  }
}
~~~~