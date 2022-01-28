using Distributions

include("vanilla_option.jl")

function blackFormula(forward::Float64, vol::Float64,
    expiry::Float64, strike::Float64, type::OptionType, annuity::Float64 = 1.)
   logMoneyness = log(forward/strike)
   stdDeviation = vol * sqrt(expiry)
   d1 = logMoneyness/stdDeviation + stdDeviation
   d2 = d1 - stdDeviation
   normal = Normal(0., 1.)
   flag = type == Put ? -1. : 1.
   return annuity*flag*(forward*cdf(normal, flag*d1)
                       -strike*cdf(normal, flag*d2))
end

function bsFormula(spot::Float64, r::Float64, vol::Float64,
   expiry::Float64, strike::Float64, type::OptionType)
   df = exp(-r*expiry)
   forward = spot/df
   return blackFormula(forward, vol, expiry, strike, type, df)
end