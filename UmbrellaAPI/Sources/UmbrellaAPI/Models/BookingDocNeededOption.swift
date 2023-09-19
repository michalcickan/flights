public enum BookingDocNeededOption: String, Decodable {
    case notNeeded = "NOT_NEEDED"
    case neededAfterBookingConfirmed = "NEEDED_AFTER_BOOKING_CONFIRMED"
    case neededDuringBooking = "NEEDED_DURING_BOOKING"
}
