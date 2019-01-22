# Visual regression framework
A mix between our previous tests framework and a screenshot comparison feature
## Explanation
Box A - reference screenshot
Box B - test screenshot
Box C - diff highlights screenshot
The tool compares a png screenshot (Box A) with another png screenshot (Box B)
Internally it goes to every pixel and checks if pixel (x,y) Box A is a perfect match to pixel (x,y) on Box B
If it is, it copies the pixel (x,y) to the Box C
If no changes were found, it just ignores Box C creation as there's no point because Box A and Box B are equal
If changes were found, it saves every different pixel as "dark red" colour on Box C and saves the image in different_images folder

## Environment Setup
ruby version:
  ```
  > ruby -v
  ruby 2.4.1p111 (2017-03-22 revision 58053)
  ```

installing gems:
  ```
	bundle install
  ```
## Test execution

To run the tests to generate the reference images(Creating Box A):
```
  bundle exec cucumber features/ ENV_CONFIG=live TYPE=reference
```

To run the tests to generate the reference images(Creating Box B) and assertions:
```
  bundle exec cucumber features/ ENV_CONFIG=live TYPE=test
```

### Environment Variables

* **ENV_CONFIG** - can be one of these values [air, water, earth, fire, pre-prod], refer /config.yml for environment details
* **BROWSER** - default as headless chrome
* **TYPE** - defines the type of test [reference, test]

### Note
We should submit and update the reference images whenever we have expected layout changes

An error occurred while installing mysql2 (0.5.2), and Bundler cannot continue.
Make sure that `gem install mysql2 -v '0.5.2' --source 'http://rubygems.org/'` succeeds before bundling.
```
brew install mysql
```
