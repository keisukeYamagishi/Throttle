import Throttle
import XCTest

final class ThrotlleTests: XCTestCase {
    let throtlle = Throttle()
    var timer: Timer?
    let testCount = 10
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

    let tests = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    let millSecTests = [0.0,0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009]

    func testSecondThrotlle() throws {
        let exception = expectation(description: #function)
        let date = Date()
        var count = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.001,
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
        wait(for: [exception], timeout: 30)
    }

    func testMillSecondThrotlle() throws {
        let exception = expectation(description: #function)
        let date = Date()
        var count = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.001,
                                     repeats: true,
                                     block: { _ in
                                         self.throtlle
                                             .execute(interval: .microseconds(1)) {
                                                 let time = floor(Date().timeIntervalSince(date) * 1000) / 1000
                                                 XCTAssert(time == self.millSecTests[count])
                                                 print(self.ohYeah(Double(time)))
                                                 count += 1
                                                 if count == self.testCount {
                                                     self.timer?.invalidate()
                                                     exception.fulfill()
                                                 }
                                             }
                                     })
        timer?.fire()
        wait(for: [exception], timeout: 3)
    }
}
