import Foundation

public struct CheckInInfo: Decodable {
    /// Provider of the checkin service e.g. 'kiwi', 'carrier'
    public let checkinProvidedBy: String
    
    /// Checkin price at the airport
    public let airportCheckinPrice: Int
    
    /// public let Checkin requires passport
    public let passportRequired: Bool
    
    /// Is checkin available online
    public let onlineCheckIn: Bool
    
    /// public let Days before departure check-in opens
    public let checkInOpened: Int
    public let checkInClosed: Float
}
