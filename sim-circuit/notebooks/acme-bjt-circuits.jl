### A Pluto.jl notebook ###
# v0.16.1

using Markdown
using InteractiveUtils

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


# ╔═╡ eea40830-be91-428d-a9ff-4412e2f80b82
begin

# TODO: refactor to function -> (function -> circuit)
	
	
# common emitter
# common collector
# common base

	
function bjt_common_emitter(::Type{Circuit}; vol=nothing)
	@circuit begin
		# ⟷ \longleftrightarrow
		Vs = voltagesource(), [-] ⟷ gnd
		Rs = resistor(600), [1] ⟷ Vs[+]
		Cs = capacitor(2.2e-6), [1] ⟷ Rs[2]
				
		VCC = voltagesource(18), [-] ⟷ vcc
		R1 = resistor(27.0e3), [1] ⟷ Cs[2], [2] ⟷ VCC[+]
		R2 = resistor(3.9e3), [1] ⟷ Cs[2], [2] ⟷ gnd
		
		Q1 = bjt(:npn, isc=154.1e-15, ise=64.53e-15, ηc=1.10, ηe=1.06, βf=500, βr=12), [base] ⟷ Cs[2]
			
		Re1 = resistor(200), [1] ⟷ Q1[emitter]
		Re2 = resistor(270), [1] ⟷ Re1[2], [2] ⟷ gnd
		Ce = capacitor(47e-6), [1] ⟷ Re2[1], [2] ⟷ gnd 
			
		Rc = resistor(2.7e3), [1] ⟷ Vs[+], [2] ⟷ Q1[collector]
		Cc = capacitor(1e-6), [1] ⟷ Q1[collector]
		Rl = resistor(47e3), [1] ⟷ Cc[2], [2] ⟷ gnd
			
		# TODO: replace Rl with a potentiometer
		
		ProbeOut = voltageprobe(), [-] ⟷ gnd, [+] ⟷ Rl[1]
		ProbeQbGnd = voltageprobe(), [-] ⟷ gnd, [+] ⟷ Q1[base]
		ProbeQeGnd = voltageprobe(), [-] ⟷ gnd, [+] ⟷ Q1[emitter]
	end
end #linearization_error
	
bjt_common_emitter(::Type{DiscreteModel}=DiscreteModel; vol=nothing, fs=44100, solver=nothing) =
    solver === nothing ?
        DiscreteModel(bjt_common_emitter(Circuit, vol=vol), 1//fs) :
        DiscreteModel(bjt_common_emitter(Circuit, vol=vol), 1//fs, solver)
	
end

# ╔═╡ 6ee7a4b8-61e2-493a-88d4-ca05139d46b0
begin
	f = 60
	u = [
		 sin.(2π * (f/44100) * (0:44099)'); 
		 #range(1, stop=0, length=44100)' #when using a potentiometer as 2nd input
		] 
	model = bjt_common_emitter()
	y = run!(model, u, showprogress=true)
end


# ╔═╡ e65a5f44-190a-4017-9e90-e314bf5baad9
# 0 <= t <= 1
# u := AC input
# y := [probe1; probe2; probe3]
#[range(0, stop=,1 length=44100)'; u; y]

# ╔═╡ 3b86cf07-52db-4113-ba09-a36ede730b0f
begin
	npoints = 4000
	
	time_domain = range(1, stop=0, length=44100)';
	
plot(time_domain[1:npoints], u[1:npoints], title = "We're in a simulation", label = "AC Voltage")

plot!(time_domain[1:npoints], y[1,1:npoints], label = "V Out")
plot!(time_domain[1:npoints], y[2,1:npoints], label = "Q1[bias] to GND")
plot!(time_domain[1:npoints], y[3,1:npoints], label = "Q1[emitter] to GND")
end

# ╔═╡ b3b8044c-fdf5-40d9-a9e0-b8f9cd0ffb21


# ╔═╡ 7bdc43e3-12c9-4183-ba9e-2fcc38a1f087
y

# ╔═╡ Cell order:
# ╠═2ded4703-7224-4c12-9bab-03654f729d5f
# ╠═1ae0743b-3706-46b6-98cc-497a2295b84f
# ╠═c191db29-cd9d-4756-995f-2455bd47947a
# ╠═eea40830-be91-428d-a9ff-4412e2f80b82
# ╠═6ee7a4b8-61e2-493a-88d4-ca05139d46b0
# ╠═e65a5f44-190a-4017-9e90-e314bf5baad9
# ╠═3b86cf07-52db-4113-ba09-a36ede730b0f
# ╠═b3b8044c-fdf5-40d9-a9e0-b8f9cd0ffb21
# ╠═7bdc43e3-12c9-4183-ba9e-2fcc38a1f087
