//
//  ClassInfo.swift
//  ClassSchedule WatchKit Extension
//
//  Created by student on 2/27/22.
//
import Foundation
import SwiftUI



struct ClassInfoScreen: View {
    @State var className = ""
    @State var classAddress = ""
    @State var classDescription : String = ""
    @State var rmNumber = ""
    @State var end = ""
    @State var start = ""
    
    @Binding var isClassEditorShown: Bool
    @State var isAlertPresented: Bool = false
    @ObservedObject var view_model: ClassInfoVM
    
    var body: some View {
        ScrollView{
            VStack{
                Text("Input Class Data")
                HStack{
                    Text("Name:")
                    TextField("Name", text: $className)
                }
                HStack{
                    Text("Address:")
                    TextField("Address", text: $classAddress)
                }
                HStack{
                    Text("Room:")
                    TextField("Room", text: $rmNumber)
                }
                HStack{
                    Text("Start Time:")
                    TextField("Start", text: $start)
                    
                }
                HStack{
                    Text("End Time:")
                    TextField("End", text: $end)
                    
                }
                Button("Add to Schedule"){
                    
                }
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
                    if view_model.saveClass(name: className, description: classDescription, startTime: start, endTime: end, lastModified: .now, address: classAddress, roomNumber: rmNumber) {
                        isAlertPresented = false
                        $isClassEditorShown.wrappedValue = false
                    }
                    else {
                        isAlertPresented = true
                        $isClassEditorShown.wrappedValue = true
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

/*
struct ClassInfoScreen_Previews: PreviewProvider {
    static var previews: some View {
        ClassInfoScreen()
    }
}
*/
