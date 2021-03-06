# Pipe

Pipedrive API ruby implementation. 

WIP

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pipe', git: 'https://github.com/vklokov/pipe', branch: 'master'
```

And then execute:

    $ bundle install
    
## Configure (since v.0.2.0)

```ruby
Pipe.configure do |c|
  c.api_token = 'your-pipedrive-api-token'
  c.schema = 'your-custom-fields-schema' # for example: YAML.load_file(File.join('path', 'to', 'schema.yml'))
end
```

Schema definition:

```yml
production:
  filters:
    custom_filter_name: id
  deal:
    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx: custom_field_name
  person:
    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx: custom_field_name
  organization:
    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx: custom_field_name
```

## Usage

Find an resource
```ruby
Pipe::Person.find(100) # => <Pipe::Person @id=31 @name=Example name @email=example@gmail.com>
Pipe::Deal.find(100)
Pipe::Organization.find(100)
```

Update
```ruby
Pipe::Person.update(id, name: 'Example name') 
```

Deal files
```ruby
Pipe::Deal.find(100).files # => [<Pipe::File @id=1 @name=file.txt @url='file-download-url'>]
```
or you can do the same from Pipe::File directly
```ruby
Pipe::File.find_all_deal_files(100)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/pipe. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Pipe project???s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/pipe/blob/master/CODE_OF_CONDUCT.md).
