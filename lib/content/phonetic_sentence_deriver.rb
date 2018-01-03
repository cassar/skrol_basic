class PhoneticSentenceDeriver
  def initialize(standard_script)
    @standard_script = standard_script
  end

  def phonetic_representation(assoc_rep)
    phonetic_rep = []
    assoc_rep.each do |assoc|
      word = assoc.corresponding(@standard_script)
      phonetic_rep << word.phonetics.first
    end
    phonetic_rep
  end
end
