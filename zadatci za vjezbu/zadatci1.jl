##1. zad
x = y = 1
x
y

##2. zad
15 = a

##3. zad
xy 
x*y

##4. zad
function volumen(a, oznaka)
    if oznaka == "kocka"
        V = a^3
    elseif oznaka == "sfera"
        V = 4 // 3 * pi * a^3
    else 
        V = "Ne radi se o sferi ni kocki"
    end
    return V
end

volumen(2, "kocka")
volumen(2, "sfera")
volumen(2, "piramida")

##5. zad
function absolute(broj)
    if broj < 0
        broj = -broj
    end
    return broj
end
absolute(2)
absolute(-2)

##6. zad - prva varijanta
function udaljenostDvijeTocke(x1, y1, x2, y2)
    return sqrt((x2 - x1)^2 + (y2 - y1)^2)
end
udaljenostDvijeTocke(1, 1, 2, 2)

##6. zad - druga varijanta
struct Point
    x::Real
    y::Real
    Point(x,y) = new(x,y)
end

function udaljenostDvijeTocke(p1::Point, p2::Point)
    return sqrt((p2.x - p1.x)^2 + (p2.y - p1.y)^2)
end

udaljenostDvijeTocke(Point(1,1), Point(2,2))

##7. zad
i = 1
while i <= 30
    if i % 3 != 0
        println(i)
    end
    i += 1
end

##8. zad
function numberOfLetters(value::Char, expression::String)
    count = 0
    for i in eachindex(expression)
        if expression[i] == value
            count += 1
        end
    end
    return count
end

numberOfLetters('a', "Volim studirati u Zagrebu.")