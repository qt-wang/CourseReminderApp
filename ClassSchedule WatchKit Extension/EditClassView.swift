//
//  EditClassView.swift
//  ClassSchedule WatchKit Extension
//
//  Created by Loaner on 3/12/22.
//

import Foundation
import SwiftUI

struct EditClassView: View {
    @Binding var isClassEditorShown: Bool
    @State var isAlertPresented: Bool = false
    @State var className : String = ""
    @State var classDescription : String = ""
    @State var classStartTime : String = ""
    @State var classEndTime : String = ""
    @State var classAddress : String = ""
    @State var classRoomNumber : String = ""
    @ObservedObject var view_model: ClassInfoVM
    @ObservedObject var model = ViewModelWatch()
    @State var isReminderShowed: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField(text: $className, prompt: Text("Class Name"), label: {() in Text("")})
                TextField(text: $classDescription, prompt: Text("Class Description") , label: {() in Text("")})
                TextField(text: $classStartTime, prompt: Text("Class Start Time") , label: {() in Text("")})
                TextField(text: $classEndTime, prompt: Text("Class End Time") , label: {() in Text("")})
                TextField(text: $classAddress, prompt: Text("Class Address") , label: {() in Text("")}).onSubmit {
                    self.model.session.sendMessage(["message" : classAddress], replyHandler: nil) { (error) in
                        print(error.localizedDescription)
                    }
                    view_model.DataBase.myself.Schedule[className]?.address = classAddress
                    isReminderShowed = true
                }
                if isReminderShowed{
                    confirmationDialog("Please click Confirm button on your paired iPhone now, and then click OK here.", isPresented: $isReminderShowed){
                        Button("OK"){
                            isReminderShowed = false
                        }
                    }
                }
                TextField(text: $classRoomNumber, prompt: Text("Class Room Number") , label: {() in Text("")})
            }
            .multilineTextAlignment(.leading)
            .foregroundColor(.gray)
            .navigationTitle(className == "" ? "New Class" : className)
            .navigationBarTitleDisplayMode(.inline)
            
            HStack{
                Button {
                    $isClassEditorShown.wrappedValue = false
                } label: {
                    Label("Cancel", systemImage: "chevron.left")
                        .labelStyle(.titleOnly).font(.system(size: 12))
                }
                
                Button{
                    
                    //TBC
                    //This button lead to view that shows all classes from database and user can load any of these class to editor view
                } label: {
                    Label("Load Class",  systemImage: "chevron.left").labelStyle(.titleOnly).font(.system(size: 12))
                }
                
                Button {
                    print("save button inside class editor")
                    print($isClassEditorShown.wrappedValue)
                    if view_model.saveClass(name: className, description: classDescription, startTime: classStartTime, endTime: classEndTime, lastModified: .now, address: classAddress, roomNumber: classRoomNumber) {
                        isAlertPresented = false
                        $isClassEditorShown.wrappedValue = false
                    }
                    else {
                        isAlertPresented = true
                        $isClassEditorShown.wrappedValue = true
                    }
                    
                action: do {
                    view_model.DataBase.myself.Schedule[className]?.latitude = Float(model.cdnt.coordinate.latitude)
                    view_model.DataBase.myself.Schedule[className]?.longtitude = Float(model.cdnt.coordinate.longitude)

                    
                }
                    
                } label: {
                    Label("Save", systemImage: "chevron.left")
                        .labelStyle(.titleOnly).font(.system(size: 12))
                }
                .alert("Missing Field(s) or invalid format", isPresented: $isAlertPresented) {
                    Button("OK") {
                        isAlertPresented = false
                    }
                }
            }
            
            
        }
    }
}


