//
//  Communication.swift
//  ClassSchedule WatchKit Extension
//
//  Created by Loaner on 3/28/22.
//

import Foundation
import SwiftUI
//let urlString = "http://localhost:8080/"
let urlString = "http://vcm-26044.vm.duke.edu:8080/"



func get_all_remote(modelData: ObservedObject<ModelData>){
    let decoder = JSONDecoder()
    let url = URL(string: urlString)
    var request = URLRequest(url: url!)
    request.httpMethod = "GET"
    let task = URLSession.shared.downloadTask(with: request){
        (location, response, error) in
        if response != nil {
            print(response!)
            do{
                let loc = location
                let data = try?Data(contentsOf: loc!)
                let latest_dukepeople = try decoder.decode([String : DukePerson].self, from: data!)
                modelData.wrappedValue.dukePeople = latest_dukepeople
                print(modelData.wrappedValue.dukePeople)
                //print(latest_dukepeople.keys)
            }
            catch{
                print("Error")
                print(error.localizedDescription)
            }
            
        
        } else {
            print("Error")
        }
        
    }
    task.resume()
    
}



func update_person_remote(person_to_update : DukePerson){
    let encoder = JSONEncoder()
    let url = URL(string: urlString)
    var request = URLRequest(url: url!)
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    let task = URLSession.shared.uploadTask(with: request, from: try! encoder.encode(person_to_update)) {
        (data, response, error) in
        if response != nil {
            print(response!)
        } else {
            print("Error")
        }
    }
    task.resume()
}


func remove_person_remote(person_to_remove : DukePerson){
    let encoder = JSONEncoder()
    let url = URL(string: urlString)
    var request = URLRequest(url: url!)
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "DELETE"
    let task = URLSession.shared.uploadTask(with: request, from: try! encoder.encode(person_to_remove)) {
        (data, response, error) in
        if response != nil {
            print(response!)
        } else {
            print("Error")
        }
    }
    task.resume()
}

func remove_all_remote(){
    let url = URL(string: (urlString + "all"))
    var request = URLRequest(url: url!)
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "DELETE"
    let task = URLSession.shared.dataTask(with: request) {
        (data, response, error) in
        if response != nil {
            print(response!)
        } else {
            print("Error")
        }
    }
    task.resume()
}
