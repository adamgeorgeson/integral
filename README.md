# Integral [![Gem Version](https://badge.fury.io/rb/integral.svg)][badge-fury] [![Build Status](https://travis-ci.org/patricklindsay/integral.svg?branch=master)][travis-ci] [![Code Climate](https://codeclimate.com/github/patricklindsay/integral/badges/gpa.svg)][code-climate] [![Dependency Status](https://gemnasium.com/patricklindsay/integral.svg)][gemnasium] [![Inline docs](http://inch-ci.org/github/patricklindsay/integral.svg?branch=master)][inch-ci] [![Error Tracking](https://d26gfdfi90p7cf.cloudfront.net/rollbar-badge.144534.o.png)][roll-bar]

## Website in a box
This engine packages together  all the tools and utilities integral for the foundation of any website.

Backend features include;
* Styled with [Material Design][material-design] in mind using [Materialize-sass][materialize]
* User authentication & authorization
* Page & Post management with full [WYSWIYG editing][ckeditor]
* Image management (w/ background image processing)
* List management
* Settings management
* Turbolinks 5

Frontend features include;
* Styled with [Foundation 6][foundation]
* SEO Ready
* Turbolinks 5

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'integral'
```

And then execute:

    $ bundle

    Or install it yourself as:

        $ gem install integral

## Usage

1. Mount Integral engine routes
 ```
  # config/routes.rb
  mount Integral::Engine, at: "/", as: 'integral'
 ```

2. Lock Ruby version to 2.3.1 or higher
```
  # Gemfile
  ruby '2.3.1'
```
3. Make sure you're app runs Integral seed data on setup
 ```
  # db/seeds.rb
  Integral::Engine.load_seed
 ```
4. The currently released version of carrierwave_backgrounder is nearly 2 years old. Hopefully a new version will be released soon, until then we have to point to master (or a fork). Add the following to your Gemfile:
```
  # Remove this when new gem version is released (< 0.4.2)
  gem 'carrierwave_backgrounder', git: 'git://github.com/lardawge/carrierwave_backgrounder.git'
```
5. Setup database - Copy and run necessary migrations
```
  rake integral:install:migrations
  rake db:migrate
  rake db:setup
```
6. Run Integral install rake task (adds configuration initializers)
```
rails generate integral:install
```
7. Install your preferred background task manager. If this is not [Delayed Job][delayed-job] you'll have to update the `carrierwave_backgrounder` config file
```
config/initializers/carrierwave_backgrounder.rb
```

## Heroku Setup
1. Install required buildpacks:
```
  1. heroku/ruby
  2. https://github.com/jayzes/heroku-buildpack-jpegoptim
  3. https://github.com/jayzes/heroku-buildpack-optipng
```
2. [Setup Puma Web Server][setup-puma]
3. Install [rails_12factor gem][rails-12-factor]

## Suggested Additional Setup
1. Install an error tracking management tool such as [Rollbar][roll-bar] or [HoneyBadger][honey-badger]
2. Install a performance monitoring tool such as [NewRelic][new-relic]

## WYSIWYG Editor
[CKeditor][ckeditor] is the visual editor used to create pages. If you would like to add/remove a plugin, edit the configuration or add your own styles create the following overriding files;
```
# JS Configuration - Override this to add plugins etc
app/assets/javascripts/ckeditor/my_config.js

# Stylesheet - Override this to edit the look of the WYIWYG output
app/assets/javascripts/ckeditor/my_contents.css

# StyleSet Configuration - Manages styles registration and loading
app/assets/javascripts/ckeditor/my_styles.js

```

## Useful Gems
* [Pry Rails][pry-rails] - Debugging
* [Letter Opener][letter-opener] - Preview emails rather than attempting to send them

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/patricklindsay/integral. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

### Future works
* Sitemap creation
* Super admin (able to view & undelete soft-deleted items)
* Improved image management
* Fully dynamic page routing (no restart required for Heroku)
* Backend Auditing (Who did what now?)
* Handle multi-user (Object Locking)
* Improved backend UI - Navigation should be at least partially visible on medium/large screens at all times
* Improved backend UI - Dashboard should contain stats and information

### Technical Debt
* Move list models into subfolder
* Tidy up implementation and create full specs for ListRenderer & ListItemRenderer
* Feature specs for all controller actions at the minimum checking for 200 status
* Add specs for frontend controllers
* Add specs for all configuration options
* All TODOs :)

##

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[material-design]: https://www.google.com/design/spec/material-design/introduction.html
[materialize]: https://github.com/mkhairi/materialize-sass
[roll-bar]: https://rollbar.com
[travis-ci]: https://travis-ci.org/patricklindsay/integral
[code-climate]: https://codeclimate.com/github/patricklindsay/integral
[inch-ci]: http://inch-ci.org/github/patricklindsay/integral
[gemnasium]: https://gemnasium.com/patricklindsay/integral
[foundation]: http://foundation.zurb.com/sites
[ckeditor]: http://ckeditor.com
[badge-fury]: https://badge.fury.io/rb/integral
[honey-badger]: https://www.honeybadger.io
[new-relic]: https://newrelic.com/ruby/rails
[setup-puma]: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server
[pry-rails]: https://github.com/rweng/pry-rails
[letter-opener]: https://github.com/ryanb/letter_opener
[rails-12-factor]: https://devcenter.heroku.com/articles/getting-started-with-rails4#heroku-gems
[ckeditor]: https://github.com/galetahub/ckeditor
[delayed-job]: https://github.com/collectiveidea/delayed_job
