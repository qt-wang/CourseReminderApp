//
//  DukeClassRow.swift
//  ClassSchedule WatchKit Extension
//
//  Created by Loaner on 3/12/22.
//

import Foundation
import SwiftUI

struct DukeClassRow: View {
    var dukeClass : DukeClass

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack(alignment: .top){
                    Text(dukeClass.name)
                        .font(.headline)
                    
                }
                Text(dukeClass.startTime + "-" + dukeClass.endTime).colorMultiply(.blue)
                Text(dukeClass.description)
            }
            Spacer()
        }
    }
}

struct DukeClassRow_Previews: PreviewProvider {
    static var previews: some View {
        DukeClassRow(dukeClass: testClass)
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
