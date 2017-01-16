require 'test_helper'

class AddParagraphsTest < ActiveSupport::TestCase
  test 'add_paragraphs' do
    base_para = 'The Cosmos is all that is or ever was or ever will be. Our feeblest contemplations of the Cosmos stir us - there is a tingling in the spine, a catch in the voice, a faint sensation, as if a distant memory, of falling from a height. We know we are approaching the greatest of mysteries.'
    base_script = lang_by_name('English').base_script
    target_para = 'El cosmos es todo lo que es o lo que fue o lo que será alguna vez. Nuestras contemplaciones más tibias del Cosmos nos con- mueven: un escalofrío recorre nuestro espinazo, la voz se nos quiebra, hay una sensación débil, como la de un recuerdo lejano, o la de caer desde lo alto. Sabemos que nos estamos acercando al mayor de los misterios.'
    target_script = lang_by_name('Spanish').base_script

    call = 'Sentence.count'
    assert_difference(call, 14, 'incorrect # of sents saved') do
      add_paragraphs(base_para, base_script, target_para, target_script)
    end
  end
end
