def ElementyWstronach(iloscElementow,iloscStron) #obliczanie ile elementów znajduje się na stronie
 licz = 0.0
 pelnewiersze = 0
 elementyzapelniajace = 0
 licz = iloscElementow/iloscStron.to_f
 elementyzapelniajace = (licz-licz.to_i)*iloscStron
 return pelnewiersze = licz.to_i,elementyzapelniajace.round
end

def StrzalkiLewo(aktywnaStrona,poczatek) #wypisuje strzalki w lewo przy indeksie
  if aktywnaStrona+poczatek >= 1 then
    if aktywnaStrona+poczatek >= 2 then
    print "<< < "
  else
    print " < "
  end
end
end

def StrzalkiPrawo(aktywnaStrona,koniec,iloscStron) #wypisuje strzalki w prawo przy indeksie
  if aktywnaStrona+koniec <= iloscStron-1 then
    print ">"
    print " >>" if aktywnaStrona+koniec <= iloscStron-2
end
end

def WypisStrony(ileStronIndeks,aktywnaStrona,poczatek)
  wypis = 0 #ile razy wypisaliśmy indeks
  while ileStronIndeks > wypis do
    if 0 <= (aktywnaStrona+poczatek) then
      print "#{aktywnaStrona+poczatek} "
      wypis += 1
    end
   poczatek += 1
  end
end

#puts "Podaj ilość elementów:"
#iloscElementow = gets.chomp.to_i
iloscElementow = 75
#puts "Podaj ilość stron:"
#iloscStron = gets.chomp.to_i
iloscStron = 3
#puts "Podaj ilość indeksów:"
ileStronIndeks = 1
wynik = ElementyWstronach(iloscElementow,iloscStron)
puts "Podaj numer strony na który chcesz przejść:"
aktywnaStrona = gets.chomp.to_i
 strony = Array.new(iloscStron)
 puts  # This also returns 20
 i = 0
 (strony.length).times {
   strony[i] = wynik[0]
   strony[i] += 1 if i < wynik[1]
   i += 1
 }
 i = 1
strony[aktywnaStrona].times{
puts "To element numer #{i} ze strony #{aktywnaStrona}"
i += 1
}
poczatek = -(ileStronIndeks/2) #o ile przesunięty jest początek indeksacji (numery na dole) względem wybranej strony
koniec = (ileStronIndeks/2) #o ile przesunięty jest koniec indeksacji (numery na dole) względem wybranej strony
 if ileStronIndeks&1 != 0 then #dla parzystych indeksów koniec jest przesunięty o 1
  koniec += (1)
end
if (aktywnaStrona+koniec) > strony.length then # /komentarz do poprawy/ jeżeli nr wybranej strony + wartość przesunięcia na końcu indeksowania jest większa niż liczba wszystkich stron, wtedy...
  poczatek -= (aktywnaStrona+koniec)-(strony.length) # ...przesuwamy początek o różnice między wybraną przez użytkownika stroną + wartością przesunięcia na początku a całkowitą iloścą stron
end
StrzalkiLewo(aktywnaStrona,poczatek)
WypisStrony(ileStronIndeks,aktywnaStrona,poczatek)
StrzalkiPrawo(aktywnaStrona,koniec,iloscStron)
