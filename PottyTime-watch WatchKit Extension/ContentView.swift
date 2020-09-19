//
//  ContentView.swift
//  PottyTime-watch WatchKit Extension
//
//  Created by Zach on 9/18/20.
//  Copyright © 2020 Zach. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button(action: {
                print("Logged new Pee")
                PottyData.newMovement(PottyType.pee)
                
            }) {
                Text("Pee")
            }
            Button(action: {
                print("Logged new Poop")
                PottyData.newMovement(PottyType.poop)
            }) {
                Text("Poop")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
