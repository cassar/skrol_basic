# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec features) \
#  .select{|d| Dir.exists?(d) ? d : UI.warning("Directory #{d} does not exist")}

## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), then you will want to move
## the Guardfile to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"

guard :bundler do
  require 'guard/bundler'
  require 'guard/bundler/verify'
  helper = Guard::Bundler::Verify.new

  files = ['Gemfile']
  files += Dir['*.gemspec'] if files.any? { |f| helper.uses_gemspec?(f) }

  # Assume files are symlinked from somewhere
  files.each { |file| watch(helper.real_path(file)) }
end

guard "minitest", spring: "bin/rails test", all_on_start: false do
  # with Minitest::Unit
  watch(%r{^test/(.*)\/?test_(.*)\.rb$})
  watch(%r{^lib/(.*/)?([^/]+)\.rb$})     { |m| "test/#{m[1]}test_#{m[2]}.rb" }
  watch(%r{^test/test_helper\.rb$})      { 'test' }

  # tests files in lib/_
  watch(%r{^lib/(.+)\.rb}) { |m| "test/lib/#{m[1]}_test.rb" }
  watch(%r{^test/lib/(.+)_test\.rb}) { |m| "test/lib/#{m[1]}_test.rb" }

  # tests files in lib/_/_
  watch(%r{^lib/(.+)/(.+)\.rb}) { |m| "test/lib/#{m[1]}/#{m[2]}_test.rb" }
  watch(%r{^test/lib/(.+)/(.+)_test\.rb}) do |m|
    "test/lib/#{m[1]}/#{m[2]}_test.rb"
  end

  # tests files in app/models/_
  watch(%r{^app/models/(.+)\.rb}) { |m| "test/models/#{m[1]}_test.rb" }
  watch(%r{^test/models/(.+)_test\.rb}) { |m| "test/models/#{m[1]}_test.rb" }

  # tests files in app/controllers/_
  watch(%r{^app/controllers/(.+)\.rb}) do |m|
    "test/controllers/#{m[1]}_test.rb"
  end
  watch(%r{^test/controllers/(.+)_test\.rb}) do |m|
    "test/controllers/#{m[1]}_test.rb"
  end
end

guard :rubocop do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end
