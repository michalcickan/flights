import CoreLocation

final class LocationManager: NSObject  {
    var locationContinuation: CheckedContinuation<CLLocationCoordinate2D?, Error>?
    let manager = CLLocationManager()

    override init() {
        super.init()
        manager.delegate = self
    }
    
    deinit {
        print("deinit")
    }

    @MainActor
    func requestLocation() async throws -> CLLocationCoordinate2D? {
        try await withCheckedThrowingContinuation { continuation in
            locationContinuation = continuation
            switch manager.authorizationStatus {
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            case .authorizedWhenInUse, .authorizedAlways:
                manager.requestLocation()
            default:
                continuation.resume(returning: nil)
            }
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationContinuation?.resume(returning: locations.first?.coordinate)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if manager.authorizationStatus == .notDetermined {
            return
        }
        locationContinuation?.resume(throwing: error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .denied:
            locationContinuation?.resume(returning: nil)
        default:
            manager.requestLocation()
        }
    }
}
