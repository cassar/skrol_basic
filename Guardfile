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

  # compile_chars_cfs lib and its tests
  watch('lib/console_methods_script/compile_chars_cfs.rb') do
    'test/lib/console_methods_script/compile_chars_cfs_test.rb'
  end
  watch('test/lib/console_methods_script/compile_chars_cfs_test.rb') do
    'test/lib/console_methods_script/compile_chars_cfs_test.rb'
  end

  # translate_string lib and its tests
  watch('lib/translate_string.rb') { 'test/lib/translate_string_test.rb' }
  watch('test/lib/translate_string_test.rb') do
    'test/lib/translate_string_test.rb'
  end

  # calculate_wcfbs lib and its tests
  watch('lib/console_methods_single/calculate_wcfbs.rb') do
    'test/lib/console_methods_single/calculate_wcfbs_test.rb'
  end
  watch('test/lib/console_methods_single/calculate_wcfbs_test.rb') do
    'test/lib/console_methods_single/calculate_wcfbs_test.rb'
  end

  # calculate_wcfts lib and its tests
  watch('lib/console_methods_single/calculate_wcfts.rb') do
    'test/lib/console_methods_single/calculate_wcfts_test.rb'
  end
  watch('test/lib/console_methods_single/calculate_wcfts_test.rb') do
    'test/lib/console_methods_single/calculate_wcfts_test.rb'
  end

  # calculate_wfs lib and its tests
  watch('lib/console_methods_single/calculate_wfs.rb') do
    'test/lib/console_methods_single/calculate_wfs_test.rb'
  end
  watch('test/lib/console_methods_single/calculate_wfs_test.rb') do
    'test/lib/console_methods_single/calculate_wfs_test.rb'
  end

  # compile_wfs_script lib and its tests
  watch('lib/console_methods_script/compile_wfs_script.rb') do
    'test/lib/console_methods_script/compile_wfs_script_test.rb'
  end
  watch('test/lib/console_methods_script/compile_wfs_script_test.rb') do
    'test/lib/console_methods_script/compile_wfs_script_test.rb'
  end

  # compile_wls_script lib and its tests
  watch('lib/console_methods_script/compile_wls_script.rb') do
    'test/lib/console_methods_script/compile_wls_script_test.rb'
  end
  watch('test/lib/console_methods_script/compile_wls_script_test.rb') do
    'test/lib/console_methods_script/compile_wls_script_test.rb'
  end

  # calculate_wls lib and its tests
  watch('lib/console_methods_single/calculate_wls.rb') do
    'test/lib/console_methods_single/calculate_wls_test.rb'
  end
  watch('test/lib/console_methods_single/calculate_wls_test.rb') do
    'test/lib/console_methods_single/calculate_wls_test.rb'
  end

  # calculate_wss lib and its tests
  watch('lib/console_methods_single/calculate_wss.rb') do
    'test/lib/console_methods_single/calculate_wss_test.rb'
  end
  watch('test/lib/console_methods_single/calculate_wss_test.rb') do
    'test/lib/console_methods_single/calculate_wss_test.rb'
  end

  # calculate_wts lib and its tests
  watch('lib/console_methods_single/calculate_wts.rb') do
    'test/lib/console_methods_single/calculate_wts_test.rb'
  end
  watch('test/lib/console_methods_single/calculate_wts_test.rb') do
    'test/lib/console_methods_single/calculate_wts_test.rb'
  end

  # calculate_swls lib and its tests
  watch('lib/console_methods_single/calculate_swls.rb') do
    'test/lib/console_methods_single/calculate_swls_test.rb'
  end
  watch('test/lib/console_methods_single/calculate_swls_test.rb') do
    'test/lib/console_methods_single/calculate_swls_test.rb'
  end

  # calculate_scwts lib and its tests
  watch('lib/console_methods_single/calculate_scwts.rb') do
    'test/lib/console_methods_single/calculate_scwts_test.rb'
  end
  watch('test/lib/console_methods_single/calculate_scwts_test.rb') do
    'test/lib/console_methods_single/calculate_scwts_test.rb'
  end

  # calculate_swos lib and its tests
  watch('lib/console_methods_single/calculate_swos.rb') do
    'test/lib/console_methods_single/calculate_swos_test.rb'
  end
  watch('test/lib/console_methods_single/calculate_swos_test.rb') do
    'test/lib/console_methods_single/calculate_swos_test.rb'
  end

  # calculate_sts lib and its tests
  watch('lib/console_methods_single/calculate_sts.rb') do
    'test/lib/console_methods_single/calculate_sts_test.rb'
  end
  watch('test/lib/console_methods_single/calculate_sts_test.rb') do
    'test/lib/console_methods_single/calculate_sts_test.rb'
  end

  # retrieve_user_word_helper and its tests
  watch('app/helpers/retrieve_user_word_helper.rb') do
    'test/helpers/retrieve_user_word_helper_test.rb'
  end
  watch('app/helpers/retrieve_user_word_helper_test.rb') do
    'test/helpers/retrieve_user_word_helper_test.rb'
  end

  # setup_map lib and its test
  watch('lib/setup_map.rb') { 'test/lib/setup_map_test.rb' }
  watch('test/lib/setup_map_test.rb') { 'test/lib/setup_map_test.rb' }

  # utilities lib and its test
  watch('lib/utilities.rb') { 'test/lib/utilities_test.rb' }
  watch('test/lib/utilities_test.rb') { 'test/lib/utilities_test.rb' }

  # Language model and its tests
  watch('app/models/language.rb') { 'test/models/language_test.rb' }
  watch('test/models/language_test.rb') { 'test/models/language_test.rb' }

  # Script model and its tests
  watch('app/models/script.rb') { 'test/models/script_test.rb' }
  watch('test/models/script_test.rb') { 'test/models/script_test.rb' }

  # Character model and its tests
  watch('app/models/character.rb') { 'test/models/character_test.rb' }
  watch('test/models/character_test.rb') { 'test/models/character_test.rb' }

  # Word model and its tests
  watch('app/models/word.rb') { 'test/models/word_test.rb' }
  watch('test/models/word_test.rb') { 'test/models/word_test.rb' }

  # Sentence model and its tests
  watch('app/models/sentence.rb') { 'test/models/sentence_test.rb' }
  watch('test/models/sentence_test.rb') { 'test/models/sentence_test.rb' }

  # Score model and its tests
  watch('app/models/score.rb') { 'test/models/score_test.rb' }
  watch('test/models/score_test.rb') { 'test/models/score_test.rb' }

  # User model and its tests
  watch('app/models/user.rb') { 'test/models/user_test.rb' }
  watch('test/models/user_test.rb') { 'test/models/user_test.rb' }

  # User_score model and its tests
  watch('app/models/user_score.rb') { 'test/models/user_score_test.rb' }
  watch('test/models/user_score_test.rb') { 'test/models/user_score_test.rb' }

  # user_metric model and its tests
  watch('app/models/user_metric.rb') { 'test/models/user_metric_test.rb' }
  watch('test/models/user_metric_test.rb') do
    'test/models/user_metric_test.rb'
  end
end

guard :rubocop do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end
