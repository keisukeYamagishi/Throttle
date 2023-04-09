//
//  DispatchTiminterval+.swift
//  Throlltle
//  Created by Krunoslav Zaher on 4/14/19.
//  Update by keisuke yamagishi 2023/2/13.
//  Copyright © 2019 Krunoslav Zaher. All rights reserved.
//
//  The MIT License Copyright © 2015 Krunoslav Zaher, Shai Mishali All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
//  associated documentation files (the "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
//  following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial
//  portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
//  LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
//  EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
//  THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import Dispatch
import Foundation

extension DispatchTimeInterval {
    func map(_ transform: (Int, Double) -> Int) -> DispatchTimeInterval {
        switch self {
        case let .nanoseconds(value): return .nanoseconds(transform(value, 1_000_000_000.0))
        case let .microseconds(value): return .microseconds(transform(value, 1_000_000.0))
        case let .milliseconds(value): return .milliseconds(transform(value, 1000.0))
        case let .seconds(value): return .seconds(transform(value, 1.0))
        case .never: return .never
        @unknown default: fatalError()
        }
    }

    var isNow: Bool {
        switch self {
        case let .nanoseconds(value),
             let .microseconds(value),
             let .milliseconds(value),
             let .seconds(value):
            return value == 0
        case .never: return false
        @unknown default: fatalError()
        }
    }

    func between(earlierDate: Date, laterDate: Date) -> DispatchTimeInterval {
        map { value, factor in
            let interval = laterDate.timeIntervalSince(earlierDate)
            let remainder = Double(value) - interval * factor
            guard remainder > 0 else { return 0 }
            return Int(remainder.rounded(.toNearestOrAwayFromZero))
        }
    }
}
