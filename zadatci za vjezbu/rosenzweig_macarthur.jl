using DifferentialEquations
using Plots

Rosenzweig_MacArthur = function (du, u, p, t) 
    alfa, beta, gamma, delta, K, b = p
    du[1] = u[1] * (alfa * (1 - u[1] / K) - beta * (u[2] / (b + u[1])))
    du[2] = -u[2] * (gamma - delta * u[1] / (b + u[1]))
end

alfa = 0.95 #stopa rasta populacije plijena
beta = 0.65 #stopa mortaliteta populacije plijena
gamma = 0.52 #stopa mortaliteta populacije grabezljivaca
delta = 0.7 #stopa rasta populacije grabezljivaca
K = 150 #nosivost populacije plijena
b = 15 #stopa kojom svaki grabezljivac konzumira plijen
p = (alfa, beta, gamma, delta, K, b)
u0 = [30.0;60.0] #1 plijen na 2 grabezljivca 
tspan = (0.0, 300.0)
problem = ODEProblem(Rosenzweig_MacArthur,u0,tspan,p); 
sol = solve(problem) 

plot(sol,vars=(1,2),title="Grabežljivac - plijen _ RM model", legend = :topright, xlab = "Populacija plijena", ylab = "Populacija grabezljivaca")

#= Za ove parametre dobije se graf koji krene sa 60 grabezljivaca i 30 jedinki plijena
pri cemu broj grabezljivaca se smanjuje kao i populacija plijena, medutim nakon toga se
sustav stabilizira i ima izmjena perioda kada je dominantna populacija grabezljivaca,
a period kada je dominantnija populacija plijena. Valja istaknut da je model donekle ok
jer se nikad populaciji niti plijena, niti grabezljivaca ne smanji na 0. =#