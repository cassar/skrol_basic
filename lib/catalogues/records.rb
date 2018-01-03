# { record_id => record }
def derive_record_id_to_record(records)
  record_id_to_record = {}
  records.each { |record| record_id_to_record[record.id] = record }
  record_id_to_record
end

# { record => [ assoc, ...] }
def derive_record_to_assocs(records, assocs)
  record_id_to_record = derive_record_id_to_record(records)
  record_to_assocs = {}
  records.each { |record| record_to_assocs[record] = [] }
  assocs.each do |assoc|
    record_a = record_id_to_record[assoc.associate_a_id]
    record_to_assocs[record_a] << assoc unless record_a.nil?
    record_b = record_id_to_record[assoc.associate_b_id]
    record_to_assocs[record_b] << assoc unless record_b.nil?
  end
  record_to_assocs
end

# Takes an array of sentence or word records and returns an object of pair
# {entry: [record,...]}
def derive_entry_to_records(records)
  entry_to_records = {}
  records.each do |record|
    current = entry_to_records[record.entry]
    entry_to_records[record.entry] = [] unless current.present?
    entry_to_records[record.entry] << record
  end
  entry_to_records
end

# Creates an object { record_entry => record }
def derive_entry_to_record(records)
  entry_to_record = {}
  records.each { |record| entry_to_record[record.entry] = record }
  entry_to_record
end

# { 'record_a_entry:record_b_entry' => record_assoc,
# 'record_b_entry:record_a_entry' => record_assoc}
def derive_concat_string_to_record_assoc(records, record_assocs)
  record_id_to_record = derive_record_id_to_record(records)
  concat_string_to_record_assoc = {}
  record_assocs.each do |record_assoc|
    string_a = record_id_to_record[record_assoc.associate_a_id].entry
    string_b = record_id_to_record[record_assoc.associate_b_id].entry
    concat_string_to_record_assoc[string_a + ':' + string_b] = record_assoc
    concat_string_to_record_assoc[string_b + ':' + string_a] = record_assoc
  end
  concat_string_to_record_assoc
end

# Creates an object { std_record => [ phn_record, ... ] }
def derive_std_record_to_phn_records(std_records, phn_records, record_phonetics)
  id_to_word = derive_record_id_to_record(std_records | phn_records)
  std_record_to_phn_records = {}
  record_phonetics.each do |record_phonetic|
    next if (std = id_to_word[record_phonetic.standard_id]).nil?
    phn_arr = std_record_to_phn_records[std]
    phn_arr = [] if phn_arr.nil?
    phn_arr << id_to_word[record_phonetic.phonetic_id]
    std_record_to_phn_records[std] = phn_arr
  end
  std_record_to_phn_records
end

# Creates an object { std_record => [ record_phonetic, ... ] }
def derive_std_rec_to_rec_phons(std_records, record_phonetics)
  std_id_to_std = derive_record_id_to_record(std_records)
  std_rec_to_rec_phons = {}
  record_phonetics.each do |record_phonetic|
    std_record = std_id_to_std[record_phonetic.standard_id]
    rec_phn_arr = std_rec_to_rec_phons[std_record]
    rec_phn_arr = [] if rec_phn_arr.nil?
    rec_phn_arr << record_phonetic
    std_rec_to_rec_phons[std_record] = rec_phn_arr
  end
  std_rec_to_rec_phons
end
