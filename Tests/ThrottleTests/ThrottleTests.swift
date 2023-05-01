import Throttle
import XCTest

final class ThrotlleTests: XCTestCase {
    let throtlle = Throttle()
    var timer: Timer?
    let testCount = 5
    func ohYeah(_ time: Double) -> String {
        """
        　    ∧＿∧        ＿人人人人人人＿
        　　 (　･ω･)     >  Oh Yeah \(time)!!!  <
        　 　|　 　|       ￣Y^Y^Y^Y^Y^Y￣
        　 　|　 　|
        　 　|　 　|
        　 　|　 　|
        　 　|　 　|
        　 　|　 　|
        　 ＿|　⊃／(＿＿_
        ／　└-(＿＿＿_／
        """
    }

    let tests = [0, 1, 2, 3, 4]
    let millSecTests1 = [0.0, 0.1, 0.2, 0.3, 0.4]
    let millSecTests2 = [0.0, 0.01, 0.02, 0.03, 0.04]
    let millSecTests3 = [0.0, 0.001, 0.002, 0.003, 0.004]

    /// Test whether it can be executed at a one-second interval.
    func testSecondThrotlle() throws {
        let exception = expectation(description: #function)
        let date = Date()
        var count = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.0001,
                                     repeats: true,
                                     block: { _ in
                                         self.throtlle
                                             .execute(interval: .seconds(1)) {
                                                 let time = Int(Date().timeIntervalSince(date))
                                                 XCTAssert(self.tests[count] == time)
                                                 print(self.ohYeah(Double(time)))
                                                 count += 1
                                                 if count == self.testCount {
                                                     self.timer?.invalidate()
                                                     exception.fulfill()
                                                 }
                                             }
                                     })
        timer?.fire()
        wait(for: [exception], timeout: 15)
    }

    /// Test whether it can be executed at a 0.1 interval.
    func testMillSecondThrotlle() throws {
        let exception = expectation(description: #function)
        let date = Date()
        var count = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.0001,
                                     repeats: true,
                                     block: { _ in
                                         self.throtlle
                                             .execute(interval: .milliseconds(100)) {
                                                 let time = floor(Date().timeIntervalSince(date) * 10) / 10
                                                 print(self.ohYeah(Double(time)))
                                                 XCTAssert(time == self.millSecTests1[count])
                                                 count += 1
                                                 if count == self.testCount {
                                                     self.timer?.invalidate()
                                                     exception.fulfill()
                                                 }
                                             }
                                     })
        timer?.fire()
        wait(for: [exception], timeout: 1)
    }
}
