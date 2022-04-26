//
//  LocationDemoViewController.swift
//  MyContactList
//
//  Created by Chandler Hall on 4/26/22.
//

import UIKit
import CoreLocation

class LocationDemoViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager!
    
    @IBOutlet weak var txtStreet: UITextField!
  
    @IBOutlet weak var txtCity: UITextField!
    
    @IBOutlet weak var txtState: UITextField!
    
    @IBOutlet weak var lblLatitude: UILabel!
    
   
    @IBOutlet weak var lblLongitude: UILabel!
    
    @IBOutlet weak var lblLocationAccuracy: UILabel!
    
    @IBOutlet weak var lblHeading: UILabel!
    
    @IBOutlet weak var lblHeadingAccuracy: UILabel!
    
    @IBOutlet weak var lblAltitude: UILabel!
    
    @IBOutlet weak var lblAltitudeAccuracy: UILabel!
    
   lazy var geoCoder = CLGeocoder()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            print("Permission Granted")
        }
        else{
            print("Perrmission NOT granted")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let eventDate = location.timestamp
            let howRecent = eventDate.timeIntervalSinceNow
            if Double(howRecent) < 15.0 {
                let coordinate = location.coordinate
                lblLongitude.text = String(format: "%g\u{00B0}", coordinate.longitude)
                lblLatitude.text = String(format: "%g\u{00B0}", coordinate.latitude)
                lblLocationAccuracy.text = String(format: "%gm", location.horizontalAccuracy)
                lblAltitude.text = String(format: "%gm", location.altitude)
                lblAltitudeAccuracy.text = String(format: "%gm", location.verticalAccuracy)

            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        if newHeading.headingAccuracy > 0 {
            let theHeading = newHeading.trueHeading
            var direction: String
            switch theHeading {
            case 225..<315:
                direction = "W"
            case 135..<225:
                direction = "S"
            case 45..<135:
                direction = "E"
            default:
                direction = "N"
            }
            lblHeading.text = String(format: "%g\u{00B0} (%@)", theHeading, direction)
            lblHeadingAccuracy.text = String(format: "%g\u{00B0}", newHeading.headingAccuracy)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let errorType = error._code == CLError.denied.rawValue ? "Location Permission Denied" :
        "Unknown Error"
        let alertController = UIAlertController(title: "Error Getting location: \(errorType)", message: "Error Message: \(error.localizedDescription)", preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(actionOK)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func addresToCoordinates(_ sender: Any) {
        let address = "\(txtStreet.text!), \(txtCity.text!), \(txtState.text!)"
        geoCoder.geocodeAddressString(address) {(placemarks, error) in
            self.processAddressResponse(withPlacemarks: placemarks, error: error)
        }
    
    }
    
    private func processAddressResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        if let error = error {
            print("Geocode Error: \(error)")
        }
        else {
            var bestMatch: CLLocation?
            if let placemarks = placemarks, placemarks.count > 0 {
                bestMatch = placemarks.first?.location
            }
            if let coordinate = bestMatch?.coordinate {
                lblLatitude.text = String(format: "%g\u{00B0}", coordinate.latitude)
                lblLongitude.text = String(format: "%g\u{00B0}", coordinate.longitude)
            }
            else{
                print("Didn't find any matching locations")
            }
        }
    }
   
    
    @IBAction func deviceCoordinates(_ sender: Any) {
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = 100
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
       }
    
    override func viewDidDisappear(_ animated: Bool) {
        locationManager.stopUpdatingHeading()
        locationManager.stopUpdatingLocation()
    }

}
