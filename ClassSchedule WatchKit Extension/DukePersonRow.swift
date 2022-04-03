//
//  DukePersonRow.swift
//  ClassSchedule WatchKit Extension
//
//  Created by Loaner on 3/12/22.
//

import Foundation
import SwiftUI

struct DukePersonRow: View {
    var dukePerson : DukePerson

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack(alignment: .top){
                    Text(dukePerson.firstName + " " + dukePerson.lastName).colorMultiply(.white)
                        .font(.headline)
                    
                }
                Text(dukePerson.description).colorMultiply(.blue)
                Text("NetId : " + dukePerson.netId)
            }
            Spacer()
        }
    }
}


