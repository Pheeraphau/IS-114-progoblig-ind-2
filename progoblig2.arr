include shared-gdrive("dcic-2021", "1wyQZj_L0qqV9Ekgr9au6RX2iqt2Ga8Ep")
include gdrive-sheets
include data-source

ssid = "1RYN0i4Zx_UETVuYacgaGfnFcv4l9zd9toQTTdkQkj7g"

#(Kap 8.1.2 Dealing with Missing Entries) Der det mangler en verdi et sted, for eksempel bil "", bruker man "sanitize" for å få en verdi "0" og for å gjøre det lesbart for Pyret.
kWh-wealthy-consumer-data =
  load-table: komponent, energi
    source: load-spreadsheet(ssid).sheet-by-name("kWh", true)
    sanitize energi using string-sanitizer 
    sanitize komponent using string-sanitizer
end

#Tabell som har blitt satinized

print(kWh-wealthy-consumer-data)

#Konverterer string til tall fra kolonnen "energi" og gir "bil" en verdi på "0"(Kap 5.4 Documenting Functiones)
fun energi-to-number(str :: String) -> Number:
  doc: "if str is not a numeric string, default to 0."
  cases(Option) string-to-number(str):
    | some(a) => a
    | none => 0
  end
where:
energi-to-number("") is 0
  energi-to-number("30") is 30
end

#Tabell som viser tall og ikke string

updated-table = transform-column(kWh-wealthy-consumer-data, "energi", energi-to-number)

print(updated-table)

#Utfører beregningen av energiforbruket for bilbruken i tabellen med funksjon (1.1.8 Functiones)
fun car-energi-per-day(distance-travelled-per-day, distance-per-unit-of-fuel, energy-per-unit-of-fuel):
(distance-travelled-per-day / 
                            distance-per-unit-of-fuel) * 
                                        energy-per-unit-of-fuel
where:
  car-energi-per-day(24, 8, 9) is 27
end

distance-travelled-per-day = 24
distance-per-unit-of-fuel = 8
energy-per-unit-of-fuel = 9


#bruker "sum" funskjonen med funksjonen car-energi-per-day for å beregne det totale energiforbruket for en typisk innbygger i et industriland
total-energi-car = sum(updated-table, "energi") + car-energi-per-day(distance-travelled-per-day, distance-per-unit-of-fuel, energy-per-unit-of-fuel)

total-energi-car

#updatert visuallisering i tabellen
bar-chart(updated-table, "komponent", "energi")

# Ny funksjon for å få vist korret energiforbruk for bil i visualiseringen, (kap 1.1.8 Functions)
fun energi-to-number-with-car(str :: String) -> Number:
   cases(Option) string-to-number(str):
    | some(a) => a
    | none => car-energi-per-day(24, 8, 9)
  end
where:
energi-to-number("") is 0
  energi-to-number("30") is 30
end

#finalisert tabell
updated-table-with-car = transform-column(kWh-wealthy-consumer-data, "energi", energi-to-number-with-car)

print(updated-table-with-car)

#finalisert version av bilforbruket
bar-chart(updated-table-with-car, "komponent", "energi")