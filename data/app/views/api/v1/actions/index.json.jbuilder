json.array! @actions do |action|
  json.desc action.desc
  json.user action.user
  json.date action.date
end