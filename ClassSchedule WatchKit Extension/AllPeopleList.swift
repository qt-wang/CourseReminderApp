//
//  AllPeopleList.swift
//  ClassSchedule WatchKit Extension
//
//  Created by student on 3/30/22.
//

import Foundation
import SwiftUI

struct PeopleListView: View {
    
    @Binding var isPeopleListShown: Bool
    @ObservedObject var modelData: ModelData
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(Array(modelData.dukePeople), id: \.key) { key, value in
                        DukePersonRow(dukePerson: value)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button{
                                    if modelData.myself.FriendList.contains(value.netId) {
                                        if let index = modelData.myself.FriendList.firstIndex(of: value.netId) {
                                            modelData.myself.FriendList.remove(at: index)
                                        }
                                        print("friend removed")
                                        //TODO: Update person in server
                                    }
                                    else {
                                        modelData.myself.FriendList.append(value.netId)
                                        print("new friend added")
                                        //TODO: update person in server
                                    }
                                    
                                } label: {
                                    modelData.myself.FriendList.contains(value.netId)  ?
                                    Label("Remove friend", systemImage: "minus") : Label("Make my friend", systemImage: "plus")
                                }
                                .tint(modelData.myself.FriendList.contains(value.netId) ? .red : .blue)
                            }
                    }
                    
                }
                
            }
            .foregroundColor(.teal)
            
            
        }
        .navigationTitle("Edit My Friends")
        .foregroundColor(.blue)
        
    }
    
    
    
}




