//
//  PottyData.swift
//  PottyTime-watch WatchKit Extension
//
//  Created by Zach on 9/18/20.
//  Copyright © 2020 Zach. All rights reserved.
//

import Foundation
import os.log

struct PottyKeys {
    static let pee = "pee"
    static let poop = "poop"
    static let potties = "potties"
}

enum PottyType {
    case pee
    case poop
    
    static func destring(str: String) -> PottyType {
        return str.lowercased() == "pee" ? PottyType.pee : PottyType.poop
    }
}

struct Potty {
    var time: Date
    var type: PottyType
    let dateFormatString =  "MMM dd HH.mm"
    
    func stringify() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = dateFormatString
        let typeString = self.type == PottyType.pee ? "Pee" : "Poop"
        return "Time: \(dateFormatterPrint.string(from: time)), Type: \(typeString)"
    }
    static func destring(str: String) -> Potty? {
        let splits = str.split(separator: ":")
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dateFormatString"
        return Potty(time: dateFormatter.date(from: String(splits[1]))!, type: PottyType.destring(str: String(splits[3])))
    }
}

class PottyData {
    let m_url: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("pottyfile.txt")
    var m_potties: [Potty]
    init() {
        m_potties = []
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: m_url.absoluteString) {
            let data = try! String(contentsOf: m_url, encoding: .utf8)
            let lines = data.split(separator: "\n")
            for line in lines {
                m_potties.append(Potty.destring(str: String(line))!)
            }
        }
    }
    func setPotties(potties: [Potty]) { m_potties = potties }
    func getPotties() -> [String] {
        return ["test", "another test"]
    }
    
    func newMovement(type: PottyType) {
        let potty = Potty(time: Date(), type: type)
        m_potties.append(potty)
        appendPottyToFile(potty: potty)
    }
    
    func appendPottyToFile(potty: Potty) {
        let str = potty.stringify()
        try! str.write(to: m_url, atomically: false, encoding: .utf8)
    }
    func clearAllData() {
        
    }
}
