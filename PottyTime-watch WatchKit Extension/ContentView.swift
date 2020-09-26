//
//  ContentView.swift
//  PottyTime-watch WatchKit Extension
//
//  Created by Zach on 9/18/20.
//  Copyright © 2020 Zach. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var pd = PottyData()
    var body: some View {
        
        ScrollView { VStack {
            Button(action: {
                print("Logging new Pee")
                self.pd.newMovement(type: PottyType.pee)
                print("Logged new Pee")
            }) {
                Text("Pee")
            }
            Button(action: {
                print("Logging new Poop")
                self.pd.newMovement(type: PottyType.poop)
                print("Logged new Poop")
            }) {
                Text("Poop")
            }
            Button(action: {
                print("Showing Potties")
                let potties = pd.getPotties()
                Alert(title: Text("Potties"), message: Text("Wear sunscreen"), dismissButton: .default(Text("Got it!")));
            }) {
                Text("Show All")
            }
            Button(action: {
                print("Deleting All Potties")
            }) {
                Text("Clear Data")
            }
        } }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
