divnost = {1, 2, "Ahoj", false, 3, a = 8, c = 10}
pole = {1, 2, "AHoj", "hele"}
tabulka = { a = 10, b = "Ahoj" , d = false, [3] = "T", [5] = 10}

--[[
io.write("Výpis pole chat: ")
for _, v in pairs(pole) do
    io.write(tostring(v), " ")
end
print()
]]

-- Dané pole vytiskne každý prvek a jeho index.
print("Výpis pole klíč : hodnota")
for k,v in ipairs(pole) do
   print(k .. " : " .. tostring(v))
   end
   
-- Vzhledem k tabulce vytiskněte každý prvek a jeho klíč.

print("Výpis tabulka klíč: hodnota")
for k,v in pairs(tabulka) do
   print(k .. " : " .. tostring(v))
   end
   
   
-- Dané pole spočítejte počet jeho prvků.
print("Délka pole: " .. #pole)
-- Vzhledem k tabulce spočítejte počet jejích prvků.
pocet_p = 0
for k,v in pairs(tabulka) do
   pocet_p = pocet_p + 1
end
print("Délka tabulky: " .. pocet_p)


 -- Dané pole určete, zda je prázdné.
 new_p = {10}
 table.remove(new_p)
if #new_p == 0 then print("Prázdné pole")
else print("Pole něco obsahuje")
end

 -- Vzhledem k tabulce určete, zda je prázdná.
 
new_t = {a = true}
new_t["a"] = nil

-- chat:
if next(new_t) == nil then --next vrací první klíč a hodnotu
    print("Tabulka je prázdná")
else
    print("Tabulka není prázdná: " .. next(new_t))
end

