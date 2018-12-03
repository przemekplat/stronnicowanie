require 'io/console'
require 'colorize'

def user_input() #wartości wpisywane przez użytkownika
  puts "Podaj zakres końcowy zbioru elementów (od 0 do x):"
  user_elements_count = gets.chomp.to_i
  puts "Na ile stron podzielić zbiór elementów:"
  user_page_count = gets.chomp.to_i
  puts "Podaj liczbę numerów indeksów (ile stron ma się wyświetlać na dole):"
  user_index_digits_count = gets.chomp.to_i
  user_index_digits_count = user_page_count if user_page_count < user_index_digits_count
  [user_elements_count, user_page_count, user_index_digits_count]
end

def calculate_elements_on_page(user_elements_count,user_page_count) #obliczanie ile elementów znajduje się na stronie
  elements = 0.0
  additional_element_if_uneven = 0
  elements = user_elements_count/user_page_count.to_f
  additional_element_if_uneven = (elements-elements.to_i)*user_page_count #dodatkowe elementy jeżeli liczba elementów jest niepodzielna przez ilość stron
  [elements.to_i,additional_element_if_uneven.round]
end

def write_to_array(user_elements_count,user_page_count,elements_uneven,active_page,array)   #wpisywanie elementów do tablicy
  i = 0
  if elements_uneven > 0  #dodatkowe wiersze w przypadku gdy liczba elementow jest niepodzielna przez liczbę stron
    while i < elements_uneven
      array[i] << ""
      i += 1
    end
  end
  add_element_count = 0
  (array.length).times do |j| #wpisujemy elementy do tablicy dwuwymiarowej
    (array[j].length).times do |jj|
      if add_element_count < user_elements_count
        array[j][jj] = add_element_count + 1
        add_element_count += 1
      end
    end
  end
end

def print_active_page(active_page,array) #wypisujemy zawartość aktywnej strony
  if active_page > array.length || active_page < 0
    puts "Nieprawidłowy indeks"
  else
    array[active_page].length.times do |jj|
      puts "Element '#{array[active_page][jj]}'"
    end
  end
end

def set_begin_end(user_index_digits_count, active_page, array) #ustawiamy przesunięcie początku i końca indeksacji
  left_offset_index = -(user_index_digits_count / 2) #o ile przesunięty jest początek indeksacji (numery na dole) względem wybranej strony
  right_offset_index = user_index_digits_count / 2 #o ile przesunięty jest koniec indeksacji (numery na dole) względem wybranej strony
  right_offset_index += 1 if user_index_digits_count&1 != 0  #dla parzystych indeksów koniec jest przesunięty o 1
  left_offset_index -= active_page + right_offset_index - array.length if active_page + right_offset_index > array.length # /komentarz do poprawy/ jeżeli nr wybranej strony + wartość przesunięcia na końcu indeksowania jest większa niż liczba wszystkich stron, wtedy przesuwamy początek o różnice między wybraną przez użytkownika stroną + wartością przesunięcia na początku a całkowitą iloścą stron.
  [left_offset_index, right_offset_index]
end

def print_arrows_right(active_page,left_offset_index) #wypisuje strzalki w lewo przy indeksie
  if active_page+left_offset_index >= 1 then
    if active_page+left_offset_index >= 2 then
      print "<< < "
    else
      print "< "
    end
  end
end

def print_index_of_active_page(user_index_digits_count,active_page,left_offset_index) #wypisywanie indeksu
  index_print_count = 0 #ile razy wypisaliśmy indeks
  while user_index_digits_count > index_print_count
    if 0 <= (active_page+left_offset_index)
      if (active_page == (active_page + left_offset_index)) then print "#{(active_page + left_offset_index)} ".red else print "#{(active_page + left_offset_index)} " end
      index_print_count += 1
    end
    left_offset_index += 1
  end
end

def print_arrows_left(active_page,right_offset_index,user_page_count,user_index_digits_count) #wypisuje strzalki w prawo przy indeksie
  if active_page+right_offset_index <= user_page_count - 1 && user_page_count != user_index_digits_count then
    print ">"
    print " >>" if active_page+right_offset_index <= user_page_count - 2 && user_page_count-user_index_digits_count >= 2
  end
end

user_elements_count, user_page_count, user_index_digits_count, active_page = user_input()
elements_in_array, elements_uneven, active_page = calculate_elements_on_page(user_elements_count,user_page_count) #elements_in_array = elementy w tablicy, elements_uneven = dodatkowe elementy w tablicy gdy nierówne
active_page = 0
array = Array.new(user_page_count) {Array.new(elements_in_array)}
active_page = 0 if active_page > 0 || active_page < array.length
write_to_array(user_elements_count,user_page_count,elements_uneven,active_page,array)
print_active_page(active_page,array)
left_offset_index, right_offset_index = set_begin_end(user_index_digits_count, active_page, array)
print_arrows_right(active_page,left_offset_index)
print_index_of_active_page(user_index_digits_count,active_page,left_offset_index)
print_arrows_left(active_page,right_offset_index,user_page_count,user_index_digits_count)
loop do
  user_input = $stdin.getch
  case user_input
  when 'q'
    exit
  else
    case user_input
    when ',', "<"
      active_page -= 1 if active_page >= 1
      puts "\n\nStrona numer #{active_page}\n\n"
      print_active_page(active_page,array)
      left_offset_index, right_offset_index = set_begin_end(user_index_digits_count, active_page, array)
      print_arrows_right(active_page,left_offset_index)
      print_index_of_active_page(user_index_digits_count,active_page,left_offset_index)
      print_arrows_left(active_page,right_offset_index,user_page_count,user_index_digits_count)
    when '.', '>'
      active_page += 1 if active_page < (array.length)-1
      puts "\n\nStrona numer #{active_page}\n\n"
      print_active_page(active_page,array)
      left_offset_index, right_offset_index = set_begin_end(user_index_digits_count, active_page, array)
      print_arrows_right(active_page,left_offset_index)
      print_index_of_active_page(user_index_digits_count,active_page,left_offset_index)
      print_arrows_left(active_page,right_offset_index,user_page_count,user_index_digits_count)
    end
  end
end
