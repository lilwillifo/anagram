# README

# Anagram Finder

An API to find anagrams for a given set of text. Users can pass in a string to find all its anagrams in the dictionary. The search functionality does not discriminate on whether the text entered is a real word or not. So, this is a great way to cheat at Scrabble, if no one notices you making API calls during the game...

# Implementation details

The goal for this API is to return anagrams for any word (or set of characters) as quickly as possible.
The seed file digests a text file of every word in the English language, so the results of anagrams for any text are available. Note that a word is not considered to be its own anagram.

This API is built in Ruby, utilizing Rails to render JSON data at each end point.

# Design overview and trade-offs considered

## Sinatra vs. Rails

Rails is a fully featured MVC framework, and potentially overkill. The decision to use Rails instead of Sinatra was intentional. I debated this before starting, and my understanding is most of Ibotta's codebase is in Rails, so I wanted to showcase my knowledge in this framework. Adding the --api flag makes the app more lightweight. Additionally, I wanted to get to the meat of the project right away, rather than manually building the environment, tests and database configuration that Rails packages for me. I didn't see a need to reinvent the wheel here.

## Data Structure

There are two tables - words and anagrams. Words belong to anagrams. Anagram has a key, which is the alphabetized version of the anagrams (e.g. `dear`, `read`, and `dare` all have the key -- `ader`). An anagram key has many words. This allows for quicker searching, rather than loading the entire dictionary every time you want to check for anagrams. It also makes for DRY, readable code!

My focus here was on the user. The user wants an instantaneous result. I played around with  a word model that had a method to pull all anagrams for each word, but this was very inefficient. Every time a word was added or deleted, the entire hash was being rebuilt. Not good! By seeding the database with the entire dictionary into an anagrams table with key(of sorted string) and words attributes, queries to the API are nearly instant.

## Testing

I use testing to drive my implementation. I wrote RSpec tests to confirm happy path and used model testing for more detail. I added sad path testing where I thought there was a high probability of the issue happening, but there is always room to add to sad path testing. I tried to catch likely edge cases. A few that come to mind are a user trying to delete a word that does not exist, a user looking for anagrams for a word that has none. I did not test for a case of a user passing in other datatypes rather than a string for the dictionary, as it seemed unlikely.

# Creating this in your local environment

## Set Up, Testing

1. Run `bundle` to install the dependencies
2. `rake db:create`, `rake db:migrate` and (optionally) `rake db:seed`. Note that seeding the entire dictionary will take a long time. This seed file gives you the opportunity to take a well-deserved pomodoro break while it runs! It runs before users interact with the site, so end users wouldn't feel the long load time. The tests of the API functionality will work with or without the seeding. Interacting with the API will be more fun once seeded though!
3. `rails s` will serve up the API at `localhost:3000`. You'll need this running to make requests.
4. `ruby test/anagram_test.rb` to run Ibotta's test suite. `rspec` will run the tests I created.

# Interacting with the API

For get requests, you can pull up localhost:3000/anagrams/:word to find anagrams. For post and delete, you'll need to use your favorite tool to post HTTP requests to the API (I like [Postman](https://www.getpostman.com/)).

- `POST /words.json`: Takes a JSON array of English-language words and adds them to the corpus (data store). Notably, there is no check that the word is in the dictionary. This is the wild, wild west. Post `lol`, `omg`, or even `alksjdghkwjerh` to the data store. Whatever makes you happy.
- `GET /anagrams/:word.json`:
  - Returns a JSON array of English-language words that are anagrams of the word passed in the URL. (One caveat: if you've posted fake words.... you'll then see that in your results. Seems fair.)
  - This endpoint supports an optional query param (LIMIT) that indicates the maximum number of results to return. Push it to the limit!
- `DELETE /words/:word.json`: Deletes a single word from the data store. Adios!
- `DELETE /words.json`: Deletes all contents of the data store. Delete all the things!

Example:

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

# Fetch analytics on the words in the data store.
$ curl -i http://localhost:3000/anagrams/analytics.json
HTTP/1.1
```

# Features to add to the API

I'd like to add the ability to add anagrams with multiple words. Some of my favorite anagrams are those for multiple words, like `Clint Eastwood` and `Old West Action`, `dormitory` and `dirty room`, or `the morse code` and `here come dots`. Also, although it is not quite an anagram, I found myself curious about what shorter words could be made from a string. Creating another endpoint `/sub-words/:word` to return all words created from the larger word. This could be implemented by iterating through and checking combinations of the characters against the dictionary. This would up your Scrabble game even more!
