# Retrieves a WTS score given a word_id and base_script or raises an error if
# a score cannot be found.
def retrieve_wts(word_id, base_script)
  wts_score = Score.where(entriable_id: word_id, entriable_type: 'Word',
                          map_to_id: base_script.id, map_to_type: 'Script',
                          name: 'WTS').first
  raise Invalid, "No WTS for word_id: #{word_id} found" if wts_score.nil?
  wts_score
end
