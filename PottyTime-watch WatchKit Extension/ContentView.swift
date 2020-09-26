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
    @State private var showingAlert = false
    @State private var clearDataAlert = false
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
                self.showingAlert = true
            }) {
                Text("Show All")
            }
            .alert(isPresented: $showingAlert) {
                let potties = PottyData.arrayToLines(strs: pd.getPotties())
                return Alert(title: Text("Potties"), message: Text(potties), dismissButton: .default(Text("Got it!")))
            }
            Button(action: {
                print("Deleting All Potties")
                pd.clearAllData()
                self.clearDataAlert = true
            }) {
                Text("Clear Data")
            }
            .alert(isPresented: $clearDataAlert) {
                return Alert(title: Text("Data Cleared"), message: Text("All Data Cleared"), dismissButton: .default(Text("Got it!")))

            }
        } }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
