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

  # populate_chars_cfs lib and its tests
  watch('lib/console_methods/populate_chars_cfs.rb') do
    'test/lib/console_methods/populate_chars_cfs_test.rb'
  end
  watch('test/lib/console_methods/populate_chars_cfs_test.rb') do
    'test/lib/console_methods/populate_chars_cfs_test.rb'
  end

  # translate_string lib and its tests
  watch('lib/console_methods/translate_string.rb') do
    'test/lib/console_methods/translate_string_test.rb'
  end
  watch('test/lib/console_methods/translate_string_test.rb') do
    'test/lib/console_methods/translate_string_test.rb'
  end

  # calculate_wcfbs lib and its tests
  watch('lib/console_methods/calculate_wcfbs.rb') do
    'test/lib/console_methods/calculate_wcfbs_test.rb'
  end
  watch('test/lib/console_methods/calculate_wcfbs_test.rb') do
    'test/lib/console_methods/calculate_wcfbs_test.rb'
  end

  # calculate_wcfts lib and its tests
  watch('lib/console_methods/calculate_wcfts.rb') do
    'test/lib/console_methods/calculate_wcfts_test.rb'
  end
  watch('test/lib/console_methods/calculate_wcfts_test.rb') do
    'test/lib/console_methods/calculate_wcfts_test.rb'
  end

  # calculate_wfs lib and its tests
  watch('lib/console_methods/calculate_wfs.rb') do
    'test/lib/console_methods/calculate_wfs_test.rb'
  end
  watch('test/lib/console_methods/calculate_wfs_test.rb') do
    'test/lib/console_methods/calculate_wfs_test.rb'
  end

  # calculate_wls lib and its tests
  watch('lib/console_methods/calculate_wls.rb') do
    'test/lib/console_methods/calculate_wls_test.rb'
  end
  watch('test/lib/console_methods/calculate_wls_test.rb') do
    'test/lib/console_methods/calculate_wls_test.rb'
  end

  # utilities lib and its test
  watch('lib/console_methods/utilities.rb') do
    'test/lib/console_methods/utilities_test.rb'
  end
  watch('test/lib/console_methods/utilities_test.rb') do
    'test/lib/console_methods/utilities_test.rb'
  end

  # Language model and its tests
  watch('app/models/language.rb') do 'test/models/language_test.rb' end
  watch('test/models/language_test.rb') do 'test/models/language_test.rb' end

  # Script model and its tests
  watch('app/models/script.rb') do 'test/models/script_test.rb' end
  watch('test/models/script_test.rb') do 'test/models/script_test.rb' end

  # Character model and its tests
  watch('app/models/character.rb') do 'test/models/character_test.rb' end
  watch('test/models/character_test.rb') do 'test/models/character_test.rb' end

  # Word model and its tests
  watch('app/models/word.rb') do 'test/models/word_test.rb' end
  watch('test/models/word_test.rb') do 'test/models/word_test.rb' end

  # Sentence model and its tests
  watch('app/models/sentence.rb') do 'test/models/sentence_test.rb' end
  watch('test/models/sentence_test.rb') do 'test/models/sentence_test.rb' end

  # Score model and its tests
  watch('app/models/score.rb') do 'test/models/score_test.rb' end
  watch('test/models/score_test.rb') do 'test/models/score_test.rb' end
end

guard :rubocop do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end
