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

# ╔═╡ 2ded4703-7224-4c12-9bab-03654f729d5f
begin
	import Pkg
	Pkg.activate(mktempdir())
end

# ╔═╡ 1ae0743b-3706-46b6-98cc-497a2295b84f
begin
	Pkg.add(["Pluto","PlutoUI", "Plots"])
	using Pluto, PlutoUI, Plots
end

# ╔═╡ c191db29-cd9d-4756-995f-2455bd47947a
begin
	Pkg.add("ACME")
	using ACME
end

# ╔═╡ 02fb317c-2c3f-11ec-23c9-1b08e81f8d75
begin
	using Markdown
	using InteractiveUtils

	macro bind(def, element)
		quote
			local el = $(esc(element))
			global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
			el
		end
	end
end


# ╔═╡ eea40830-be91-428d-a9ff-4412e2f80b82
begin

end

# ╔═╡ 7cf2b2f5-3e64-4300-aa6e-3bd0c0a58dca
begin

end

# ╔═╡ b3b8044c-fdf5-40d9-a9e0-b8f9cd0ffb21
begin

end

# ╔═╡ 4396d03d-5d53-4d7d-b198-dc47be8b9f24
md"Time step length: **δt** $(@bind δt Slider(0.0001 : 0.0001 : 1.0000, default=0.0002, show_value=true))"

# ╔═╡ c2fed728-5626-48dd-97e2-a9b3cac27b86
md"Time steps: **T** $(@bind T Slider(10 : 1 : 10000, default=1000, show_value=true))"

# ╔═╡ a6c3e1dc-9825-4dd9-a089-a24de6c52c52
md"AC Frequency: **f** $(@bind f Slider(1 : 0.01 : 10000, default=500, show_value=true))"


# ╔═╡ ae175083-ee6e-4d29-946f-6b5915ed8775
begin

# Copyright 2016, 2017, 2018 Martin Holters
# See accompanying license file.

# Model of "Der Birdie", see
# http://diy.musikding.de/wp-content/uploads/2013/06/birdieschalt.pdf
# for schematics.
# Note: Contrary to the schematics, in the real circuit as well as in this
# model, C5 and D1 are connected directly to the power supply; R6 is in series
# with LED1 only, which has been omitted from the model, though.

function birdie(::Type{Circuit}; vol=nothing)
    @circuit begin
        j3 = voltagesource(9), [-] ⟷ gnd, [+] ⟷ vcc # 9V power supply
        c5 = capacitor(100e-6), [1] ⟷ gnd, [2] ⟷ vcc
        d1 = diode(is=350e-12, η=1.6), [-] ⟷ vcc, [+] ⟷ gnd
        j1 = voltagesource(), [-] ⟷ gnd # input
        r1 = resistor(1e6), [1] ⟷ j1[+], [2] ⟷ gnd
        c1 = capacitor(2.2e-9), [1] ⟷ j1[+]
        r2 = resistor(43e3), [1] ⟷ c1[2], [2] ⟷ gnd
        r3 = resistor(430e3), [1] ⟷ c1[2], [2] ⟷ vcc
        t1 = bjt(:npn, isc=154.1e-15, ise=64.53e-15, ηc=1.10, ηe=1.06, βf=500, βr=12),
             [base] ⟷ c1[2]
        r4 = resistor(390), [1] ⟷ t1[emitter], [2] ⟷ gnd
        r5 = resistor(10e3), [1] ⟷ t1[collector], [2] ⟷ vcc
        c3 = capacitor(2.2e-9), [1] ⟷ t1[collector]
        p1 = potentiometer(100e3, (vol == nothing ? () : (vol,))...), [1] ⟷ gnd, [3] ⟷ c3[2]
        j2 = voltageprobe(), [-] ⟷ gnd, [+] ⟷ p1[2]# output
    end
end

birdie(::Type{DiscreteModel}=DiscreteModel; vol=nothing, fs=44100, solver=nothing) =
    solver === nothing ?
        DiscreteModel(birdie(Circuit, vol=vol), 1//fs) :
        DiscreteModel(birdie(Circuit, vol=vol), 1//fs, solver)
end

# ╔═╡ 3ff0c32b-0711-4d6d-8258-924e5a0ec2b1
md"`ac_voltage_source` will take a function generator and the simulation parameters **δt, T, f** and generate a vector representing the 1D timeseries."

# ╔═╡ a256ee4e-d367-44e1-a9ef-342013540748
#function ac_voltage_source(Vector{T})
#
#end

# ╔═╡ 1c36c669-0072-4db7-8b32-d01389a422d9
md"`circuit_input` will specify how input sources are to be combined to produce the matrix **u**"

# ╔═╡ e0bd4fa0-ad0f-4b1e-84ad-48997e3fba6c
# TODO: should this function handle simulation parameters (or other functions like ac_voltage_source)

#function circuit_input(...?)
#
#end

# ╔═╡ f1ca0a1e-b1dc-4ee1-987c-2e8914d6a7ec
begin
	
# There are two inputs and one output for this circuit
# - j3: constant 9V input
# - j1: AC(?) voltage source connected to ground
# - j2: voltage probe
	
# The matrix u needs to be supplied:
# - j1: sinusoidal function outputs
# - t: timesteps
	
#u = Float
#y = run!(birdie, u

end

# ╔═╡ Cell order:
# ╠═02fb317c-2c3f-11ec-23c9-1b08e81f8d75
# ╠═2ded4703-7224-4c12-9bab-03654f729d5f
# ╠═1ae0743b-3706-46b6-98cc-497a2295b84f
# ╠═c191db29-cd9d-4756-995f-2455bd47947a
# ╠═eea40830-be91-428d-a9ff-4412e2f80b82
# ╠═7cf2b2f5-3e64-4300-aa6e-3bd0c0a58dca
# ╠═b3b8044c-fdf5-40d9-a9e0-b8f9cd0ffb21
# ╠═4396d03d-5d53-4d7d-b198-dc47be8b9f24
# ╠═c2fed728-5626-48dd-97e2-a9b3cac27b86
# ╠═a6c3e1dc-9825-4dd9-a089-a24de6c52c52
# ╠═ae175083-ee6e-4d29-946f-6b5915ed8775
# ╠═3ff0c32b-0711-4d6d-8258-924e5a0ec2b1
# ╠═a256ee4e-d367-44e1-a9ef-342013540748
# ╠═1c36c669-0072-4db7-8b32-d01389a422d9
# ╠═e0bd4fa0-ad0f-4b1e-84ad-48997e3fba6c
# ╠═f1ca0a1e-b1dc-4ee1-987c-2e8914d6a7ec
