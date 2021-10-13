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
	Pkg.add("NgSpice")
	using NgSpice
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
	# from NgSpice.jl
	n = NgSpice

	netpath = joinpath(@__DIR__, "..", "circuits", "mosfet.cir") |> normpath

	n.init()
	n.source(netpath)
	n.run()
	n.display()        # Returns a dataframe of current vectors 
	n.listallvecs()    # Lists vectors of both active and inactive plots
	n.curplot()        # Current active plot
	n.listcurvecs()    # Vectors in current active plot

	# For plotting the signals, pass `n.graph` an object of `NgSpiceGraphs` type.
	# And then, specify the get-vector method.
	# Pass "time" or "frequency"
	# List of signals to plot
	# Finally, the title of the plot
	# plot(n.graph, n.getimagvec, "time", ["emit", "vcc"], "Simple MOSFET")
	# plot(n.graph, n.getrealvec, "time", ["emit", "vcc"], "Simple MOSFET")
end

# ╔═╡ 7cf2b2f5-3e64-4300-aa6e-3bd0c0a58dca
# imaginary vectors
plot(n.graph, n.getimagvec, "time", ["emit", "vcc"], "Simple MOSFET")

# ╔═╡ b3b8044c-fdf5-40d9-a9e0-b8f9cd0ffb21
# real vectors
plot(n.graph, n.getrealvec, "time", ["emit", "vcc"], "Simple MOSFET")

# ╔═╡ ae175083-ee6e-4d29-946f-6b5915ed8775


# ╔═╡ Cell order:
# ╠═02fb317c-2c3f-11ec-23c9-1b08e81f8d75
# ╠═2ded4703-7224-4c12-9bab-03654f729d5f
# ╠═1ae0743b-3706-46b6-98cc-497a2295b84f
# ╠═c191db29-cd9d-4756-995f-2455bd47947a
# ╠═eea40830-be91-428d-a9ff-4412e2f80b82
# ╠═7cf2b2f5-3e64-4300-aa6e-3bd0c0a58dca
# ╠═b3b8044c-fdf5-40d9-a9e0-b8f9cd0ffb21
# ╠═ae175083-ee6e-4d29-946f-6b5915ed8775
