module TatoebaLoader
  def self.create_metadatum(standard_script, lang_id)
    standard_script.meta_data.create(source: TATOEBA, entry: { lang_id: lang_id })
  end

  def self.loader(standard_script1, standard_script2, sentences_file_name, links_file_name)
    TatoebaProcessor.new(standard_script1, standard_script2, sentences_file_name, links_file_name).process
  end

  class TatoebaProcessor
    def initialize(standard_script1, standard_script2, sentences_file_name, links_file_name)
      meta1 = standard_script1.meta_data.find_by source: TATOEBA
      meta2 = standard_script2.meta_data.find_by source: TATOEBA
      assign_sent_entries(meta1, meta2, sentences_file_name)
      @tatoeba_link_ids = assign_link_ids(links_file_name)
      @sent_pair_processor = SentencePairProcessor.new(standard_script1, standard_script2, TATOEBA)
    end

    def process
      @tatoeba_link_ids.each do |id1, id2|
        next if (entry1 = @tatoeba_id_to_entry1[id1]).length > MAX_LENGTH_LOAD
        next if (entry2 = @tatoeba_id_to_entry2[id2]).length > MAX_LENGTH_LOAD
        meta_entry1 = { tatoeba_id: id1 }
        meta_entry2 = { tatoeba_id: id2 }
        @sent_pair_processor.process(entry1, meta_entry1, entry2, meta_entry2)
      end
    end

    private

    def assign_sent_entries(meta1, meta2, sentences_file_name)
      sent_loader = SentenceLoader.new(sentences_file_name)
      @tatoeba_id_to_entry1 = sent_loader.retrieve(meta1.entry[:lang_id])
      @tatoeba_id_to_entry2 = sent_loader.retrieve(meta2.entry[:lang_id])
    end

    def assign_link_ids(links_file_name)
      link_loader = LinkLoader.new(links_file_name)
      link_loader.compile(@tatoeba_id_to_entry1, @tatoeba_id_to_entry2)
    end

    class SentenceLoader
      def initialize(sentences_file_name)
        @file_name = sentences_file_name
      end

      def retrieve(lang_id)
        tatoeba_id_to_entry = {}
        File.open(@file_name).each do |line|
          tatoeba_id, line_lang, text = line.split("\t")
          next if line_lang != lang_id
          tatoeba_id_to_entry[tatoeba_id.to_i] = text.strip
        end
        tatoeba_id_to_entry
      end
    end

    class LinkLoader
      def initialize(links_file_name)
        @file = File.open(links_file_name)
      end

      def compile(tatoeba_id_to_entry1, tatoeba_id_to_entry2)
        tatoeba_link_ids = {}
        @file.each do |line|
          sent_id, trans_id = line.split
          sent_id = sent_id.to_i
          trans_id = trans_id.to_i
          next if tatoeba_id_to_entry1[sent_id].nil? || tatoeba_id_to_entry2[trans_id].nil?
          tatoeba_link_ids[sent_id] = trans_id
        end
        tatoeba_link_ids
      end
    end
  end
end

# require 'open_uri_redirections'
# def retrieve_tatoeba_sents_file
#   uri = 'https://downloads.tatoeba.org/exports/sentences.tar.bz2'
#   source = open(uri)
#   source = File.open('/Users/lukecassar/Downloads/data/sentences.tar.bz2')
#   gz = Zlib::GzipReader.new(source)
#   result = gz.read
#   IO.copy_stream(result, PROD_DEV_DIR + SENTS)
# end
