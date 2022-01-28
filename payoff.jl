abstract type Payoff end

struct StrikedTypePayoff <: Payoff
    strike::Float64
end

struct PayoffCall <: Payoff
    super::StrikedTypePayoff
    PayoffCall(strike::Float64) = new(StrikedTypePayoff(strike))
end

struct PayoffPut <: Payoff
    super::StrikedTypePayoff
    PayoffPut(strike::Float64) = new(StrikedTypePayoff(strike))
end

function calcPayoff(self::PayoffCall, spot::Float64)
    return max(spot - self.super.strike, 0.0)
end

function calcPayoff(self::PayoffPut, spot::Float64)
    return max(self.super.strike - spot, 0.0)
end