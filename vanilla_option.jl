include("payoff.jl")

@enum OptionType begin
	Call
	Put
end

struct VanillaOption
    expiry::Float64
    payoff::Payoff
end

function calcPayoff(self::VanillaOption, spot::Float64)
    return calcPayoff(self.payoff, spot)
end
