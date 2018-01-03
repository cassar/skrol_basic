# Takes an array of items (typicall words or sentences) and returns an object
# of the following form ...
# {item.id => 0.0}
def create_item_scores_obj(items)
  item_scores_obj = {}
  items.each { |item| item_scores_obj[item.id] = 0.0 }
  item_scores_obj
end
