import Throttle
import XCTest

final class ThrotlleTests: XCTestCase {

    let throtlle = Throttle()

    func testSecondThrotlle() throws {
        let exception = expectation(description: #function)
        let date = Date()
        for index in 0..<10 {
            throtlle
                .execute(interval: .seconds(3)) {
                    let time = Date().timeIntervalSince(date)
                    XCTAssert(Int(time) % 3 == 0)
                    if index == 1 {
                        exception.fulfill()
                    }
            }
        }
        wait(for: [exception], timeout: 10)
    }

    func testMillSecondThrotlle() throws {
        let exception = expectation(description: #function)
        let date = Date()
        for index in 0..<10 {
            throtlle
                .execute(interval: .milliseconds(3)) {
                    let time = floor(Date().timeIntervalSince(date) * 1000) / 1000
                    XCTAssert(Int(time) % 3 == 0)
                    if index == 1 {
                        exception.fulfill()
                    }
            }
        }
        wait(for: [exception], timeout: 1)
    }
}
