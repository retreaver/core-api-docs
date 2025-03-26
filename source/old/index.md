**Objects**

View our documentation on the APIs for Affiliates, Campaigns, Numbers, and Calls.

API Updates Mailing List
========================

If you are implementing our API, please subscribe to our [API update list](http://eepurl.com/vba4b) so we can inform you of changes and new versions.

API Pagination (12/13)
======================

As of January 7 2014, requests to the index pages for resources will be limited to 25 results.

In order to receive more results, you will need to include a ?page=x query parameter.

A HTTP *Link* header will be included in the response, providing a link to the first, previous, last, and next pages where appropriate.

~~~~
HTTP
GET /calls.json?page=3
HTTP/1.1 200 OK
Link: <http://callpixels.com/calls.json?page=1>; rel="first", <http://callpixels.com/calls.json?apage=2>; rel="prev", <http://callpixels/calls.json?page=49>; rel="last", <http://callpixels.com/calls.json?page=4>; rel="next"
~~~~

In order to faciliate a smooth transition, requests without a *page* query parameter will behave as normal until January 7th 2014.

Affiliate Network Integration Guides (04/13)
============================================

If you are looking to integrate CallPixels with your affiliate network, please follow our [Deep Integration Guide](https://s3.amazonaws.com/callpixels/CallPixels+Deep_Integration_V1.1.0.pdf) (pdf). The API does not give full access to all the features on CallPixels and is currently being maintained to support existing users. We also have information on our replacement tokens available in our [Webhooks and Timers Guide](https://s3.amazonaws.com/callpixels/CallPixels+Implementation+Guide_Webhooks_Timers_V1.0.2.pdf) (pdf).
We recommend following these guides as the methods described will continue to be developed and kept up-to-date with the features available in our sevice.

Please contact us at [support@callpixels.com](mailto:support@callpixels.com) to obtain a partner code and shared key.

General API Info
================

Generally, Object parameters must be nested in a named node in the root object.

For example, if you are updating an Affiliate, you will have to pass...

~~~~
JSON
{"affiliate":{"first_name":"John"}}
~~~~

You must also set an appropriate HTTP Content-Type header if you're posting JSON...

    Content-Type: application/json
... or XML.

    Content-Type: text/xml

You must also pass your API Key, and if you're a reseller, the Company ID that you are managing.

~~~~
JSON
{"affiliate":{"first_name":"John"},"api_key":"FromMyAccountPage","company_id":9}
~~~~

**Failure to include the company_id will have bad results for resellers.**

##API Key##

Get your API Key from the My Account page under the upper right corner User menu. Click Show at the bottom of the My Account page, and send that API key along with your requests. If you need to, you can reset your API key on that page.

Your API Key can be passed as a GET variable or it can be a node in the root of your request.

##Usage##

* Set up a campaign
* Create a number
* Call the number you just created
* Check out the call log
* Check your tracking system (Cake, HasOffers, HitPath, LinkTrust, etc) and see the click on your campaign

##Resellers##

* Sign in to callpixels.com to get your company ID. Click "Companies" in the Reseller section on your account menu, and you will see your company ID.


