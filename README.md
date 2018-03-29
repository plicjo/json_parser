# JSON Test Run Parser

## Running the tests
```
git clone https://github.com/plicjo/json_parser.git
bundle
rails db:create && rails db:migrate
rspec
```

## Testing JSON response with Curl
```
rails server
curl -H "Content-Type: application/json" --data @spec/fixtures/test_run_payload.json http://localhost:3000/test_runs
```

Cheers :D
