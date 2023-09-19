public struct TravelRestrictions: Decodable {
    public let inboundSummary: String?
    public let outboundSummary: String?
    public let inboundTravelRestrictions: InboundTravelRestrictions?
    public let outboundTravelRestrictions: OutboundTravelRestrictions?
}

public struct InboundTravelRestrictions: Decodable {
    public let visaRequired: [VisaRequired]?
    public let mandatoryUpcoming: [Restriction]?
    public let mandatoryOriginTravelDocuments: [Restriction]?
    public let mandatoryLocal: [Restriction]?
    public let mandatoryDestinationTravelDocuments: [Restriction]?
    public let mandatoryDestination: [Restriction]?
    public let notRequiredDestination: [Restriction]?
}

public struct OutboundTravelRestrictions: Decodable {
    public let visaRequired: [VisaRequired]?
    public let mandatoryUpcoming: [Restriction]?
    public let mandatoryOriginTravelDocuments: [Restriction]?
    public let mandatoryLocal: [Restriction]?
    public let mandatoryDestinationTravelDocuments: [Restriction]?
    public let mandatoryDestination: [Restriction]?
    public let notRequiredDestination: [Restriction]?
}

public struct VisaRequired: Decodable {
    public let title: String?
    public let description: String?
    public let category: String?
}

public struct Restriction: Decodable {
    public let title: String?
    public let category: String?
}
