//
//  Throttle.swift
//  Throlltle
//
//  Created by keisuke yamagishi on 2023/03/12.
//

import Foundation

public class Throttle {
    private var now: Date {
        Date()
    }

    private var lastSentTime: Date?
    private var queue = DispatchQueue.main
    private var leeway = DispatchTimeInterval.nanoseconds(0)
    private var isStartTimer = false

    public init() {}

    public func execute(interval: DispatchTimeInterval,
                        emit: @escaping (() -> Void))
    {
        guard !isStartTimer else { return }

        let currentDate = now
        let timeInterval: DispatchTimeInterval
        if let lastSendingTime = lastSentTime {
            timeInterval = interval.between(earlierDate: lastSendingTime,
                                            laterDate: currentDate)
        } else {
            timeInterval = .nanoseconds(0)
        }

        guard !timeInterval.isNow else {
            lastSentTime = now
            emit()
            return
        }
        timerExecute(interval: timeInterval,
                      completion: emit)
    }

    private func timerExecute(interval: DispatchTimeInterval,
                               completion: @escaping (() -> Void))
    {
        isStartTimer = true
        let deadline = DispatchTime.now() + interval

        let timer = DispatchSource.makeTimerSource(queue: queue)
        timer.schedule(deadline: deadline, leeway: leeway)

        var timerReference: DispatchSourceTimer? = timer

        timer.setEventHandler(handler: {
            self.lastSentTime = self.now
            timerReference?.cancel()
            timerReference = nil
            completion()
            self.isStartTimer = false
        })
        timer.resume()
    }
}
