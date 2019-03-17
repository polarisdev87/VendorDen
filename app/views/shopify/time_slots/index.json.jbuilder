json.array! @time_slots do |time_slot|

  json.id        time_slot.id
  json.title     time_slot.description
  if time_slot.is_all_day?
    json.start Time.zone.now.to_date.to_s
    json.end Time.zone.now.to_date.to_s
    json.allDay true
  else
    json.start     time_slot.start_at.strftime('%FT%T%:z')
    json.end       time_slot.end_at.strftime('%FT%T%:z')
  end

  json.className 'time-slot'
  json.editPath  edit_shopify_time_slot_path(time_slot, format: :js)
  json.deletePath  shopify_time_slot_path(time_slot)

end
