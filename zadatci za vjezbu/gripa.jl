using DifferentialEquations
using Plots
##SIR 
S = 4088000 #stanovnistvo Hrvatske 2018. (podlozni)
I = 5000  #broj zaraženih
R = 0  #broj oporavljenih
k = 9  #broj kontakata na dan
b = 0.03 #vjerojatnost da se zaraza širi kontaktom
t_oporavka = 10  #koliko dana je osoba zaražena

N = S + I + R # ukupan broj ljudi 
beta = (k * b) /N # stopa zarazenosti
gamma = 1 / t_oporavka # stopa t_oporavka

SIR_osnovni = function (du, u, p, t) 
    beta, gamma= p
    du[1] = -beta * u[1] * u[2]
    du[2] = beta * u[1] * u[2] - gamma * u[2]
    du[3] = u[2] * gamma
end
p = (beta, gamma)
u0 = [S;I;R]; # podesavanje pocetnih uvjeta 
tspan = (0.0,14*7) # vrijeme gledamo u danima, gledamo pola semestra 
problem = ODEProblem(SIR_osnovni, u0, tspan, p); 
sol = solve(problem) 

plot(sol,vars=(0,1),title="SIR model zaraženosti",label="Podložni bolesti", legend = :topright)
plot!(sol,vars=(0,2),label="Zaraženi", legend = :topright)
plot!(sol,vars=(0,3),label="Oporavljeni", legend = :topright)
plot!(xlab="Vrijeme", ylab="Broj ljudi")

#= Ovaj model definitivno nije dobar za sezonu gripe 2018/2019 u Hrvatskoj.
Bilo je sluzbeno registriranih 48 000 oboljelih od gripe, pa neka je i 4 puta
vise ih bilo nego sto ih je registrirano, ovaj model predvida preko milijun oboljelih od gripe.
S druge strane, ako bi dalje smanjivao k ili b, sezona gripe traje predugo, a povecavanje broja
zarazenih jos vise je nerealno =#

##SIRS
S = 4088000 #stanovnistvo Hrvatske 2018. (podlozni)
I = 1000  #broj zaraženih
R = 0  #broj oporavljenih
k = 9  #broj kontakata na dan
b = 0.03 #vjerojatnost da se zaraza širi kontaktom
t_oporavka = 10  #koliko dana je osoba zaražena

N = S + I + R # ukupan broj ljudi 
beta = (k * b) /N # stopa zarazenosti
gamma = 1 / t_oporavka # stopa t_oporavka
delta = 0.01
SIRS = function (du, u, p, t) 
    beta, gamma, delta= p
    du[1] = -beta * u[1] * u[2] + delta * u[3]
    du[2] = beta * u[1] * u[2] - gamma * u[2]
    du[3] = u[2] * gamma - delta * u[3]
end
p = (beta, gamma, delta)
u0 = [S;I;R]; # podesavanje pocetnih uvjeta 
tspan = (0.0,14*7) # vrijeme gledamo u danima, gledamo pola semestra 
problem = ODEProblem(SIRS, u0, tspan, p); 
sol = solve(problem) 

plot(sol,vars=(0,1),title="SIRS model zaraženosti",label="Podložni bolesti", legend = :topright)
plot!(sol,vars=(0,2),label="Zaraženi", legend = :topright)
plot!(sol,vars=(0,3),label="Oporavljeni", legend = :topright)
plot!(xlab="Vrijeme", ylab="Broj ljudi")

#= Slicna prica kao i u SIR modelu =#

##SIR + demografija
S = 4088000 #stanovnistvo Hrvatske 2018. (podlozni)
I = 1000  #broj zaraženih
R = 0  #broj oporavljenih
k = 7  #broj kontakata na dan
b = 0.04 #vjerojatnost da se zaraza širi kontaktom
t_oporavka = 10  #koliko dana je osoba zaražena

N = S + I + R # ukupan broj ljudi 
beta = (k * b) /N # stopa zarazenosti
gamma = 1 / t_oporavka # stopa t_oporavka
mi = 0.0129  #stopa mortaliteta u RH 2018
eta = 0.009  #stopa nataliteta u RH 2018

SIR_dem = function (du, u, p, t) 
    beta, gamma, mi, eta= p
    du[1] = -beta * u[1] * u[2] + eta * (u[1] + u[2] + u[3]) - mi * u[1]
    du[2] = beta * u[1] * u[2] - gamma * u[2] - mi * u[2]
    du[3] = u[2] * gamma - mi * u[3]
