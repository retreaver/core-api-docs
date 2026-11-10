#!/usr/bin/env ruby
# Checks data/redirects.yml against the built page and against learn.retreaver.com.
#
#   bundle exec middleman build && ruby scripts/verify_redirects.rb
#
# Fails when a heading on the old page has no entry, when a target page does not
# return 200, or when a target #fragment is not an id on that page.
require 'yaml'
require 'net/http'
require 'uri'

BASE = 'https://learn.retreaver.com/api'
map = YAML.load_file(File.expand_path('../data/redirects.yml', __dir__))
built = File.read(File.expand_path('../build/index.html', __dir__))
errors = []

built.scan(/<h[123] id="([^"]+)"/).flatten.uniq.each do |id|
  errors << "no entry for ##{id}" unless map.key?(id)
end

pages = Hash.new do |h, path|
  res = Net::HTTP.get_response(URI("#{BASE}#{path}"))
  h[path] = res.code == '200' ? res.body.scan(/\bid="([^"]+)"/).flatten.to_set : res.code
end

map.each do |old, target|
  path, fragment = target.split('#', 2)
  ids = pages[path]
  if ids.is_a?(String)
    errors << "##{old} -> #{target}: #{BASE}#{path} returned #{ids}"
  elsif fragment && !ids.include?(fragment)
    errors << "##{old} -> #{target}: no id=\"#{fragment}\" on #{BASE}#{path}"
  end
end

puts "#{map.size} anchors, #{pages.size} pages checked"
abort(errors.map { |e| "  #{e}" }.join("\n")) if errors.any?
puts 'OK'
