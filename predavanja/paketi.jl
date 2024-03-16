#primjer instaliranja i koristenja paketa
using Pkg  #uvijek treba prvo pokrenuti modul Packages . Pkg
Pkg.status() #naredba omogućuje nam da provjerimo koje pakete imamo instalirane
Pkg.update() #naredba radi update paketa
Pkg.add("Plots") #ovom nardebom dodajemo nove sluzbene pakete
using Plots #kada paket imamo dodan, prije svakog korištenja moramo koristiti ovu naredbu