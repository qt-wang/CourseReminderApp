//
//  ViewModelWatch.swift
//  WatchDataTransfer WatchKit Extension
//
//  Created by Loaner on 3/23/22.
//

import UIKit
import WatchConnectivity
import CoreLocation
//import WatchDataTransfer

//class ViewModelWatch: NSObject, WCSessionDelegate {
//    var session: WCSession
//    init(session: WCSession = .default){
//        self.session = session
//        session.activate()
//    }
//    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
//
//    }
//}

struct MyAnnotationItem: Identifiable {
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}

class ViewModelWatch : NSObject,  WCSessionDelegate, ObservableObject{
    var session: WCSession
    @Published var messageText = ""
    var latitudeCoord: CLLocationDegrees = 36.00166
    var longtitudeCoord: CLLocationDegrees = -78.93781
    var cdnt : MyAnnotationItem = MyAnnotationItem(coordinate: CLLocationCoordinate2D())
    init(session: WCSession = .default){
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            self.messageText = message["message"] as? String ?? "Unknown"
            self.gerCoordinate(str: self.messageText)
        }
    }
    
    func gerCoordinate(str: String){
        let coordinateArr = str.components(separatedBy: ",")
        self.latitudeCoord = CLLocationDegrees(coordinateArr[0]) ?? 36.00166
        self.longtitudeCoord = CLLocationDegrees(coordinateArr[1]) ?? -78.93781
        self.cdnt = MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: latitudeCoord, longitude: longtitudeCoord))
        print(latitudeCoord)
        print(longtitudeCoord)
    }
    
}
