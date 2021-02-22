//
//  DateExtention.swift
//  AEONTest
//
//  Created by Vitaly Khomatov on 22.02.2021.
//

import Foundation

class DateFormat {
    
    func getDateInfo(dateString : String, dateFormat : String = "yyyy-MM-dd") -> String {
        if let milliseconds = Int64(dateString) {
            let date = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat //"EEEE"
            let formateDate = dateFormatter.string(from: date)
            return formateDate
        } else { return dateString }
    }
    
}
