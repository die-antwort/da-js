# da-js – Collection of small, useful JavaScripts
This are some JavaScripts we use in most of our projects. So packaged them into a gem.

Okay, right now it’s only one, small JavaScript. But just be patient … 
 
## Installation
da-js is meant to be used with Ruby on Rails 3.1 or newer. It's based on [jQuery](http://jquery.com), so be sure you are using [jquery-rails](https://github.com/rails/jquery-rails), too (__jQuery version 1.7.1 or newer is required__).

To install it:

* Add the gem to your `Gemfile`:
      
        gem "da-js"
    
* Require the library in your `application.js` (after requiring jQuery):
    
        require "da-js"
    
## Documentation
For documentation please refer to the individual files in `lib/assets/javascripts/da-js`.

## Development
Use the Rack application in `features/support/testapp`:

    rackup features/support/testapp/config.ru
    
Any template file in `features/support/testapp/views` can be accessed by its basename:
    
    open http:://localhost:9292/form_change_tracker
    
Run the tests with
    rake test