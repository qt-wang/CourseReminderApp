//
//  DukeClassDetail.swift
//  ClassSchedule WatchKit Extension
//
//  Created by Loaner on 3/12/22.
//

import Foundation
import SwiftUI
import MapKit
struct DukeClassDetail: View{
    var  dukeClass : DukeClass
    @ObservedObject var modelData: ModelData
    @State private var showSheet = false
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.00166, longitude: -78.93781), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    @ObservedObject var locationManager: LocationM
    var userLatitude: String {
            return "\(locationManager.lastLocation?.coordinate.latitude ?? 36)"
        }
        
    var userLongitude: String {
            return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
        }

    var body: some View {
        ScrollView{
        VStack (alignment: .leading) {
            Text(dukeClass.name)
            Text(dukeClass.startTime + "-" + dukeClass.endTime).colorMultiply(.blue)
            Text(dukeClass.address).colorMultiply(.yellow)
            Map(coordinateRegion: $region, showsUserLocation: true,annotationItems: [MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(dukeClass.latitude), longitude: CLLocationDegrees(dukeClass.longtitude)))], annotationContent: { location in
                MapPin(coordinate: location.coordinate, tint: .red)
            }).frame(width: 170, height: 170, alignment: .center)
            Text(dukeClass.description).colorMultiply(.primary)
            Text("user latitude: " + userLatitude)
            Text("user longitude: " + userLongitude)
            Button {
                showSheet = true
                } label: {
                    Text("Edit")
                        .sheet(isPresented: $showSheet) {
                           //EditClass View //TODO: Change duke_person to take in logged in person
                            EditClassView(isClassEditorShown: $showSheet,
                                className: dukeClass.name,
                                classDescription: dukeClass.description,
                                classStartTime: dukeClass.startTime,
                                classEndTime: dukeClass.endTime,
                                          classAddress: dukeClass.address,
                                          classRoomNumber: dukeClass.roomNumber, view_model: ClassInfoVM(duke_class: dukeClass, duke_person: modelData.dukePeople.first!.value,database: modelData))
                        }
                }
        }
        }
    }
}

/*
struct DukeClassDetail_Previews: PreviewProvider {
    static var previews: some View {
        DukeClassDetail(dukeClass: testClass)
    }
}
*/
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
}
