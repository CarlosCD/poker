## Poker Ruby Exercise

Write a program where you have a deck of 52 playing cards (ace, 2-10, jack, queen, and king, in four suits). Shuffle the deck and draw five cards. Check to see if the five cards match one of the typical scoring poker hands:

<https://en.wikipedia.org/wiki/List_of_poker_hands>

and print out the cards that were drawn and the best type of scoring hand it matches.  No need to support all of the different hands, just a few of the important ones (one pair, two pair, full house, three of a kind, straight, etc.).

### Usage

- A very basic test can be run using the run.rb script. It generates a deck, shuffles it, extracts a hand, and identifies the matching poker hand with higher score.
- Some ideas of other tests are included in the other_examples.rb file.

### Tests

- For testing purposes it includes a Gemfile.  Install the needed gem (just RSpec) by running:

        bundle

- The ruby and rvm directives in the Gemfile require a recent version of bundler (like, for example, 1.3.5), but those lines could be removed without any consequences, for example if rbenv or chruby are used, or a 1.9.X ruby is preferred.

- Running the tests: just execute the <tt>rspec</tt> command. The tests are within the <tt>specs</tt> folder.


### Other notes

Even if it assumes Ruby 2.0.0-p247 and I used RVM (gemset name: general), it should work well in ruby 1.9.X (I tested it also with 1.9.3-p448).

After a shuffle always deals the first 5 cards of the deck.

If there is a need to deal more than one hand, then the PokerDeck class should be redesigned. Some possibilities would be:
- Keep a pointer with the next extracting position in the PokerDeck object, or
- The dealt cards could be popped out (@deck.pop(5)), and maybe a list of popped cards should be kept as part of the object state...

November 2013
