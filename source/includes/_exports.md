# Exports

Exports generate a CSV of a large historical range in the background, so you're not paginating thousands of rows yourself. The flow is always the same three steps: create the export, poll it until it's finished, then download the file from the URL the export gives you.

Currently the only export type exposed here is `rtb_inbounds`. For Calls, there's no async export yet — page through [`/api/v5/calls`](#paginated) directly (see the [Script Example](#script-example-exporting-recently-created-calls-via-retreaver-api) for a working pagination loop).

## Create an export

~~~shell
curl -X POST "https://api.retreaver.com/api/v5/exports/rtb_inbounds.json?api_key=woofwoofwoof" \
  -H "Content-Type: application/json" \
  -d '{
        "export": {
          "format": "csv",
          "params": { "campaign_id": [123], "created_at": "last_7d" }
        }
      }'
~~~

> The above command returns JSON structured like this:

~~~json
{
  "id": 501,
  "export_count": null,
  "export_progress": 0,
  "export_percentage": 0.0,
  "format": "csv",
  "file_upload_url": null,
  "in_progress": true,
  "errors": {}
}
~~~

### HTTP Request

`POST https://api.retreaver.com/api/v5/exports/rtb_inbounds.json?api_key=woofwoofwoof`

`Content-Type: application/json`

### Parameters

Parameter | Type | Required | Description
--------- | ---- | -------- | -----------
format | string | No | Only `csv` is supported today; it's the default if omitted.
params | object | Yes | The filter to export — same filter keys as [RtbInbounds](#rtbinbounds)'s query parameters (`campaign_id`, `affiliate_id`, `target_id`, `caller_state`, `status`, etc, as plain values or arrays), plus one of `created_at` (a relative token like `last_7d`) or `created_at_start`/`created_at_end`. The window is capped at 2 months, same as the live log.

## Check an export's status

~~~shell
curl "https://api.retreaver.com/api/v5/exports/rtb_inbounds/501.json?api_key=woofwoofwoof"
~~~

> While it's still generating:

~~~json
{
  "id": 501,
  "export_count": null,
  "export_progress": 0,
  "export_percentage": 0.0,
  "format": "csv",
  "file_upload_url": null,
  "in_progress": true,
  "errors": {}
}
~~~

> Once it's finished:

~~~json
{
  "id": 501,
  "export_count": 168,
  "export_progress": 168,
  "export_percentage": 100.0,
  "format": "csv",
  "file_upload_url": "/v2/reports/rtb_inbounds/501/download",
  "in_progress": false,
  "errors": {}
}
~~~

### HTTP Request

`GET https://api.retreaver.com/api/v5/exports/rtb_inbounds/:id.json?api_key=woofwoofwoof`

Poll this until `in_progress` is `false` — `export_count` stays `null` and `export_progress`/`export_percentage` stay at `0` for the whole run; there's no partial progress to report while an export is generating.

### Response fields

Field | Description
----- | -----------
export_count | `null` while generating. Once `in_progress` is `false`, the number of rows in your export.
export_progress | `0` while generating. Once `in_progress` is `false`, the same as `export_count`.
export_percentage | `0.0` while generating; `100.0` once `in_progress` is `false`.
in_progress | `true` while generating; `false` once finished (or failed — check `errors`).
file_upload_url | The path to download the finished file from, relative to `https://api.retreaver.com` (e.g. `/v2/reports/rtb_inbounds/501/download`) — not a full URL. `null` until the export is done.
errors | Populated if the export request itself was invalid (e.g. a bad `params` filter).

## Download the export

Once `in_progress` is `false`, prepend `https://api.retreaver.com` to the `file_upload_url` from the previous response — don't construct the path yourself, only prepend the host, since it isn't under `/api/v5/`. It's still authenticated the same way (`api_key`) and redirects to the actual file:

~~~shell
curl -L -o rtb_inbounds.csv.gz \
  "https://api.retreaver.com/v2/reports/rtb_inbounds/501/download?api_key=woofwoofwoof"
gunzip rtb_inbounds.csv.gz
~~~

<aside class="notice">
The file is always gzip-compressed, whatever the export's <code>format</code> — decompress it before reading (<code>gunzip</code>, or <code>Zlib::GzipReader</code> / your language's equivalent, as in the merge example below).
</aside>

