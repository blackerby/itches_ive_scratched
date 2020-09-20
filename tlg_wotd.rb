#!/Users/wm/.rbenv/shims/ruby

require 'http'
require 'json'
require 'htmlentities'
require 'twitter'

client = Twitter::REST::Client.new do |config|
  config.consumer_key = 'secret'
  config.consumer_secret = 'secret'
  config.access_token = 'secret'
  config.access_token_secret = 'secret'
end

coder = HTMLEntities.new
json = HTTP.get('http://stephanus.tlg.uci.edu/Iris/Wotd')
data = JSON.parse(json)

data["word"] = coder.decode(data["word"])

tweet = "#{data['word']}: #{data['definition']}\n\n" \
        "First attested in #{data['firstOccurrence']} " \
        "Occurs #{data['totalOccurrences']} time(s) " \
        "in Thesaurus Linguae Graecae."

if tweet.length > 140
  tweet.sub!("Thesaurus Linguae Graecae", "TLG")
  tweet.sub!("First", "1st")
  tweet.gsub!(".", '')
end

client.update(tweet)
