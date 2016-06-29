## Reseller API



# GET /company

Returns the currently active company. This is the company that will be modified if a request is sent in without a specific company_id.

**Resource URL**
@note http://callpixels.com/company.format

# GET /companies

Provides a complete list of companies.

**Resource URL**
@note http://callpixels.com/companies.format

# GET /companies/1

Returns the company matching our internal ID.

**Resource URL**
@note http://callpixels.com/companies/1.format

**Response**
~~~~
JSON
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
~~~~

# POST /companies

Creates a company. This is available to resellers only.

**Resource URL**
@note http://callpixels.com/companies.format

##Parameters
@param name {string} The company name.
@param [default_click_url] {string}
@param [default_sale_url] {string}

**Request**
~~~~
JSON
{"company":{"name":"CallPixels.com"}}
~~~~
**Response**
~~~~
JSON
{
    "company": {
        "id": 2,
        "name": "CallPixels.com",
        "default_click_url": null,
        "default_sale_url": null,
        "created_at": "2012-05-07T15:44:39Z",
        "updated_at": "2012-05-07T15:44:39Z"
    }
}

~~~~

# DELETE /companies/2

Deletes the given company. You must delete any numbers the company has first.

**Resource URL**
@note http://callpixels.com/companies/2.format

# PUT /companies/2

Updates the given company.

**Resource URL**
@note http://callpixels.com/companies/2.format

**Request**
http://callpixels.com/companies/1.json?api_key=FromMyAccountPage
~~~~
JSON
{"company":{"name":"CallPixels.com"}}
~~~~

**Response**
~~~~
JSON
{
    "company": {
        "id": 1,
        "name": "CallPixels.com",
        "default_click_url": "http://callpixels.com/?a=[affiliate_id]&c=[campaign_id]&cp=js&s1=[sub_id]",
        "default_sale_url": "http://callpixels.com/p.ashx?o=[campaign_id]&t=[call_log_id]-[caller_id]-[called_number]-[call_duration]-[call_recording_url]",
        "created_at": "2012-04-15T05:44:10Z",
        "updated_at": "2012-05-07T15:48:14Z"
    }
}
~~~~