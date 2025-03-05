import Foundation
import ArgumentParser

struct CompoundInterestCalculator: ParsableCommand {
    @Option(name: .shortAndLong, help: "Initial investment amount")
    var principal: Double

    @Option(name: .shortAndLong, help: "Annual interest rate (percentage)")
    var annualRate: Double

    @Option(name: .shortAndLong, help: "Number of years")
    var years: Int

    @Option(name: .shortAndLong, help: "Annual contribution amount")
    var contribution: Double

    func run() {
        let rateDecimal = annualRate / 100.0
        let finalAmount = compoundInterestWithContributions(principal: principal, rate: rateDecimal, years: years, contribution: contribution)
        let totalContribution = principal + (contribution * Double(years))
        let totalReturn = finalAmount - totalContribution

        print("\nInitial Investment: €\(principal)")
        print("Annual Interest Rate: \(annualRate)%")
        print("Years: \(years)")
        print("Annual Contribution: €\(contribution)\n")

        displayCompoundedGrowth(principal: principal, rate: rateDecimal, years: years, contribution: contribution)

        print("\n--- Summary ---")
        print("Total Contribution: €\(String(format: "%.2f", totalContribution)) (Principal: €\(principal) + Contributions: €\(String(format: "%.2f", contribution * Double(years))))")
        print()
        print("Final Amount after \(years) years: €\(String(format: "%.2f", finalAmount))")
        print()
        print("Total Return (Profit): €\(String(format: "%.2f", totalReturn))\n")
    }

    func compoundInterestWithContributions(principal: Double, rate: Double, years: Int, contribution: Double) -> Double {
        var amount = principal
        for _ in 1...years {
            amount = (amount * (1 + rate)) + contribution
        }
        return amount
    }

    func displayCompoundedGrowth(principal: Double, rate: Double, years: Int, contribution: Double) {
        var amount = principal
        print("\nYear | Investment Value")
        print("----------------------")
        for year in 0...years {
            print(String(format: "%4d | €%.2f", year, amount))
            amount = (amount * (1 + rate)) + contribution
        }
    }
}

CompoundInterestCalculator.main()
