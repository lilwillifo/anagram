# README
<!-- - Limits on the length of words that can be stored or limits on the number of results that will be returned
- Any edge cases you find while working on the project -->

# Anagram Finder

An API to find anagrams for a given set of text. Users can pass in a characters in parameters to find all its anagrams in the dictionary. The search functionality does not discriminate on whether the text entered is a word or not. A perfect way to cheat at Scrabble, if no one notices you making API calls during the game...

# Implementation details

The goal for this API is to return anagrams for any word (or set of characters) as quickly as possible.
The database digests a text file of every word in the English language, so the results of anagrams for any text are available.

This API is built in Ruby, utilizing Rails to render JSON data at each end point.

Note that a word is not considered to be its own anagram. I chose to implement that anagrams should be returned alphabetically. This provides a streamlined user experience for reading through results. It is how they would expect to see results.

# Design overview and trade-offs considered

## Sinatra vs. Rails

The decision to use Rails instead of Sinatra was intentional. Rails is a fully featured MVC framework, and potentially overkill. I debated this before starting, and my understanding is most of Ibotta's codebase is in Rails, so I wanted to showcase my knowledge in this framework. Adding the --api flag makes the app a bit more lightweight. Additionally, I wanted to get to the meat of the project right away, rather than manually building the environment, tests and database configuration that Rails packages for me. I didn't see a need to reinvent the wheel here.

## Postgres

My focus here was on the user. The user wants an instantaneous result. I played around with  a word model that had a method to pull all anagrams for each word, but this was very inefficient. Every time a word was added or deleted, the entire hash was being rebuilt. Not good! By seeding the database with the entire dictionary into an anagrams table with key and words attributes, queries to the API are nearly instant.

## Data Structure

For speed, anagrams are stored in a hash. The keys consist of words (lowercase) alphabetized by letter. So `read`'s key would be `ader`. The value of the hash is an array of all anagrams in the dictionary. So notably, the keys themselves don't have to be words in the dictionary (and likely aren't), but the values consist only of words in the dictionary.

## Testing

I use testing to drive my implementation. I wrote RSpec tests to confirm happy path and used model testing for more detail. I added sad path testing where I thought there was a high probability of the issue happening, but there is always room to add to sad path testing. I tried to catch likely edge cases.

# Creating this in your local environment

## Set Up, Testing

1. Run `bundle` to install the dependencies
2. `rake db:create`, `rake db:migrate` and (optionally) `rake db:seed`. Note that seeding the entire dictionary will take a very long time. It's there with the intent to run in production, which would run before users interact with the site and they wouldn't feel the long load time. The tests of the API functionality will work with or without the seeding. Interacting with the API will be more fun once seeded though!
3. `rails s` will serve up the API at `localhost:3000`.
4. `ruby test/anagram_test.rb` to run Ibotta's test suite.

# Interacting with the API

Example (assuming the API is being served on localhost port 3000):

```{bash}
# Adding words to the corpus
$ curl -i -X POST -d '{ "words": ["read", "dear", "dare"] }' http://localhost:3000/words.json
HTTP/1.1 201 Created
...

# Fetching anagrams
$ curl -i http://localhost:3000/anagrams/read.json
HTTP/1.1 200 OK
...
{
  anagrams: [
    "dear",
    "dare"
  ]
}

# Specifying maximum number of anagrams
$ curl -i http://localhost:3000/anagrams/read.json?limit=1
HTTP/1.1 200 OK
...
{
  anagrams: [
    "dare"
  ]
}

# Delete single word
$ curl -i -X DELETE http://localhost:3000/words/read.json
HTTP/1.1 204 No Content
...

# Delete all words
$ curl -i -X DELETE http://localhost:3000/words.json
HTTP/1.1 204 No Content
...
```

# Features to add to the API

I'd like to add the ability to add anagrams with multiple words. Some of my favorite anagrams are those for multiple words, like `Clint Eastwood` and `Old West Action`, `dormitory` and `dirty room`, or `the morse code` and `here come dots`.
