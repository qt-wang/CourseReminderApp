//
//  Connectivity.swift
//  WatchDataTransfer
//
//  Created by Loaner on 3/23/22.
//

import UIKit
import Foundation
import WatchConnectivity
import MapKit

class ViewModelPhone: NSObject, WCSessionDelegate {
    var session: WCSession
    @Published var messageRec = ""
    @Published var messageSend = ""
    init(session: WCSession = .default){
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {

    }

    func sessionDidBecomeInactive(_ session: WCSession) {

    }

    func sessionDidDeactivate(_ session: WCSession) {

    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            self.messageRec = message["message"] as? String ?? "Unknown"
            self.getCoordinate(place: self.messageRec)
        }
    }
    
    func getCoordinate(place: String){
        var coordinate = ""
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.00166, longitude: -78.93781), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = place
        request.region = region
        let search = MKLocalSearch(request: request)
        
        search.start(){
            (response, error) in
            if let response = response{
                let mapItem = response.mapItems.first
                coordinate = "\(mapItem?.placemark.coordinate.latitude ?? 36.00166)" + "," + "\(mapItem?.placemark.coordinate.longitude ?? -78.93781)"
                print(coordinate)
                self.messageSend = coordinate
            }
        }
    }
    
}
