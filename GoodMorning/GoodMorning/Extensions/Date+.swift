//
//  Date+.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/24.
//

import Foundation

extension Date {

    func yearMonthDayFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy / MM / dd"

        return formatter.string(from: self)
    }

}
