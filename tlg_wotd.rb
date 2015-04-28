#!/Users/wm/.rbenv/shims/ruby

require 'http'
require 'json'
require 'htmlentities'
require 'twitter'

client = Twitter::REST::Client.new do |config|
  config.consumer_key = 'XXbxNBt1fty6C2ZWXanaFyzly'
  config.consumer_secret = 'LZ5HCjHlxOn6DacJWKABl43PADPdI6Hw1p7QcYMX0JtfCN705w'
  config.access_token = '3171027360-JoTtCAudsy4YEnzHfQVif1DlwQsImffcuaOyJD0'
  config.access_token_secret = 'wwTm5AFwKo4GmIRZlh7N0rQF6VHd6o35KDENC840S5WUQ'
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