## Script Example: Downloading an RTB Inbounds export

Creates an export, polls it, downloads it, and decompresses it to a date-ranged CSV file — the scriptable version of the three steps above. When it finishes, you're left with one file in the current directory, named `rtb_inbounds_<start>-<end>.csv` (e.g. `rtb_inbounds_20260908-20260915.csv`).

~~~ruby
# How to run:
#   1. Save this script to a file, e.g. download_rtb_inbounds.rb
#   2. Edit API_KEY below
#   3. Run: ruby download_rtb_inbounds.rb
#   4. You'll end up with one result file in the current directory, named
#      rtb_inbounds_<start>-<end>.csv (e.g. rtb_inbounds_20260908-20260915.csv)

require 'net/http'
require 'uri'
require 'json'
require 'time'
require 'zlib'
require 'stringio'

API_KEY = "woofwoofwoof"
BASE_URL = "https://api.retreaver.com"

# The download itself is a redirect (302) to the actual file, not the file itself —
# Net::HTTP doesn't follow redirects on its own.
def http_get_following_redirects(uri, limit = 5)
  raise "too many redirects" if limit == 0

  response = Net::HTTP.get_response(uri)
  response.is_a?(Net::HTTPRedirection) ? http_get_following_redirects(URI.parse(response['location']), limit - 1) : response
end

# Create + poll + download an RTB Inbounds export, saving the decompressed CSV to `path`.
def fetch_rtb_inbounds_csv(created_at_start:, created_at_end:, path:)
  puts "Creating RTB Inbounds export..."
  create_uri = URI.parse("#{BASE_URL}/api/v5/exports/rtb_inbounds.json?api_key=#{API_KEY}")
  create_body = { export: { format: "csv", params: { created_at_start: created_at_start, created_at_end: created_at_end } } }
  export = JSON.parse(Net::HTTP.post(create_uri, create_body.to_json, "Content-Type" => "application/json").body)
  puts "  export id=#{export['id']} created, polling until it's done..."

  show_uri = URI.parse("#{BASE_URL}/api/v5/exports/rtb_inbounds/#{export['id']}.json?api_key=#{API_KEY}")
  loop do
    sleep 2
    export = JSON.parse(Net::HTTP.get_response(show_uri).body)
    # export_progress/export_count don't report partial progress — poll on in_progress itself.
    puts "  in_progress=#{export['in_progress']}..."
    break unless export['in_progress']
  end

  # file_upload_url is a path (e.g. "/v2/reports/rtb_inbounds/501/download"), not a full URL — prepend BASE_URL.
  puts "Downloading export from #{export['file_upload_url']}..."
  download_uri = URI.parse("#{BASE_URL}#{export['file_upload_url']}?api_key=#{API_KEY}")
  response = http_get_following_redirects(download_uri)
  puts "  downloaded #{response.body.bytesize} gzip-compressed bytes."

  # The export is always written gzip-compressed — decompress before use.
  csv_text = Zlib::GzipReader.new(StringIO.new(response.body)).read
  File.write(path, csv_text)
  puts "  saved #{csv_text.bytesize} bytes (decompressed) to #{path}"

  path
end

created_at_start = (Time.now - 7 * 24 * 3600).utc
created_at_end = Time.now.utc
date_range = "#{created_at_start.strftime('%Y%m%d')}-#{created_at_end.strftime('%Y%m%d')}"

puts "About to export RTB Inbounds created between #{created_at_start.iso8601} and #{created_at_end.iso8601}"
puts "  using api_key=#{API_KEY}"
print "Press Enter to continue, or Ctrl+C to cancel... "
STDIN.gets

rtb_inbounds_csv_path = fetch_rtb_inbounds_csv(
  created_at_start: created_at_start.iso8601,
  created_at_end: created_at_end.iso8601,
  path: "rtb_inbounds_#{date_range}.csv",
)

