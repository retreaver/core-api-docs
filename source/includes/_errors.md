# Errors


The Retreaver Core API uses the following error codes:


Error Code | Meaning
---------- | -------
400 | Bad Request -- Your request was unintelligible. Check your formatting.
401 | Unauthorized -- Your API key is wrong or missing.
403 | Forbidden -- You didn't pass in your Company ID or you're using the wrong API key. 
404 | Not Found -- It actually, really doesn't exist.
405 | Method Not Allowed -- It doesn't respond to the HTTP action you used.
406 | Not Acceptable -- You requested a format that isn't JSON, or, sigh, XML.
410 | Gone -- It up and left or was otherwise deleted.
418 | I'm a little teapot!
429 | Too Many Requests -- Slow down. Highly concurrent requests are frowned upon.
500 | Internal Server Error -- We had a problem with our server. Try again later.
503 | Service Unavailable -- We're temporarily offline for maintenance. Please try again later.
