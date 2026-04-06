# spec/support/database_cleaner.rb
#
# WHY: Tests write to the database. Without cleanup, test data bleeds between
# tests, causing false positives or test order-dependent failures (flaky tests).
#
# DatabaseCleaner wraps each test in a TRANSACTION (ultra-fast) and rolls it
# back at the end, leaving the DB pristine for the next test.
#
# :truncation is used for the initial clean (before the suite) because
# transactions don't work before a transaction begins.

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
