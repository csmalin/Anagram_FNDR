File.open("app/words").each_line do |line|
  Word.create(:name => line.strip.downcase, :sorted => line.strip.downcase.chars.sort.join)
end
