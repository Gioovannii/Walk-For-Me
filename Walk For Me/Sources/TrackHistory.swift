//
//  TrackHistory.swift
//  Walk For Me
//
//  Created by Giovanni Gaffé on 2021/1/19.
//

import UIKit
import CoreLocation

final class TrackHistory: UITableViewController {
    
    // MARK: - Properties
    
    var paceTitle = [String]()
    var paceNumber = ["12", "45", "64", "92", "54"]
    var locationManager: CLLocationManager?
    var previousLocation : CLLocation?
    var currentLocation : CLLocation?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 1...5 {
            paceTitle.append("Nombre de pas " + "\(i)")
        }
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager?.allowsBackgroundLocationUpdates = true
    }
    
    func activateLocationServices() {
//        locationManager?.startUpdatingLocation()
        
        // MARK: - Ask location only one time

        locationManager?.requestLocation()
    }
}

extension PlaceTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paceTitle.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Walk Cell", for: indexPath)
        cell.textLabel?.text = paceTitle[indexPath.row]
        cell.detailTextLabel?.text = paceNumber[indexPath.row]
        return cell
    }
}

// MARK: - Location Manager Delegate

extension TrackHistory: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            activateLocationServices()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // MARK: - Check current location
        currentLocation = locations.first
        print(currentLocation as Any)
        
//        if previousLocation == nil {
//            previousLocation = locations.first
//        } else {
//            guard let latest = locations.first else { return }
//            let distanceInMeters = previousLocation?.distance(from: latest) ?? 0
//            paceNumber.append("\(distanceInMeters)")
//            print("Distance in meters: \(distanceInMeters)")
//            previousLocation = latest
//        }
    }
}