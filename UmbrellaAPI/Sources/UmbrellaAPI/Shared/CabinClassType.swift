import Foundation

public enum CabinClassType: String, Decodable, SimpleValueStringConvertible {
    case economy = "ECONOMY"
    case premiumEconomy = "PREMIUM_ECONOMY"
    case business = "BUSINESS"
    case firstClass = "FIRST_CLASS"
}

