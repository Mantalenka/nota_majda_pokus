end_my = 10
-- Při daném čísle N vytiskněte všechna čísla až do N.

print("Vypiš všechna čísla do " .. end_my ..":")
for i = 1, end_my do
   print(i)
   end
   
-- Při daném čísle N vytiskněte každé liché číslo až po N bez použití if.
print("Vypiš lichá čísla do ".. end_my ..":")
for i = 1,end_my,2 do
   print(i)
   end


-- Při daném čísle N vytiskněte všechna čísla až do N v opačném pořadí.
print("Vypiš v opačném pořadí do " .. end_my .. ":")
for i=end_my, 1, -1 do
   print(i)
   end

