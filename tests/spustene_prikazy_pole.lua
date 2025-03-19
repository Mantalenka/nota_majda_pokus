
pole_cisel = {1, 5, 3, 8, 2, 9, 11, 10}

-- Vzhledem k poli čísel vytiskněte součet všech z nich.
print("Součet čísel z pole: " .. table.concat(pole_cisel, ", "))
sum = 0
for  k,v in ipairs(pole_cisel) do --i pro sekvenční pole, bez_i pro smíšené pole
   sum = sum + v
   end
print("Soucet je: " .. sum)


-- Vzhledem k poli čísel vytiskněte index největšího čísla.
print("Index největšího čísla z pole: " .. table.concat(pole_cisel, ","))
index_of_max_value = 1
max_value = pole_cisel[1]
for k,v in ipairs(pole_cisel) do
   if max_value < v then
      max_value = v
      index_of_max_value = k
   end
end

print("Maximalni index: " .. index_of_max_value)


-- Je-li dané číslo N, vytvořte pole obsahující druhé mocniny každého čísla až do N.
new_a = {}
n = 10
for i = 1, n do
   table.insert(new_a,i ^ 2)
   end

print("Druhé mocniny čísel: " .. table.concat(new_a, ", "))



-- Zadané pole čísel a číslo N vytiskněte N-té liché číslo v poli.
n = 5
print("N-té liché číslo z pole: " .. table.concat(pole_cisel, ", ") .. ", n: " .. n)
for v,k in ipairs(pole_cisel) do
   if k % 2 == 1 then
      n = n -1
      if n == 0 then
        print(k)
        break
      end
   end
end
