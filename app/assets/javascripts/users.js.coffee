# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  # Ajax sorting and pagination on click
  $('#users th.sortable a, #users .pagination a').on('click', ->
    $.getScript(this.href)
    false
  )
  # Ajax search on submit
  $('#users_search').submit( ->
    $.get(this.action, $(this).serialize(), null, 'script')
    false
  )
  # Ajax search on keyup
  $('#users_search input').keyup( ->
    $.get($("#users_search").attr("action"), $("#users_search").serialize(), null, 'script')
    false
  )
  # Ajax search on select box change
  $('#select_column').change( ->
    $.get($("#users_search").attr("action"), $("#users_search").serialize(), null, 'script')
    false
  )
