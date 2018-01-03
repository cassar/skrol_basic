module LanguageMapConsolidator
  # Validates a language pair to make sure it is ready to map_to another language.
  def self.consolidate_all(lang_map)
    scripts = ScriptRetriever.new(lang_map)
    inforce_integrity(scripts.language_pairs)
    # Recheck all sentences to map to constituent words.
    consolidate_sentences_words(scripts.associate_pair)
    consolidate_suitable_associates(scripts.associate_pair)
  end

  def self.inforce_integrity(language_pairs)
    language_pairs.each do |pair|
      std_script, phn_script = pair
      IntegrityManager.new(std_script, phn_script).enforce
    end
  end

  def self.consolidate_sentences_words(associate_pair)
    target_script, base_script = associate_pair
    SentenceWordUpdater.new(target_script).update_all
    SentenceWordUpdater.new(base_script).update_all
  end

  def self.consolidate_suitable_associates(associate_pair)
    SuitableAssociateCompiler.new(associate_pair).compile
  end

  class ScriptRetriever
    def initialize(lang_map)
      @tar_stn_spt = lang_map.target_script
      @tar_phn_spt = @tar_stn_spt.phonetic
      @bse_stn_spt = lang_map.base_script
      @bse_phn_spt = @bse_stn_spt.phonetic
    end

    def associate_pair
      [@tar_stn_spt, @bse_stn_spt]
    end

    def phonetic_scripts
      [@tar_phn_spt, @bse_phn_spt]
    end

    def language_pairs
      [[@tar_stn_spt, @tar_phn_spt], [@bse_stn_spt, @bse_phn_spt]]
    end
  end
end
