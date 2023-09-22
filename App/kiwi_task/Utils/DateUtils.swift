import Foundation

private let calendar = {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone(identifier: "GMT")!
    return calendar
}()

extension Date {
    func addDays(_ days: Int) -> Date {
        calendar.date(byAdding: .day, value: days, to: self) ?? self
    }
    var startOfDay: Date {
        calendar.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        let components = DateComponents(day: 1, second: -1)
        return calendar.date(byAdding: components, to: startOfDay)!
    }
    
    var dayName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: self)
    }
}
