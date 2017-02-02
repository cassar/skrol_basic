require 'test_helper'

class CompileRepsTest < ActiveSupport::TestCase
  test 'compile_reps' do
    RepSent.destroy_all
    script = lang_by_name('Spanish').base_script
    call = 'RepSent.count'
    change = 0
    script.sentences.each { |sent| change += sent.entry.split_sentence.count }
    assert_difference(call, change, 'incorrect # of scores saved') do
      compile_reps(script)
    end
  end
end
