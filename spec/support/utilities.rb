def full_title(page_title)
  base_title = "Baza Uzytkownikow"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end