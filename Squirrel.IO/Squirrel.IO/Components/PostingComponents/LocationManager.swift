//
//  LocationManager.swift
//  Squirrel.IO
//
//  Created by Andrew Hong on 4/30/23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    @Published var city: String? = ""
    @Published var country: String? = ""
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}

func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
    CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
        completion(placemarks?.first?.locality,
                   placemarks?.first?.country,
                   error)
    }
}

extension LocationManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        fetchCityAndCountry(from: location) { city, country, error in
            guard let cit = city, let coun = country, error == nil else { return }
            self.city = cit
            self.country = coun
        }
        self.location = location
    }
}
