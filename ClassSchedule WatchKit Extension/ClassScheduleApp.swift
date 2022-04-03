//
//  ClassScheduleApp.swift
//  ClassSchedule WatchKit Extension
//
//  Created by student on 2/27/22.
//

import SwiftUI

@main
struct ClassScheduleApp: App {
    @StateObject private var modelData = ModelData()
    @StateObject var locationManager = LocationM()
    var body: some Scene {
        WindowGroup {
                //ContentView()
            /*
                HomePageView().environmentObject(modelData).onAppear{
                    //To Do: database initilization
                    
                }
             */
            LoginView(modelData: modelData, locationManager: locationManager)
        }
    }
}
