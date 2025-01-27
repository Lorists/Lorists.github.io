# TABLES
# --------------------------------------

# Numbers
# Add 'number' class to number cells
table_numbers = -> $('td').each ->
  cell = $ @
  string = +cell.text().trim()
  if string and !isNaN string then cell.addClass 'number'
  return # End cells loop

# Durations
# Replace original date in repeating events
table_durations = -> $('tr').has('td[data-header="duration"]:not(:empty)').each ->
  row = $ @
  # Loop not empty duration cells
  row.find('td[data-header="duration"]:not(:empty)').each ->
    duration = duration_ms $(@).text().trim()
    # Get row date
    date_cell = row.find('td[data-header="date"]').eq(0)
    date_string = date_cell.text().trim()
    running = +new Date date_string
    if running < today
      while running < today
        running += duration
      # Update cell
      future_date = date_iso running
      time_el = date_cell.find('time').eq(0)
      time_el.text future_date + ' '
      time_el.attr
        title: "Original date #{date_string}"
        datetime: future_date
        'data-sort': future_date
    return # End 'duration' cells loop
  return # End table rows loop

# Sort by date descending
table_sort = -> $('table.sort').each ->
  table = $ @
  # Sort function by first TD cell text node
  rows = table.find('tbody tr').sort (a, b) ->
    value_a = $(a).find("td:first-child").text().trim()
    value_b = $(b).find("td:first-child").text().trim()
    return if value_a >= value_b then -1 else 1
  # Remove rows and append new sequence
  table.find('tbody tr').remove()
  table.find('tbody').append rows
  # Hide extra rows if data-limit attribute is set
  if table.attr 'data-limit'
    limit = +table.attr 'data-limit'
    rows = table.find('tr')
    rows.each (i, e) ->
      if (limit > 0 and i > limit) or (limit < 0 and i < rows.length+limit)
        $(e).hide()
      return
  return