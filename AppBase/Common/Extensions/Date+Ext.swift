//
//  Date+Ext.swift
//  AppBase
//
//  Created by Quân Nguyễn on 31/12/24.
//

import Foundation

extension Date {
    func toString( dateFormat format: String ) -> String {
        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    mutating func addDays(n: Int) {
        let cal = Calendar.current
        self = cal.date(byAdding: .day, value: n, to: self)!
    }
    
    func firstDayOfTheMonth() -> Date {
        //        return Calendar.current.date(from:
        //        Calendar.current.dateComponents([.year, .month], from: self))!
        return Date()
    }
    
    func getAllDays() -> [Date] {
        var days = [Date]()
        
        let calendar = Calendar.current
        
        let range = calendar.range(of: .day, in: .month, for: self)!
        
        var day = firstDayOfTheMonth()
        
        for _ in 1...range.count {
            days.append(day)
            day.addDays(n: 1)
        }
        
        return days
    }
    
    /// Convert string date to date
    /// - Parameters:
    ///   - string: string date
    ///   - formatter: date formatter
    /// - Returns: date
    static func from(string: String, formatter: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
//        dateFormatter.locale = Locale(identifier: "ja_JP")
        if let date = dateFormatter.date(from: string) {
            return date
        }
        return nil
    }
    
    /// Convert local date to JP date
    /// - Returns: date
    func convertToJPTimeZone() -> Date {
        let currentTimeZone = TimeZone(abbreviation: TimeZone.current.abbreviation() ?? "UTC")
        let jpTimeZone = TimeZone(abbreviation: "JST")
        if let currentTimeZone = currentTimeZone, let jpTimeZone = jpTimeZone {
            return convertToTimeZone(initTimeZone: currentTimeZone, timeZone: jpTimeZone)
        }
        return Date()
    }
    
    /// Convert local date to JP date
    /// - Returns: date
    func convertToCurentTimeZone() -> Date {
        let currentTimeZone = TimeZone(abbreviation: TimeZone.current.abbreviation() ?? "UTC")
        let utcTimeZone = TimeZone(abbreviation: "UTC")
        if let currentTimeZone = currentTimeZone, let utcTimeZone = utcTimeZone {
            return convertToTimeZone(initTimeZone: utcTimeZone, timeZone: currentTimeZone)
        }
        return Date()
    }
    
    /// Convert timezone date
    /// - Parameters:
    ///   - initTimeZone: timezone of date
    ///   - timeZone: target timezone
    /// - Returns: date
    func convertToTimeZone(initTimeZone: TimeZone, timeZone: TimeZone) -> Date {
        let delta = TimeInterval(timeZone.secondsFromGMT(for: self) - initTimeZone.secondsFromGMT(for: self))
        return addingTimeInterval(delta)
    }
    
    /// Get yesterday
    static var yesterday: Date { return Date().convertToJPTimeZone().dayBefore }
    
    /// Get tomorrow
    static var tomorrow: Date { return Date().convertToJPTimeZone().dayAfter }
    
    /// Get day before
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date())!
    }
    
    /// Get day after
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    }
    
    /// Get noon of day
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    /// Get noon of day
    var morning: Date {
        return Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self)!
    }
    
    /// Get night of day
    var night: Date {
        return Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: self)!
    }
    /// Get minute
    var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    /// Get hour
    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    /// Get day
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    /// Get month of day
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    /// Get year of day
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    /// Is las day of month
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
    
    /// Days in the past
    /// - Parameter days: number of day
    /// - Returns: Days in the past
    func getHourBefore(_ hours: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: -hours, to: Date())!
    }
    
    /// Days in the future
    /// - Parameter days: number of day
    /// - Returns: Days in the future
    func getHourAfter(_ hours: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: hours, to: Date())!
    }
    
    /// Days in the past
    /// - Parameter days: number of day
    /// - Returns: Days in the past
    func getDayBefore(_ days: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: -days, to: noon)!
    }
    
    /// Days in the future
    /// - Parameter days: number of day
    /// - Returns: Days in the future
    func getDayAfter(_ days: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: days, to: noon)!
    }
    
    /// Next year
    /// - Returns: next year
    func getNextYear() -> Date? {
        return Calendar.current.date(byAdding: .year, value: 1, to: self)
    }
    
    /// Previous year
    /// - Returns: previous year
    func getPreviousYear() -> Date? {
        return Calendar.current.date(byAdding: .year, value: -1, to: self)
    }
    
    /// Now month
    /// - Returns: month
    func getMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: 0, to: self)
    }
    
    /// Previous month
    /// - Returns: previous month
    func getMonth(months: Int) -> Date? {
        return Calendar.current.date(byAdding: .month, value: months, to: self)
    }
    
    /// Next month
    /// - Returns: next month
    func getNextMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: 1, to: self)
    }
    
    /// Previous month
    /// - Returns: previous month
    func getPreviousMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)
    }
    
    /// Next week
    /// - Returns: next week
    func getNextWeek() -> Date? {
        return Calendar.current.date(byAdding: .weekOfYear, value: 1, to: self)
    }
    
    /// Previous week
    /// - Returns: previous week
    func getPreviousWeek() -> Date? {
        return Calendar.current.date(byAdding: .weekOfYear, value: -1, to: self)
    }
    
    /// Set specify time for the date
    /// - Returns: Date
    func setTime(hour: Int, min: Int, sec: Int, timeZoneAbbrev: String = "JST") -> Date? {
        let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var components = cal.dateComponents(x, from: self)
        
        components.timeZone = TimeZone(abbreviation: timeZoneAbbrev)
        components.hour = hour
        components.minute = min
        components.second = sec
        
        return cal.date(from: components)
    }
    
    /// Get hour before date
    func getHourBefore(_ hours: Int, targetDate: Date) -> Date {
        return Calendar.current.date(byAdding: .hour, value: -hours, to: targetDate)!
    }
    
    /// Get day before date
    func getDayBefore(_ days: Int, targetDate: Date) -> Date {
        return Calendar.current.date(byAdding: .day, value: -days, to: targetDate)!
    }
    
    /// Start of week
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear],
                                                                         from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 0, to: sunday)
    }
    
    /// End of week
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear],
                                                                         from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 6, to: sunday)
    }
    
    /// Start of month
    var startOfMonth: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let startOfMonth = gregorian.date(from: gregorian.dateComponents([.year, .month],
                                                                               from: self)) else { return nil }
        return startOfMonth.morning
    }
    
    /// End of month
    var endOfMonth: Date? {
        // return start of next month instead
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth!)!
    }
    
    /// End of month
    func startOfCurrentMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    /// Start of month
    func endOfCurrentMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfCurrentMonth())!
    }
    
    func calculateDaysBetweenDates(startDate: Date, endDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)

        // Lấy số ngày từ components
        if let days = components.day {
            return abs(days)  // Sử dụng abs để đảm bảo kết quả là số nguyên dương
        } else {
            return 0
        }
    }
    
    func getDateInRange(startDate: Date, endDate: Date) -> [Date] {
        let calendar = Calendar.current
        var datesInRange: [Date] = []
        
        var currentDate = startDate
        while currentDate <= endDate {
            datesInRange.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? Date()
        }
        return datesInRange
    }
}
