def record_id_to_meta_present(metas)
  records_id_to_meta_present = {}
  metas.each do |mata_datum|
    records_id_to_meta_present[mata_datum.contentable_id] = true
  end
  records_id_to_meta_present
end
