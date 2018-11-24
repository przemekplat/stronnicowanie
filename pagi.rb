def IloscStron(ileElementow,ileElNaStr) #obliczanie ile stron będzie miał cały dokument
iloscStron = ileElementow/ileElNaStr.to_f
return iloscStron.ceil
end

def WypisywanieElementow(ileElementow,ileElNaStr,strona) #wypisywanie elementów na jednej stronie
  i = 1 # działa
  (ileElementow - ( ileElNaStr * strona )).times {
  puts "Wiersz nr #{i}\n"
  i += 1
  break if i > ileElNaStr
  }

end

ileElementow = 105
ileElNaStr = 10
ileStronIndeks = 5

puts "Podaj strone na którą chcesz przejsc:"
strona = gets.chomp.to_i
WypisywanieElementow(ileElementow,ileElNaStr,strona)
