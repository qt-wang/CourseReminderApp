//
//  ContentView.swift
//  WatchDataTransfer
//
//  Created by Loaner on 3/23/22.
//

import SwiftUI

//struct ContentView: View {
//    var model = ViewModelPhone()
//    @State var reachable = "No"
//    var body: some View {
//        VStack{
//            Text("Reachable \(reachable)")
//
//            Button(action: {
//                if self.model.session.isReachable{
//                    self.reachable = "Yes"
//                }
//                else{
//                    self.reachable = "No"
//                }
//
//            }) {
//                Text("Update")
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

struct ContentView: View {
    var model = ViewModelPhone()
    @State var reachable = "No"
    @State var messageText = ""
    var body: some View {
        VStack{
            Text("Reachable \(reachable)")
            Text(self.model.messageRec)
            Button(action: {
                if self.model.session.isReachable{
                    self.reachable = "Yes"
                }
                else{
                    self.reachable = "No"
                }

            }) {
                Text("Update")
            }
            TextField("Input your message", text: $messageText)
            Button(action: {
                self.model.session.sendMessage(["message" : self.model.messageSend], replyHandler: nil) { (error) in
                    print(error.localizedDescription)
                }
            }) {
            Text("Send Message")
            }
            
            Text(self.model.messageRec)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
