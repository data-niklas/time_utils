# time_utils

Timers and intervalls

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     time_utils:
       github: data-niklas/time_utils
   ```

2. Run `shards install`

## Usage

```crystal
require "time_utils"
Timer.run(5.seconds) do |timer|
  puts "5 seconds"
end

timer2 = Timer.new(3.seconds) do |timer|
  puts Time.utc - timer.at
end
timer2.run
```

Javascript like methods are exposed

```
setTimeout(1000) do |timer|
  puts "1 second"
end
```

Recurring events:

```
Timer.run(5.seconds,true) do |timer|
  puts "Every 5 seconds"
end
```

TODO: Write usage instructions here

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/data-niklas/time_utils/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Niklas Loeser](https://github.com/data-niklas) - creator and maintainer
