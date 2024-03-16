#ctrl + enter za pojedinu liniju
#alt + enter za cell block omeđen s dva #
#ako stavimo ; na kraj linije, obavit ce nam se operacija, ali nece se pokazati pokraj

println("Hello world")
##
15 + 5
##
10 + 4
1 + 2
3 + 5
##
println("Hello world")
println("Volimo raditi u Juliji")
##
ime = "Pero Perić"
ime 
godine = 21
tezina = 83.5
visina = 180.2
print("$ime ima $godine godinu, tezak je $tezina kilograma i visok $visina centimetara.")
## tipovi varijabli
typeof(ime)
typeof(godine)
typeof(tezina)
typeof(visina)
## sto se dogodi kad zbrajamo float i int
a = 5
b = 3.0
print(typeof(a + b))
## realni brojevi - neki oblici
1.5e-2
1.5f-2
1.0/Inf
1.0/0.0
100-Inf
Inf - Inf 
## racionalni i kompleksni brojevi
rac = 5//2 
kompl = 1 + 2.5im 
typeof(rac)
typeof(kompl)
rac + kompl 
float(rac)
numerator(rac)
denominator(rac)
## logicki tipovi - true, false
5 < 2
#ans je zadnja stvar koju smo pokrenuli
typeof(ans)
true + true
## local scope varijabli - varijabla y je vidljiva samo unutar fje, dok je z globalna
function primjer1()
    y = 12
    return
end
primjer1() 
y
function primjer2()
    global z = 12
    return
end
primjer2()
z
function primjer3()
    x = 12
    return x
end
x = primjer3()
## osnovne operacije
2^4 + 5
2^3 * 5 / 4
2^(3*5/4)
0.5 + 0.7 - ((4.0 * 7.5) / 3) - 1 + 2 * 3
## logicke operacije
negacije = !true
!true
true && true
true || false 
a == b
a !== b
#za a = 2 i b = 2.0, izbacit ce false jer enforcea type
a === b 
a > b 
a >= b 
a < b
a <= b 
## primjer pozivanja vise fja
a, b, c = cos(0.5), sin(0.5), abs(-5)
## fje
function kvadrat1(x)
    return x*x
end
kvadrat2(x) = x*x
kvadrat3 = x -> x*x
a = kvadrat1(2)
b = kvadrat2(3)
c = kvadrat3(4)
## kontrola toka
function Pozdrav(vrijeme)
    if vrijeme < 10
        pozdrav = "Dobro jutro"
    elseif vrijeme < 20
        pozdrav = "Dobar dan"
    else
        pozdrav = "Dobra večer"
    end
    return pozdrav
end
println(Pozdrav(15))
if 1 < 5 && 3 < 7
    print("tocno")
end
## for petlja
x = 0
for i = 1 : 20
    x = x + i
end
x
## for petlja za nizove
osobe = ["Ana", "Maja", "Pero", "Marko"]
for osoba in osobe
    println("Bok $osoba !")
end 
#pomocu naredbe break mozemo prekinuti izvodenje petlje, a s continue preskociti iteraciju
## while petlja
x = 0
i = 0
while i < 20
    i += 1
    x = x + i
end
x
i
## opis opcionalnih pozicioniranih argumenata
function mojatezina(tezinanazemlji, g = 9.81)
    return tezinanazemlji * g / 9.81
end
#ako posaljemo drugi argument, onda ce g biti 10, ali s jednim argumentom g = 9.81
a = mojatezina(60, 10)
b = mojatezina(60)
## opis argumenta kljucnih rijeci
function nekafunkcija(a, b = 15; c, d = 35)
    return a + b - c - d
end
nekafunkcija(1, c = 25)
nekafunkcija(1, 2, c = 25)
nekafunkcija(1, 2, c = 25, d = 25)
## prikaz metoda za funkciju sinus, fja koristi druge metode ovisno o tipu argumenata
methods(sin)

