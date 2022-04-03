//
//  HomePageView.swift
//  ClassSchedule WatchKit Extension
//
//  Created by Loaner on 3/4/22.
//

import Foundation
import SwiftUI

/*
struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

*/

struct HomePageView: View {
    @ObservedObject var modelData: ModelData
    @ObservedObject var locationManager: LocationM
    
    @State private var showEditView = false
    @State private var showFriendList = false
    @State var isAlertPresented: Bool = false
    @State var taskDescriptionToEdit: String = ""
    @State var taskIndexToEdit: Int = -1
    
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
            List {
                ForEach(Array(modelData.myself.Schedule.values)) { currClass in
                    NavigationLink(destination : DukeClassDetail(dukeClass: currClass,modelData: modelData, locationManager: locationManager)) {
                   
                       DukeClassRow(dukeClass: currClass)
                   
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                          Button(role: .destructive) {
                              isAlertPresented = true
                          } label: {
                           Label("Delete", systemImage: "trash")
                          }
                          .tint(.red)
                        }
                    .alert("Are you sure?", isPresented: $isAlertPresented) {
                        Button("Yes") {
                        }
                        Button("No") {
                            
                        }
                    }

                }
            }
        
            .navigationTitle("My Schedule")
            HStack{
                Button {
                        showFriendList = true
                } label:{
                    Text("Friends List").font(.system(size: 12))
                        .sheet(isPresented: $showFriendList){
                            FriendListView(isFriendListShown: $showFriendList, modelData: modelData)
                        }
                }
                Button {
                        showEditView = true
                    } label: {
                        Image(systemName: "plus")
                            
                    }
                    .padding()
                    .sheet(isPresented : $showEditView){ //TODO: Change duke_person to take in logged in person
                        EditClassView(isClassEditorShown: $showEditView, view_model: ClassInfoVM(duke_person: modelData.myself, database: modelData)).onDisappear{
                            showEditView = false
                        }
                    }
                
            }
            .foregroundColor(.blue)
            
            }
            
            
        }
    }
}

/*

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
*/
