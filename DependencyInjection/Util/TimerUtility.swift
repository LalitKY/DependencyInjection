//
//  TimerUtility.swift
//  Moreyeah
//
//  Created by Lalit Kant on 06/04/21.
//

import Foundation

struct TimerUtility {
    
    func minusTimeByOnSec(dateString: String?) -> String {
        guard let dString = dateString else {
            return ""
        }
        let timeInSec = self.createTimeStringToTimeSeconds(dateString: dString) - 1
        let intervalStr =  stringFromTimeInterval(interval: TimeInterval(timeInSec))
        return intervalStr as String
    }
    
    func createTimeStringToTimeSeconds(dateString: String?) -> Int {
        guard dateString != nil else {
            return 0
        }
        let arr = dateString?.components(separatedBy: ":")
        let hr = ((Int(arr![0])!) * 60*60)
        let min = ((Int(arr![1]) ?? 0) * 60)
        let sec = (Int(arr![2]) ?? 0)
        let sum = hr + min + sec
        return sum
    }
    
    private func converDateToMinusOne(dString: String) -> String {
        let dateAsString = dString
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let date = dateFormatter.date(from: dateAsString )
        let dateMinus1Sec = Calendar.current.date(byAdding: .second, value: -1, to: date! )
        return self.stringFromTimeInterval(interval: dateMinus1Sec!.timeIntervalSince(Date())) as String
    }

    private func stringFromTimeInterval(interval:TimeInterval) -> String {
        let ti = NSInteger(interval)
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        if interval>0 {
            return String(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
        } else {
            return "00:00:00"
        }
    }
    
}