end
p = (beta, gamma, mi, eta)
u0 = [S;I;R]; # podesavanje pocetnih uvjeta 
tspan = (0.0,14*7) # vrijeme gledamo u danima, gledamo pola semestra 
problem = ODEProblem(SIR_dem, u0, tspan, p); 
sol = solve(problem) 

plot(sol,vars=(0,1),title="SIR + demografija model zaraženosti",label="Podložni bolesti", legend = :topright)
plot!(sol,vars=(0,2),label="Zaraženi", legend = :topright)
plot!(sol,vars=(0,3),label="Oporavljeni", legend = :topright)
plot!(xlab="Vrijeme", ylab="Broj ljudi")

#= Ovaj model dosad je mozda i najvjerodostojniji dosad pravoj situaciji koja je bila 2018/2019 =#

##SIR + demografija + cijepljenje
S = 4088000 #stanovnistvo Hrvatske 2018. (podlozni)
I = 1000  #broj zaraženih
R = 0  #broj oporavljenih
k = 7  #broj kontakata na dan
b = 0.04 #vjerojatnost da se zaraza širi kontaktom
t_oporavka = 10  #koliko dana je osoba zaražena

N = S + I + R # ukupan broj ljudi 
beta = (k * b) /N # stopa zarazenosti
gamma = 1 / t_oporavka # stopa t_oporavka
mi = 0.0129  #stopa mortaliteta u RH 2018
eta = 0.009  #stopa nataliteta u RH 2018
kappa = 0.005 #procijepljenost rodenih

SIR_dem_vac = function (du, u, p, t) 
    beta, gamma, mi, eta, kappa = p
    du[1] = -beta * u[1] * u[2] + (eta - kappa) * (u[1] + u[2] + u[3]) - mi * u[1]
    du[2] = beta * u[1] * u[2] - gamma * u[2] - mi * u[2]
    du[3] = u[2] * gamma - mi * u[3]
end
p = (beta, gamma, mi, eta, kappa)
u0 = [S;I;R]; # podesavanje pocetnih uvjeta 
tspan = (0.0,14*7) # vrijeme gledamo u danima, gledamo pola semestra 
problem = ODEProblem(SIR_dem_vac, u0, tspan, p); 
sol = solve(problem) 

plot(sol,vars=(0,1),title="SIR + demografija + cijepljenje model zaraženosti",label="Podložni bolesti", legend = :topright)
plot!(sol,vars=(0,2),label="Zaraženi", legend = :topright)
plot!(sol,vars=(0,3),label="Oporavljeni", legend = :topright)
plot!(xlab="Vrijeme", ylab="Broj ljudi")

#= Za kappa = 0.005 se dobije jos ponajbolji model. =#

##SEIR
S = 4088000 #stanovnistvo Hrvatske 2018. (podlozni)
E = 1000 #broj zaraznih
I = 500  #broj zaraženih
R = 0  #broj oporavljenih
k = 14  #broj kontakata na dan
b = 0.05 #vjerojatnost da se zaraza širi kontaktom
t_oporavka = 10  #koliko dana je osoba zaražena

N = S + E + I + R # ukupan broj ljudi 
beta = (k * b) /N # stopa zarazenosti
gamma = 1 / t_oporavka # stopa t_oporavka
mi = 0.0129  #stopa mortaliteta u RH 2018
eta = 0.009  #stopa nataliteta u RH 2018
kappa = 0.005 #procijepljensot rodenih
theta = 0.1  #stopa prijelaza iz E u I

SEIR = function (du, u, p, t) 
    beta, gamma, mi, eta, kappa, theta = p
    du[1] = -beta * u[1] * u[3] + (eta - kappa) * (u[1] + u[2] + u[3] + u[4]) - mi * u[1]
    du[2] = beta * u[1] * u[3] - theta * u[2] - mi * u[2]
    du[3] = theta * u[2] - gamma * u[3] - mi * u[3]
    du[4] = u[3] * gamma - mi * u[4]
end
p = (beta, gamma, mi, eta, kappa, theta)
u0 = [S;E;I;R]; # podesavanje pocetnih uvjeta 
tspan = (0.0,14*7) # vrijeme gledamo u danima, gledamo pola semestra 
problem = ODEProblem(SEIR, u0, tspan, p); 
sol = solve(problem) 

plot(sol,vars=(0,1),title="SEIR model zaraženosti",label="Podložni bolesti", legend = :topright)
plot!(sol,vars=(0,2),label="Zarazni", legend = :topright)
plot!(sol,vars=(0,3),label="Zaraženi", legend = :topright)
plot!(sol,vars=(0,4),label="Oporavljeni", legend = :topright)
plot!(xlab="Vrijeme", ylab="Broj ljudi")

#= Dobiven je slican model kao i prethodni =#