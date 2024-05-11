global m=70
global cd=0.25
global g=9.81

function deriva(v)
    dv=g-((cd/m)*v*abs(v))
    return dv
end

function brzina2(v0,dt,tp,tk) # v0-pocetna vrijednost brzine (ovisne varijable),dt-vremenski korak, tp-pocetno vrijeme, tk-konacno vrijeme 
    vi=v0
    ti=tp
    s=dt # unosimo ovu varijablu da bi po potrebi negdje drugdje kasnije znali vrijednost dt
    br=zeros(0) # vektor za spremanje brzine svakog intervala (ovaj put zelimo vratiti brzinu u svakoj tocci, ne samo onu na kraju intervala)
    vrijeme=zeros(0) # 
    put=zeros(0) # ako zelimo prijedeni put u svakom koraku radimo ovaj vektor
    p=0 # za izracun puta
    while true
        if ti+dt>tk # testiranje da ne idemo preko konacnog intervala
            s=tk-ti # ako idemo preko intervala onda skracujemo vrijeme koraka - time garantiramo da ce korak završiti na tk
        end
        dvdt= deriva(vi)
        append!(br,vi) # da bi imali brzinu u svakom intervalu
        append!(vrijeme, ti)
        append!(put,p)
        p=p-vi*s 
        vi=vi+dvdt*s
        ti=ti+s
        if ti>=tk # kada je vrijeme ti vece od konacnog vremena intervala prekidamo petlju
            break
        end
        #println("$i")
    end
    append!(br,vi) # da bi imali brzinu u svakom intervalu
    append!(vrijeme, ti)
    append!(put,p)
    return vi, br, vrijeme, put
end

rez, brzi, vrijeme, put = brzina2(0,0.5,0,14) #numericko rjesenje za brzinu i put
t = 0:0.5:14
t = collect(t) #vrijeme za analiticko
v = sqrt((g*m)/cd).*tanh.(sqrt.((g*cd)/m).*t) #analiticko rjesenje brzine

absolute_error_v = abs.(v - brzi) #apsolutna greska za brzinu
rel_error_v = (absolute_error ./ v) .* 100 #relativna greska za brzinu
print(rel_error_v) 

#plot za brzine 
using(Plots)
plot(vrijeme, brzi, label="Brzina ovisno o vremenu - numeričko", legend = :bottomright) 
plot!(xlab="t [s]", ylab="v [m/s]")
plot!(t, v, label="Brzina ovisno o vremenu - analitičko", legend = :bottomright)

s = -m.*log.(cosh.(t.*(sqrt.((cd.*g)./m))))./cd #analiticko rjesenje puta (WolframAlpha izracunao)
absolute_error_s = abs.(s - put) #apsolutna greska za put
rel_error_s = (absolute_error_s ./ s) .* 100 #relativna greska za put
print(rel_error_s)

#plot za puteve
plot(vrijeme, put, label="Put ovisno o vremenu - numeričko", legend = :bottomright) 
plot!(xlab="t [s]", ylab="s [m/s]")
plot!(t, s, label="Put ovisno o vremenu - analitičko", legend = :bottomright)