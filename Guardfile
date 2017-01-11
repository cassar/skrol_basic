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

  # add_paragraphs lib and its tests
  watch('lib/content_management/add_paragraphs.rb') do
    'test/lib/content_management/add_paragraphs_test.rb'
  end
  watch('test/lib/content_management/add_paragraphs_test.rb') do
    'test/lib/content_management/add_paragraphs_test.rb'
  end

  # compile_chars_cfs lib and its tests
  watch('lib/content_management/compile_chars_cfs.rb') do
    'test/lib/content_management/compile_chars_cfs_test.rb'
  end
  watch('test/lib/content_management/compile_chars_cfs_test.rb') do
    'test/lib/content_management/compile_chars_cfs_test.rb'
  end

  # translate_string lib and its tests
  watch('lib/content_management/translate_string.rb') do
    'test/lib/content_management/translate_string_test.rb'
  end
  watch('test/lib/content_management/translate_string_test.rb') do
    'test/lib/content_management/translate_string_test.rb'
  end

  # create_content lib and its tests
  watch('lib/content_management/create_content.rb') do
    'test/lib/content_management/create_content_test.rb'
  end
  watch('test/lib/content_management/create_content_test.rb') do
    'test/lib/content_management/create_content_test.rb'
  end

  # content_helper lib and its tests
  watch('lib/content_management/content_helper.rb') do
    'test/lib/content_management/content_helper_test.rb'
  end
  watch('test/lib/content_management/content_helper_test.rb') do
    'test/lib/content_management/content_helper_test.rb'
  end

  # content_reports lib and its tests
  watch('lib/content_management/content_reports.rb') do
    'test/lib/content_management/content_reports_test.rb'
  end
  watch('test/lib/content_management/content_reports_test.rb') do
    'test/lib/content_management/content_reports_test.rb'
  end

  # calculate_wcfbs lib and its tests
  watch('lib/static_content_scores/calculate_wcfbs.rb') do
    'test/lib/static_content_scores/calculate_wcfbs_test.rb'
  end
  watch('test/lib/static_content_scores/calculate_wcfbs_test.rb') do
    'test/lib/static_content_scores/calculate_wcfbs_test.rb'
  end

  # calculate_wcfts lib and its tests
  watch('lib/static_content_scores/calculate_wcfts.rb') do
    'test/lib/static_content_scores/calculate_wcfts_test.rb'
  end
  watch('test/lib/static_content_scores/calculate_wcfts_test.rb') do
    'test/lib/static_content_scores/calculate_wcfts_test.rb'
  end

  # calculate_wfs lib and its tests
  watch('lib/static_content_scores/calculate_wfs.rb') do
    'test/lib/static_content_scores/calculate_wfs_test.rb'
  end
  watch('test/lib/static_content_scores/calculate_wfs_test.rb') do
    'test/lib/static_content_scores/calculate_wfs_test.rb'
  end

  # calculate_wls lib and its tests
  watch('lib/static_content_scores/calculate_wls.rb') do
    'test/lib/static_content_scores/calculate_wls_test.rb'
  end
  watch('test/lib/static_content_scores/calculate_wls_test.rb') do
    'test/lib/static_content_scores/calculate_wls_test.rb'
  end

  # calculate_wss lib and its tests
  watch('lib/static_content_scores/calculate_wss.rb') do
    'test/lib/static_content_scores/calculate_wss_test.rb'
  end
  watch('test/lib/static_content_scores/calculate_wss_test.rb') do
    'test/lib/static_content_scores/calculate_wss_test.rb'
  end

  # calculate_wts lib and its tests
  watch('lib/static_content_scores/calculate_wts.rb') do
    'test/lib/static_content_scores/calculate_wts_test.rb'
  end
  watch('test/lib/static_content_scores/calculate_wts_test.rb') do
    'test/lib/static_content_scores/calculate_wts_test.rb'
  end

  # calculate_swls lib and its tests
  watch('lib/static_content_scores/calculate_swls.rb') do
    'test/lib/static_content_scores/calculate_swls_test.rb'
  end
  watch('test/lib/static_content_scores/calculate_swls_test.rb') do
    'test/lib/static_content_scores/calculate_swls_test.rb'
  end

  # calculate_scwts lib and its tests
  watch('lib/static_content_scores/calculate_scwts.rb') do
    'test/lib/static_content_scores/calculate_scwts_test.rb'
  end
  watch('test/lib/static_content_scores/calculate_scwts_test.rb') do
    'test/lib/static_content_scores/calculate_scwts_test.rb'
  end

  # calculate_swos lib and its tests
  watch('lib/static_content_scores/calculate_swos.rb') do
    'test/lib/static_content_scores/calculate_swos_test.rb'
  end
  watch('test/lib/static_content_scores/calculate_swos_test.rb') do
    'test/lib/static_content_scores/calculate_swos_test.rb'
  end

  # calculate_sts lib and its tests
  watch('lib/static_content_scores/calculate_sts.rb') do
    'test/lib/static_content_scores/calculate_sts_test.rb'
  end
  watch('test/lib/static_content_scores/calculate_sts_test.rb') do
    'test/lib/static_content_scores/calculate_sts_test.rb'
  end

  # setup_map lib and its test
  watch('lib/static_content_scores/setup_map.rb') do
    'test/lib/static_content_scores/setup_map_test.rb'
  end
  watch('test/lib/static_content_scores/setup_map_test.rb') do
    'test/lib/static_content_scores/setup_map_test.rb'
  end

  # retrieve_next_slide_helper and its tests
  watch('lib/user_management/retrieve_next_slide.rb') do
    'test/lib/user_management/retrieve_next_slide1_test.rb'
  end
  watch('lib/user_management/retrieve_next_slide.rb') do
    'test/lib/user_management/retrieve_next_slide2_test.rb'
  end
  watch('test/lib/user_management/retrieve_next_slide1_test.rb') do
    'test/lib/user_management/retrieve_next_slide1_test.rb'
  end
  watch('test/lib/user_management/retrieve_next_slide2_test.rb') do
    'test/lib/user_management/retrieve_next_slide2_test.rb'
  end

  # exhaust_methods.rb
  watch('lib/user_management/exhaust_methods.rb') do
    'test/lib/user_management/exhaust_methods_test.rb'
  end
  watch('test/lib/user_management/exhaust_methods_test.rb') do
    'test/lib/user_management/exhaust_methods_test.rb'
  end

  # query_methods lib and its test
  watch('lib/content_management/query_methods.rb') do
    'test/lib/content_management/query_methods_test.rb'
  end
  watch('test/lib/content_management/query_methods_test.rb') do
    'test/lib/content_management/query_methods_test.rb'
  end

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

  # slide_controller and its test
  watch('app/controllers/slide_controller.rb') do
    'test/controllers/slide_controller_test.rb'
  end
  watch('test/controllers/slide_controller_test.rb') do
    'test/controllers/slide_controller_test.rb'
  end
end

guard :rubocop do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end
