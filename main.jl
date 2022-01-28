include("black_formula.jl")
include("test_monte_carlo.jl")

function main()
    spot = 100.
    r = 0.01
    vol = 0.3
    expiry = 1.
    strike = 110.
    numPath = UInt(10000)

    bsCall = bsFormula(spot, r, vol, expiry, strike, Call)
    println("BS call price is $(bsCall)")
    bsPut = bsFormula(spot, r, vol, expiry, strike, Put)
    println("BS put price is $(bsPut)")

    testMonteCarlo(spot, r, vol, expiry, strike, numPath)
    testMonteCarlo2(spot, r, vol, expiry, strike, numPath)
    testMonteCarlo3(spot, r, vol, expiry, strike, numPath)
end

main()