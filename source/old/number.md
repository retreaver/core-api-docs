

#GET numbers

Returns all the numbers you have in our system.

**Resource URL**
@note http://callpixels.com/numbers.format

#GET numbers/1

Returns a single number based on our internal ID.

**Resource URL**
@note http://callpixels.com/numbers/1.format

~~~~
JSON
{
   "number":{
      "id":5,
      "number":"+16479311232",
      "toll_free":false,
      "updated_at":"2012-05-03T13:53:23Z",
      "created_at":"2012-04-18T06:05:05Z",
      "sid":"superaffiliate",
      "afid":"0001",
      "cid":"111",
      "uses_campaign_settings":true,
      "greeting":{
         "message":"Hi There! Press one to continue.",
         "voice_gender":"Female",
         "inherited":true
      },
      "timers":[
         {
            "id":113,
            "seconds":0,
            "url":"http://www.thertrack.com/click.track?CID=[campaign_id]&AFID=[affiliate_id]&SID=[sub_id]",
            "inherited":true
         },
         {
            "id":114,
            "seconds":5,
            "url":"http://www.thertrack.com/pixel.track?CID=[campaign_id]&AFID=[affiliate_id]&SID=[sub_id]&MerchantReferenceID=[caller_id]-[called_number]-[call_duration]",
            "inherited":true
         }
      ],
      "menu_options":[
         {
            "menu_option":{
               "id":44,
               "option":"1",
               "target_cid":null,
               "target_number":"+18667878878",
               "inherited":true
            }
         }
      ]
   }
}
~~~~


#GET numbers/for/cid/0002/afid/0033/sid/sub_id

Searches for numbers matching the provided criteria.

**Resource URL**
@note http://callpixels.com/numbers/for/cid/0002/afid/0033/sid/sub_id.format

#POST numbers

Creates a new phone number.

**Resource URL**
@note http://callpixels.com/numbers.format

##Parameters

@param [type] {string}
@param [desired_text] {string}
@param [country] {string}
@param afid {string}
@param cid {string}
@param [sid] {string}
@param [destroy_nested] {boolean}  Defaults to false.

**Optional Parameters**
Only include these parameters if you want to override the campaign settings.

##Optional Parameters

@param [message] {string} (Text-to-Speech) A message you want read aloud to the caller when they dial your number. Make sure to tell them to press one to continue.
@param [voice_gender] {string} (Text-to-Speech) Male or Female, the gender of the text-to-speech voice you want.
@param [message_file] {file} (Audio File) An audio file you would like played for the caller when they dial your number. Use this field with multipart/form-data submissions.
@param [message_file_b64_data] {string} (Audio File) A Base64-encoded audio file. Only use this field if you're not using the message_file field.
@param [message_file_b64_filename] {string} (Audio File) The original file name for the Base64-encoded audio file. Something like 'memo.flac'. We suggest using the highest quality audio available.
@param [repeat] {integer} The number of times to repeat the greeting. Defaults to 4.
@param [timers_attributes] {array} An array of timers.
@param [menu_options_attributes] {array} An array of menu options.

**Timers**

##Nested Attribute: Timer
@param seconds {integer} The minimum length of time the call must last for this pixel to be fired. If set to 0, the pixel will fire at the beginning of the call, much like a click.
@param url {string} The URL that should be called for this timer. The URL does not have to be a pixel, and will be passed any cookies that were set on the 0-second timer.

**Menu Options**
Only include Menu Options if you want to override the campaign settings. See [Campaign](/docs/1.0/references-objects-campaign) for more details.

##Nested Attribute: Menu Option
@param option {string} The button the caller will press. The default menu option for a campaign is the one for button press '1', so if you aren't using an IVR and want the call to forward instantly, set the option to '1'. (1 2 3 4 5 6 7 8 9 0 * #)
@param target_number {string} A phone number to redirect the caller to. All > 0 second timers will start when the call is answered.
@param target_cid {string} A campaign ID to redirect the caller to. The campaign must be configured in the system. If this value is set, it will overrride the target number. This option can be used to allow the caller to replay the greeting.

**Request**
~~~~
JSON
{
    "number": {
        "type": "Toll-free",
        "desired_text": "DEBUG",
        "afid": "0002",
        "cid": "0001",
        "sid": "superaffiliate"
    }
}
~~~~

**Response**
~~~~
JSON
{
   "number":{
      "id":79,
      "number":"+15558237206",
      "toll_free":true,
      "updated_at":"2012-07-15T03:15:42Z",
      "created_at":"2012-07-15T03:15:42Z",
      "sid":"superaffiliate",
      "afid":"0002",
      "cid":"0001",
      "uses_campaign_settings":true,
      "greeting":{
         "audio_file_name":"greeting.flac",
         "audio_file_content_type":"application/octet-stream",
         "audio_file_size":4990865,
         "audio_file_updated_at":"2012-07-15T01:30:34Z",
         "inherited":true
      },
      "timers":[
         {
            "timer":{
               "id":201,
               "seconds":0,
               "url":"http://callpixels.com.go2cloud.org/aff_c?offer_id=[campaign_id]&aff_id=[affiliate_id]&aff_sub=[sub_id]",
               "inherited":true
            }
         },
         {
            "timer":{
               "id":202,
               "seconds":90,
               "url":"http://callpixels.com.go2cloud.org/[has_offers_code]?adv_sub=[call_log_id]-[caller_id]-[called_number]-[call_duration]-[call_recording_url]",
               "inherited":true
            }
         }
      ],
      "menu_options":[
         {
            "menu_option":{
               "id":66,
               "option":"1",
               "target_cid":null,
               "target_number":"+18884899999",
               "inherited":true
            }
         },
         {
            "menu_option":{
               "id":71,
               "option":"2",
               "target_cid":"399944",
               "target_number":null,
               "inherited":true
            }
         }
      ]
   }
}
~~~~

# PUT /numbers/1.format

Updates number with the given ID.

**Resource URL**
@note http://callpixels.com/numbers/1.format

# DELETE /numbers/1.format

Deletes number with the given ID.

**Resource URL**
@note http://callpixels.com/numbers/1.format