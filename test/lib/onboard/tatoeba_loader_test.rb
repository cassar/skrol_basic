require 'test_helper'

class TatoebaLoaderTest < ActiveSupport::TestCase
  setup do
    @english = Script.find(1)
    @italian = Script.find(3)
    @sentences_file_name = 'test/lib/test_files/sentences.csv'.freeze
    @links_file_name = 'test/lib/test_files/links.csv'.freeze
  end

  test 'create_metadatum and load' do
    TatoebaLoader.create_metadatum(@english, 'eng')
    TatoebaLoader.create_metadatum(@italian, 'ita')
    assert_difference('Sentence.count', 2) do
      TatoebaLoader.loader(@english, @italian, @sentences_file_name, @links_file_name)
    end
  end
end
