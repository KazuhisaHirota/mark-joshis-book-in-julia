using Random

include("payoff.jl")
include("vanilla_option.jl")

function simpleMonteCarlo(
	expiry::Float64, strike::Float64, optionType::OptionType,
	 spot::Float64, vol::Float64, r::Float64, numPath::UInt)
	
	variance = vol * vol * expiry
	rootVariance = sqrt(variance)
	itoCorrection = -0.5 * variance

	movedSpot = spot * exp(r*expiry+itoCorrection)
	runningSum = 0.
	rngU = MersenneTwister(1234)

	for i = 1:numPath
		thisGaussian = randn(rngU)
		thisSpot = movedSpot * exp(rootVariance*thisGaussian)
		
		callPutFlag = optionType == Put ? -1. : 1. 
		thisPayoff = max(callPutFlag * (thisSpot - strike), 0.)
		
		runningSum += thisPayoff
    end

	mean = runningSum / float(numPath)
	mean *= exp(-r*expiry)
	return mean
end

function simpleMonteCarlo2(payoff::Payoff, expiry::Float64,
	 spot::Float64, vol::Float64, r::Float64, numPath::UInt)
	
	variance = vol * vol * expiry
	rootVariance = sqrt(variance)
	itoCorrection = -0.5 * variance

	movedSpot = spot * exp(r*expiry+itoCorrection)
	runningSum = 0.
	rngU = MersenneTwister(1234)

	for i = 1:numPath
		thisGaussian = randn(rngU)
		thisSpot = movedSpot * exp(rootVariance*thisGaussian)
		thisPayoff = calcPayoff(payoff, thisSpot) # NOTE
		runningSum += thisPayoff
	end

	mean = runningSum / float(numPath)
	mean *= exp(-r*expiry)
	return mean
end

function simpleMonteCarlo3(option::VanillaOption, 
    spot::Float64, vol::Float64, r::Float64, numPath::UInt)
   
   expiry = option.expiry # NOTE
   variance = vol * vol * expiry
   rootVariance = sqrt(variance)
   itoCorrection = -0.5 * variance

   movedSpot = spot * exp(r*expiry+itoCorrection)
   runningSum = 0.
   rngU = MersenneTwister(1234)

   for i = 1:numPath
       thisGaussian = randn(rngU)
       thisSpot = movedSpot * exp(rootVariance*thisGaussian)
       thisPayoff = calcPayoff(option, thisSpot) # NOTE
       runningSum += thisPayoff
   end

   mean = runningSum / float(numPath)
   mean *= exp(-r*expiry)
   return mean
end