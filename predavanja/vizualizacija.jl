using Plots

plotly()
gr()

x = 1:0,1:(2*pi)
y = cos.(x).^2

plot(x, y, label = "cos(x)^2")
plot!(xlab="x", ylab="f(x)")

savefig("prvi_img.png")