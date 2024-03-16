##1. zad

function celsiusConvert(value::Real, otherUnit::String)
    result = 0
    if lowercase(otherUnit) == "kelvin"
        result = value + 273.15
    elseif lowercase(otherUnit) == "fahrenheit"
        result = (value * (9/5)) + 32
    else
        result = "Krivi input"
    end
end

celsiusConvert(0, "kelvin")
celsiusConvert(20, "fahrenheit")
celsiusConvert(-20, "fahrenheit")
celsiusConvert(0, "aaa")

##2. zad
function povrsinaTrokuta(; kateta1 = nothing, kateta2 = nothing, hipotenuza = nothing)
    #dvije katete 
    if (!isnothing(kateta1) && !isnothing(kateta2)) || (!isnothing(kateta1) && !isnothing(kateta2) && !isnothing(hipotenuza))
        return 0.5 * kateta1 * kateta2
    #kateta i hipotenuza
    elseif !isnothing(kateta1) && !isnothing(hipotenuza)
        kateta2 = sqrt(hipotenuza^2 - kateta1^2)
        return kateta2 * kateta1 * 0.5
    elseif !isnothing(kateta2) && !isnothing(hipotenuza)
        kateta1 = sqrt(hipotenuza^2 - kateta2^2)
        return kateta1 * kateta2 * 0.5
    #krivi input
    else 
        return "Krivi input"
    end
end

povrsinaTrokuta(3, 4)
povrsinaTrokuta(kateta1 = 3, hipotenuza = 5)
povrsinaTrokuta(kateta2 = 3, hipotenuza = 5)

##3. zad
function povrsinaTrokuta(a, b, c)
    s = 0.5 * (a + b + c)
    return sqrt(s * (s - a) * (s - b) * (s - c))
end

povrsinaTrokuta(3, 4, 5)
