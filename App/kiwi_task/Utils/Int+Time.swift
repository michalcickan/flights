import Foundation

extension Int {
    var secondsToTime: String {
        let days = self / (24 * 3600)
        let hours = (self % (24 * 3600)) / 3600
        let minutes = (self % 3600) / 60
        let seconds = self % 60
        
        var components: [String] = []
        
        if days > 0 {
            components.append("\(days) days")
        }
        if hours > 0 {
            components.append("\(hours) hours")
        }
        if minutes > 0 {
            components.append("\(minutes) minutes")
        }
        if seconds > 0 {
            components.append("\(seconds) seconds")
        }
        
        return components.joined(separator: ", ")
    }
}
