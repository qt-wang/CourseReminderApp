//
//  LoginView.swift
//  ClassSchedule WatchKit Extension
//
//  Created by Loaner on 3/12/22.
//

import Foundation
import SwiftUI


struct LoginView : View {
    
    @ObservedObject var modelData: ModelData
    @State private var apiDukePeople: [String:DukePerson] = ModelData().dukePeople
    @State var userName : String = ""
    @State private var showHomePage = false
    @State private var showAddForm = false
    @State private var showLoginForm = false
    @ObservedObject var locationManager: LocationM
    var currUserImage : Image {
        
        Image(userName.lowercased())
        
    }
    var body: some View {
        NavigationView {
            VStack {
                ScrollView{
                    currUserImage
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(150)
                    
                    
                    TextField(text: $userName, prompt: Text("User Name"), label: {() in Text("")})
                }
                
                HStack{
                    //NavigationLink(destination: HomePageView().environmentObject(modelData)) {
                      //  Text("Login")
                    //}
                    
                    //To do
                    Button("Login") {
                        showLoginForm = true
                        get_all_remote(modelData: _modelData)
                        if modelData.dukePeople[userName] != nil {
                            print("found person")
                            modelData.myself = modelData.dukePeople[userName]!
                            print(modelData.myself.Schedule)
                        }
                        //update_person_remote(person_to_update: testDukePerson)
                        //remove_person_remote(person_to_remove: testDukePerson)
                        //remove_all_remote()()
                    }
                    
                    Button("Sign Up") {
                        showAddForm = true
                    }
                }
            }.navigationBarTitle("Welcome")
            
        }
        .padding()
        .sheet(isPresented : $showAddForm){
            WelcomeScreen(view_model: SignUpVM(database: modelData), showAddForm: $showAddForm)
            
        }
        .sheet(isPresented : $showLoginForm){
            HomePageView(modelData: modelData, locationManager: locationManager)
            
        }
    }
}
