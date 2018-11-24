def IloscStron(ileElementow,ileElNaStr) #obliczanie ile stron będzie miał cały dokument
  iloscStron = ileElementow/ileElNaStr
  return iloscStron
end

def WypisywanieElementow(ileElementow,ileElNaStr,strona) #wypisywanie elementów na jednej stronie
  i = 1 # działa
  (ileElementow - ( ileElNaStr * strona )).times {
   puts "Wiersz nr #{i}, strona numer #{strona}"
   i += 1
   break if i > ileElNaStr
  }
end

ileElementow = 95 #liczba elementów (parametry wpisane na sztywno aby ułatwić testowanie)
ileElNaStr = 10 #ile elementów ma być na jednej stronie
ileStronIndeks = 5 #ile stron ma się wyświetlać na dole
puts "Ilość stron: #{IloscStron(ileElementow,ileElNaStr)}"
puts "Podaj numer strony na który chcesz przejść:"
strona = gets.chomp.to_i
WypisywanieElementow(ileElementow,ileElNaStr,strona)
ileStron = [*0..IloscStron(ileElementow,ileElNaStr)]
#puts "Liczba stron: #{ileStron}"
poczatek = -(ileStronIndeks/2) #o ile przesunięty jest początek indeksacji (numery na dole) względem wybranej strony
koniec = (ileStronIndeks/2) #o ile przesunięty jest koniec indeksacji (numery na dole) względem wybranej strony
if ileStronIndeks&1 == 0 then #dla parzystych indeksów koniec jest przesunięty o -1
  koniec -= 1
end
if (strona+koniec) > ileStron.last then # jeżeli nr wybranej strony + wartość przesunięcia na końcu indeksowania jest większa niż liczba wszystkich stron, wtedy...
  poczatek -= (strona+koniec)-(ileStron.last) # ...przesuwamy początek o różnice między wybraną przez użytkownika stroną + wartością przesunięcia na początku a całkowitą iloścą stron
end
wypis = 0 #ile razy wypisaliśmy indeks
while ileStronIndeks > wypis do
  if 0 <= (strona+poczatek) then
    print "#{ileStron[strona+poczatek]} "
    wypis += 1
  end
 poczatek += 1
end
