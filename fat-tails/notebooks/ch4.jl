### A Pluto.jl notebook ###
# v0.16.1

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 15a5fbe6-6c09-11eb-2300-0f8ca4b82e05
begin
	using Pkg

    if haskey(ENV, "PLUTO_FAT_TAILS")
        # TODO: would this already be implicity activated?
        Pkg.activate(ENV["PWD"])
    else
        Pkg.activate(mktempdir())
    end
end

# ╔═╡ 8644cb5c-6c13-11eb-1c38-874239460f47
begin
    if !haskey(ENV, "PLUTO_FAT_TAILS")
        Pkg.add(["Plots", "StatsPlots", "Distributions", "PlutoUI"])
        # Pkg.add(["Plots", "StatsPlots", "BenchmarkTools",
        #      "PlutoUI",
        #      "Parameters", "LinearAlgebra",
        #      "Random", "Distributions", "Expectations", "Statistics"])
    end

    using Plots, StatsPlots, Distributions, PlutoUI
    # using Plots, StatsPlots, BenchmarkTools,
    #     PlutoUI,
    #     Parameters, LinearAlgebra,
    #     Random, Distributions, Expectations, Statistics
end


# ╔═╡ d68b3dd2-6c16-11eb-2875-493d13b6ed6c
md"""
### 4.1 A Simple Heuristic to Create Mildly Fat Tails

"""

# ╔═╡ 2dfcc022-6c17-11eb-3fe5-71151e3934f5
md"Mean Deviation of Stochastic Volatility: $(@bind vvolMeanDeviation Slider(0.01 : 0.01 : 0.99, show_value=true))"

# ╔═╡ f31dec72-6c13-11eb-14bc-0f667ad84ff3
begin
	# technically, you must sample these to get the fat-tailed distribution
	d1 = Normal(0,sqrt(1-vvolMeanDeviation))
	d2 = Normal(0,sqrt(1+vvolMeanDeviation))
end

# ╔═╡ 54080f84-6c1b-11eb-3d00-ff39bcd8d7e6
begin
	plot(d1)
	plot!(d2)
end	

# ╔═╡ d8c99cd2-6c1c-11eb-26ad-eb6576883129
# TODO: plot the ideal ((d1+d2)/2) and param-averaged distributions

# ╔═╡ bf1b7182-6c1b-11eb-06ea-f3cdcda078de
# TODO: average 1k-10k samples from (d1 || d2)
# TODO: plot resulting distribution alongside ideal distributions
# TODO: track mean over # samples to see the magnitude of impact from kurtosis (CLT)

# ╔═╡ Cell order:
# ╠═15a5fbe6-6c09-11eb-2300-0f8ca4b82e05
# ╠═8644cb5c-6c13-11eb-1c38-874239460f47
# ╠═d68b3dd2-6c16-11eb-2875-493d13b6ed6c
# ╠═2dfcc022-6c17-11eb-3fe5-71151e3934f5
# ╠═f31dec72-6c13-11eb-14bc-0f667ad84ff3
# ╠═54080f84-6c1b-11eb-3d00-ff39bcd8d7e6
# ╠═d8c99cd2-6c1c-11eb-26ad-eb6576883129
# ╠═bf1b7182-6c1b-11eb-06ea-f3cdcda078de