puts "\nDone! RTB Inbounds saved to #{File.expand_path(rtb_inbounds_csv_path)}"
~~~

## Example: merging Calls and RTB Inbounds by call_uuid

RTB Inbounds rows carry a `call_uuid` for the Call each reservation belongs to, so you can enrich an export with Call data (or vice versa) by joining on that field. This doesn't fetch either dataset itself — it takes the two files already produced elsewhere on this page and joins them:

- a Calls JSON file, e.g. `calls_20260225T160831Z-20260225T180831Z.json` from the [Script Example](#script-example-exporting-recently-created-calls-via-retreaver-api) in the Introduction.
- an RTB Inbounds CSV file, e.g. `rtb_inbounds_20260908-20260915.csv` from the [Script Example: Downloading an RTB Inbounds export](#script-example-downloading-an-rtb-inbounds-export) above.

The join below is a **full outer join**, keyed on `call_uuid`: every RTB Inbounds row is included even when it has no matching Call (e.g. a `rejected` or `no-target` ping never created one), and every Call is included even when no RTB Inbounds row references it (e.g. it wasn't reserved through RTB at all). The unmatched side is simply left blank rather than the row being dropped. Columns are ordered RTB Inbounds columns first, then Call columns.

~~~ruby
# How to run:
#   ruby merge_calls_with_rtb_inbounds.rb <calls.json> <rtb_inbounds.csv>
#
# calls.json       — from the Script Example in the Introduction
# rtb_inbounds.csv — from the Script Example: Downloading an RTB Inbounds export, above

require 'json'
require 'csv'

calls_path, rtb_inbounds_csv_path = ARGV
if calls_path.nil? || rtb_inbounds_csv_path.nil?
  abort "Usage: ruby #{$PROGRAM_NAME} <calls.json> <rtb_inbounds.csv>"
end

all_calls = JSON.parse(File.read(calls_path))
rtb_inbounds = CSV.read(rtb_inbounds_csv_path, headers: true)
calls_by_uuid = all_calls.each_with_object({}) { |call, h| h[call["uuid"]] = call }

# A Call field can be an array/hash (downstream_call_uuids, target_group, ...) — flatten those to a
# JSON string so they round-trip through a single CSV cell.
def csv_value(value)
  value.is_a?(Array) || value.is_a?(Hash) ? value.to_json : value
end

# RTB Inbounds columns first, then one column per key found across all_calls' own JSON keys.
rtb_headers = rtb_inbounds.headers || []
call_headers = all_calls.flat_map(&:keys).uniq
matched_call_uuids = {}
written = 0

puts "Merging #{rtb_inbounds.length} RTB Inbounds rows with #{all_calls.length} calls by call_uuid..."

CSV.open("calls_with_rtb_inbounds.csv", "w") do |out|
  out << rtb_headers + call_headers

  rtb_inbounds.each do |row|
    call = calls_by_uuid[row["Call UUID"]]
    matched_call_uuids[row["Call UUID"]] = true if call

    out << rtb_headers.map { |h| row[h] } + call_headers.map { |h| call && csv_value(call[h]) }
    written += 1
  end

  all_calls.each do |call|
    next if matched_call_uuids[call["uuid"]]

    out << rtb_headers.map { nil } + call_headers.map { |h| csv_value(call[h]) }
    written += 1
  end
end

puts "Wrote #{written} rows (#{rtb_inbounds.length} from RTB Inbounds, #{written - rtb_inbounds.length} Calls with no RTB Inbounds row) to calls_with_rtb_inbounds.csv."
~~~

<aside class="notice">
The RTB Inbounds CSV headers are human-readable labels (e.g. <code>Call UUID</code>, <code>Status</code>), not the JSON field names (<code>call_uuid</code>, <code>status</code>) — the <a href="#rtbinbounds">RtbInbounds</a> JSON endpoint uses the plain field names shown there. Calls have no such relabeling: each Call's own JSON keys (<code>uuid</code>, <code>status</code>, ...) are used as-is for its columns.
</aside>
