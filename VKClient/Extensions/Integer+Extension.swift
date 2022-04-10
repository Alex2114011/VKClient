//
//  Integer+Extension.swift
//  VKClient
//
//  Created by Alex on 07.04.2022.
//

import Foundation

extension Int {
    func formatNumber() -> String {
        let number = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch number {
        case 1_000_000_000...:
            var formatted = number / 1_000_000_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)B"

        case 1_000_000...:
            var formatted = number / 1_000_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)M"

        case 1_000...:
            var formatted = number / 1_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)K"

        case 0...:
            return "\(self)"

        default:
            return "\(sign)\(self)"
        }
    }

    func formatDate() -> String {
        let unixTime = Double(self)
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_Ru")
        dateFormatter.dateStyle = .medium
        let dateAsString = dateFormatter.string(from: date as Date)
        let dateFromString = dateFormatter.date(from: dateAsString)
        let dateCreateComment = dateFormatter.string(from: dateFromString! )
        return dateCreateComment
    }
}
