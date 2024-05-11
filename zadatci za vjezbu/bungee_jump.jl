using DifferentialEquations
using Plots 

#stalni parametri za sve slucajeve
L = 25 #duljina uzeta, maslenicki most na visini od 55m, a uze se moze rastegnut max 2 puta od nerastegnutog
cd = 0.25 #koeficijent otpora zraka
gamma = 8 #koeficijent prigusenja

skok = function(du, u, p, t) #prema dokumentaciji je potrebno ovako zadati funkciju. du oznacava derivacije puta i brzine, u pocetne vrijednosti puta i brine, p daje parametre a t vrijeme u kojem se provodi
    L, cd, m, k, gamma = p
    g = 9.81
    opruga = 0
    pocetni_put = u[1]
    pocetna_brzina = u[2]
    if pocetni_put > L # ako je nategnuto uze onda opruga doprinosi za:
        opruga = (k/m) * (pocetni_put - L) + (gamma/m) * pocetna_brzina
    end
    du[1] = pocetna_brzina
    du[2] = g-pocetna_brzina * abs(pocetna_brzina) * (cd/m) - opruga
end

#= ciljao sam na to da onaj tko skace otprilike prijede oko 52m tako da
ostane oko 3m u zraku, pa i na plotovima sve krivulje prate to razmisljanje =#

##m = 60kg
m = 60 
k = 65 
p = (L, cd, m, k, gamma) 
u0 = [0.0;0.0]; 
tspan = (0.0,50.0) 
problem = ODEProblem(skok,u0,tspan,p); 
sol = solve(problem) 
gr() 
plot(sol, vars=(0,1), title = "Bungee skok", label = "Put za m = 60kg, k = 65 kgs^-2", legend = :bottomright, xlab = "t [s]", ylab = "x [m]")

##m = 65kg
m = 65
k = 72
p = (L, cd, m, k, gamma) 
u0 = [0.0;0.0]; 
tspan = (0.0,50.0) 
problem = ODEProblem(skok,u0,tspan,p); 
sol = solve(problem) 
plot!(sol, vars=(0,1), title = "Bungee skok", label = "Put za m = 65kg, k = 72 kgs^-2", legend = :bottomright, xlab = "t [s]", ylab = "x [m]")

##m = 70kg
m = 70
k = 78
p = (L,cd,m,k, gamma) 
u0 = [0.0;0.0]; 
tspan = (0.0,50.0) 
problem = ODEProblem(skok,u0,tspan,p); 
sol = solve(problem) 
plot!(sol, vars=(0,1), title = "Bungee skok", label = "Put za m = 70kg, k = 78 kgs^-2", legend = :bottomright, xlab = "t [s]", ylab = "x [m]")

##m = 75kg
m = 75
k = 82
p = (L,cd,m,k, gamma) 
u0 = [0.0;0.0]; 
tspan = (0.0,50.0) 
problem = ODEProblem(skok,u0,tspan,p); 
sol = solve(problem) 
plot!(sol, vars=(0,1), title = "Bungee skok", label = "Put za m = 75kg, k = 82 kgs^-2", legend = :bottomright, xlab = "t [s]", ylab = "x [m]")

##m = 80kg
m = 80
k = 85
p = (L,cd,m,k, gamma) 
u0 = [0.0;0.0];
tspan = (0.0,50.0) 
problem = ODEProblem(skok,u0,tspan,p); 
sol = solve(problem) 
plot!(sol, vars=(0,1), title = "Bungee skok", label = "Put za m = 80kg, k = 85 kgs^-2", legend = :bottomright, xlab = "t [s]", ylab = "x [m]")

#= za skakace s vecom kilazom, potrebno je povecati konstantu elasticnosti uzeta =#