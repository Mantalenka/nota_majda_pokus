-- Vytvořte funkci, která dokáže vytisknout libovolnou booleovskou hodnotu, číslo, řetězec, pole nebo tabulku; pole a. tabulky mohou samy obsahovat pole a tabulky.

function vypis_cokoliv(vstup)
   if type(vstup) == type({}) then
       for key,value in pairs(vstup) do
           vypis_cokoliv(value)
       end
   else
       print(tostring(vstup))
   end
end


-- TESTS:

a = 5
b = "Ahoj"
ab = false
c = {1,2,3}
d = {a=4, b = true, c= "ahoj", d={}}
e = {a,b,ab,c,d}

print("a: ")
vypis_cokoliv(a)
print("b: ")
vypis_cokoliv(b)
print("ab: ")
vypis_cokoliv(ab)
print("c: ")
vypis_cokoliv(c)
print("d: ")
vypis_cokoliv(d)
print("e: ")
vypis_cokoliv(e)

---------------------------------------------
-- funkce, která přebírá pole a predikát a vrací pole všech prvků, které predikát předávají.
function apply(array, predicate)
   new_arr = {}
   for key,value in ipairs(array) do
      if predicate(value) then
         table.insert(new_arr, value)
      end
   end
   return new_arr
end


-- TEST:
function is_number_odd(number)
   if number % 2 == 1 then return true
   else return false
   end
end



a = {1,2,4,5,7,9,10,12,0,2}

odd_values = apply(a, is_number_odd)

print(table.concat(odd_values, ", "))
