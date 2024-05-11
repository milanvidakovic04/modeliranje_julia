#= Program stvara n pozitivnih i m negativnih naboja
s nasumicnim x komponentama i y komponentama, nisam ih htio
pravilno rasporediti s nekakvim izracunatim razmacima, nego sam
mislio da bi bilo zanimljivije da ih on nasumice izbaci.
Pretpostavljam da bi se plot malo izoblicio kad bi se n i m povecao 
na brojeve vece od 50, trebalo bi druge parametre isto prilagoditi tome =#

##konstante
const eps0 = 8.8541878128e-12
const k = 1 / (4 * pi * eps0)

##struktura naboj
struct Naboj
    x::Real
    y::Real
    q::Real
    Naboj(x, y, q) = new(x, y, q)
end

##parametri modela
q = 20 #iznos naboja
n = 10 #broj pozitivnih naboja
m = 12 #broj negativnih naboja

##tocke u kojima se računa elektricno polje
#N sam arbitrazno ovako odlucio racunati, da se mijenjati za razlicit broj naboja
N = Int(floor((m + n) * 1.3))
minX = -10
maxX = 10
minY = -10
maxY = 10
rangeX = range(minX, maxX, length=N)
rangeY = range(minY, maxY, length=N)

##mreza
xG=rangeX' .* ones(N)
yG=ones(N)' .* rangeY

##inicijalizacija polja naboja
naboji = Vector{Naboj}()
pozNaboji = Vector{Naboj}()
negNaboji = Vector{Naboj}()
for i in 1:n
    komponentaX = rand() * (maxX + abs(minX)) - abs(minX)
    komponentaY = rand() * (maxY + abs(minY)) - abs(minY)
    push!(naboji, Naboj(komponentaX, komponentaY, q))
    push!(pozNaboji, Naboj(komponentaX, komponentaY, q))
end
for j in 1:m
    komponentaX = rand() * (maxX + abs(minX)) - abs(minX)
    komponentaY = rand() * (maxY + abs(minY)) - abs(minY)
    push!(naboji, Naboj(komponentaX, komponentaY, -q))
    push!(negNaboji, Naboj(komponentaX, komponentaY, -q))
end

##izracun 
Rx = xG .- naboji[1].x 
Ry = yG .- naboji[1].y 
R = sqrt.(Rx.^2 + Ry.^2).^3
Ex = k .* naboji[1].q .* Rx ./ R
Ey = k .* naboji[1].q .* Ry ./ R
for i in 2:(m + n)
    Rx = xG .- naboji[i].x
    Ry = yG .- naboji[i].y
    R = sqrt.(Rx.^2 + Ry.^2).^3
    Ex += k .* naboji[i].q .* Rx ./ R
    Ey += k .* naboji[i].q .* Ry ./ R
end
E = sqrt.(Ex.^2 + Ey.^2)

##izračun x i y komponenti polja
u = Ex ./ E
v = Ey ./ E

##vizualizacija rezultata 
using Plots
gr()
vrijednostiXpozNaboja = [naboj.x for naboj in pozNaboji]
vrijednostiYpozNaboja = [naboj.y for naboj in pozNaboji]
vrijednostiXnegNaboja = [naboj.x for naboj in negNaboji]
vrijednostiYnegNaboja = [naboj.y for naboj in negNaboji]

Plots.scatter(vrijednostiXpozNaboja, vrijednostiYpozNaboja, label = "Pozitivni naboj ", aspect_ratio=:equal, color=RGB(0, 0, 1))
Plots.scatter!(vrijednostiXnegNaboja, vrijednostiYnegNaboja, label = "Negativni naboj ", aspect_ratio=:equal, color=RGB(1, 0, 0))

for i = 1:N
    display(quiver!(xG[i,:],yG[i,:],quiver=(u[i,:]/15,v[i,:]/15)))
end