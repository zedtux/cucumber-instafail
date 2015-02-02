# Cucumber::Instafail

Show failing features instantly. Show passing spec as green dots as usual.
Highly inspired from
[rspec-instafail](https://github.com/grosser/rspec-instafail) from
[grosser](https://github.com/grosser).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cucumber-instafail'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cucumber-instafail

## Usage

In order to use cucumber-instafail add the following flag to the cucumber
command line:

    --format Cucumber::Instafail

## Output

Here is an example of output:

    .................F(::) failed steps (::)

    expected xpath ".//td[contains(@class, 'internal_reference')]" with text "Reference K" to return something (Spec::Expectations::ExpectationNotMetError)
    ./features/notifications/step_definitions/process_steps.rb:294
    ./vendor/cache/capybara-1f7b8bcb5c0b/lib/capybara/session.rb:192:in `within'
    ./vendor/cache/capybara-1f7b8bcb5c0b/lib/capybara/dsl.rb:161:in `within'
    ./features/notifications/step_definitions/process_steps.rb:293
    ./features/notifications/step_definitions/process_steps.rb:292:in `each'
    ./features/notifications/step_definitions/process_steps.rb:292:in `/^I should see the following notifications processes:$/'
    features/notifications/processes/home_country_filing_dashboard.feature:152:in `Then I should see the following notifications processes:'

    --....................

## Contributing

1. Fork it ( https://github.com/zedtux/cucumber-instafail/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
