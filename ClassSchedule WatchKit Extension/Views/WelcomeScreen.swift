//
//  File.swift
//  ClassSchedule WatchKit Extension
//
//  Created by student on 2/27/22.
//

import Foundation
import Combine
import SwiftUI

struct WelcomeScreen: View {
    @ObservedObject var view_model: SignUpVM
    @Binding var showAddForm: Bool
    @State var firstName = ""
    @State var lastName = ""
    @State var description = ""
    @State var netID = ""
    var body: some View {
        VStack{
            Text("Sign Up")
            Form {
                TextField(text: $firstName, prompt: Text("First Name"), label: {() in Text("")})
                TextField(text: $lastName, prompt: Text("Last Name") , label: {() in Text("")})
                TextField(text: $description, prompt: Text("Description") , label: {() in Text("")})
                TextField(text: $netID, prompt: Text("Net ID") , label: {() in Text("")})
            }
            .multilineTextAlignment(.leading)
            .foregroundColor(.gray)
            Button("Create"){
                if view_model.add_new_person(firstName: firstName, lastName: lastName, description: description, netid: netID) {
                    $showAddForm.wrappedValue = false
                }
            }
        }
    }
}


/*
struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen(view_model: SignUpVM().environmentObject(ModelData())).environmentObject(ModelData())
    }
}
*/
