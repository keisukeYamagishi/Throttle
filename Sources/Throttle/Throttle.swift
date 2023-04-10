//
//  Throttle.swift
//  Throlltle
//
//  Created by keisuke yamagishi on 2023/03/12.
//

import Foundation

public class Throttle {
    private var _now: Date {
        Date()
    }
    private var _lastSentTime: Date?
    private var _queue = DispatchQueue.main
    private var _leeway = DispatchTimeInterval.nanoseconds(0)
    private var _isStartTimer = false

    public init() {}

    public func execute(interval: DispatchTimeInterval,
                 emit: @escaping (() -> Void))
    {
        guard !_isStartTimer else { return }

        let currentDate = _now
        let timeInterval: DispatchTimeInterval
        if let lastSendingTime = _lastSentTime {
            timeInterval = interval.between(earlierDate: lastSendingTime,
                                            laterDate: currentDate)
        } else {
            timeInterval = .nanoseconds(0)
        }

        if timeInterval.isNow {
            _lastSentTime = _now
            emit()
            return
        }
        _timerExecute(interval: timeInterval,
                      completion: emit)
    }

    private func _timerExecute(interval: DispatchTimeInterval,
                       completion: @escaping (() -> Void))
    {
        _isStartTimer = true
        let deadline = DispatchTime.now() + interval

        let timer = DispatchSource.makeTimerSource(queue: _queue)
        timer.schedule(deadline: deadline, leeway: _leeway)

        var timerReference: DispatchSourceTimer? = timer

        timer.setEventHandler(handler: {
            self._lastSentTime = self._now
            timerReference?.cancel()
            timerReference = nil
            completion()
            self._isStartTimer = false
        })
        timer.resume()
    }
}
