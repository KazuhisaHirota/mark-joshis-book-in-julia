
include("monte_carlo.jl")

function testMonteCarlo(
    spot::Float64, r::Float64, vol::Float64,
    expiry::Float64, strike::Float64, numPath::UInt)
    
    mcCall = simpleMonteCarlo(expiry, strike, Call, spot, vol, r, numPath)
    println("MC call price is $(mcCall)")
    mcPut = simpleMonteCarlo(expiry, strike, Put, spot, vol, r, numPath)
    println("MC put price is $(mcPut)")
end

function testMonteCarlo2(
    spot::Float64, r::Float64, vol::Float64,
    expiry::Float64, strike::Float64, numPath::UInt)
    
    call = PayoffCall(strike)
    mcCall = simpleMonteCarlo2(call, expiry, spot, vol, r, numPath)
    println("MC call price is $(mcCall)")
    
    put = PayoffPut(strike)
    mcPut = simpleMonteCarlo2(put, expiry, spot, vol, r, numPath)
    println("MC put price is $(mcPut)")
end

function testMonteCarlo3(
    spot::Float64, r::Float64, vol::Float64,
    expiry::Float64, strike::Float64, numPath::UInt)
    
    callOption = VanillaOption(expiry, PayoffCall(strike))
    mcCall = simpleMonteCarlo3(callOption, spot, vol, r, numPath)
    println("MC call price is $(mcCall)")
    
    putOption = VanillaOption(expiry, PayoffPut(strike))
    mcPut = simpleMonteCarlo3(putOption, spot, vol, r, numPath)
    println("MC put price is $(mcPut)")
end