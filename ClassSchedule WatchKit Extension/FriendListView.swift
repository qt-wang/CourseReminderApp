//
//  FriendListView.swift
//  ClassSchedule WatchKit Extension
//
//  Created by Loaner on 3/4/22.
//

import Foundation
import SwiftUI

import Foundation


extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}

struct FriendListView: View {

    @Binding var isFriendListShown: Bool

    @ObservedObject var modelData: ModelData
    @State var showPeopleList: Bool = false
    //var dukeClass : DukeClass
    @State var isAlertPresented: Bool = false
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
            List {
                ForEach(modelData.myself.FriendList) { currFriend_firstname in
                    let currFriend =  modelData.dukePeople[currFriend_firstname] //TODO: Doesn't work bc duke Peoplel based on firstname, while friends now based on netid, will be fixed once server updated
                    if currFriend != nil {
                    Section(header: DukePersonRow(dukePerson: currFriend!)){
                        ForEach(Array(currFriend!.Schedule.values)){ currClass in
                            
                            
                            DukeClassRow(dukeClass: currClass)
                                
                            
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button{
                                    isAlertPresented = true
                                    print("add button in friendlist")
                                    
                                  } label: {
                                      
                                      Label("add to schedule", systemImage: "plus")
                                  }
                                  .tint(.blue)
                                }
                            
                            
                        }
                        
                    }
                    .foregroundColor(.teal)
                    }
                    /*
                    NavigationLink(destination: FriendScheduleList().environmentObject(modelData)) {
                        DukePersonRow(dukePerson: currFriend)
                    }
                     */


                    }
                }
                HStack {
                    Button {
                            showPeopleList = true
                    } label:{
                        Text("Edit My Friends").font(.system(size: 12))
                            .sheet(isPresented: $showPeopleList){
                                PeopleListView(isPeopleListShown: $showPeopleList, modelData: modelData)
                            }
                    }
                }
            }
            .navigationTitle("Select A Friend")
            .foregroundColor(.blue)
            
            }
            
        
        
        }
    }




