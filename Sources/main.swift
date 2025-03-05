import Foundation
import ArgumentParser
import Economics

struct CompoundCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Calculate compound interest growth."
    )

    @Option(name: .shortAndLong, help: "Initial investment amount") 
    var principal: Double

    @Option(name: .shortAndLong, help: "Annual interest rate (percentage)") 
    var annualRate: Double

    @Option(name: [.short, .customLong("monthly-investment"), .customLong("contribution")], help: "Monthly contribution amount") 
    var monthlyInvestment: Double

    @Option(name: .shortAndLong, help: "Number of years") 
    var years: Int

    func run() {
        let config = CompoundValue.Configuration(
            principal: principal,
            annualRate: annualRate,
            monthlyInvestment: monthlyInvestment
        )

        let result = CompoundValue.value(config: config, years: years)

        print("\n--- Summary ---")
        print("Total Invested: €\(String(format: "%.2f", result.invested))")
        print("Final Amount after \(years) years: €\(String(format: "%.2f", result.value))")
        print("Total Return (Profit): €\(String(format: "%.2f", result.return))\n")
    }
}

CompoundCommand.main()
