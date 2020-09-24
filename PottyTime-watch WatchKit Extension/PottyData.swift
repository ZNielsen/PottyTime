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
}

struct Potty {
    var time: Date
    var type: PottyType
}

class PottyData : NSObject, NSCoding {
    var m_potties: [Potty]
    var m_data: Data
    var m_archiver: NSKeyedArchiver
    override init() {
        m_potties = []
        m_archiver = NSKeyedArchiver(requiringSecureCoding: false)
        m_data = Data()
    }
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        guard let potties = try! NSKeyedUnarchiver(forReadingFrom: m_data).decodeObject(forKey: PottyKeys.potties) as? [Potty] else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        self.setPotties(potties: potties)
    }
    func setPotties(potties: [Potty]) { m_potties = potties }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(m_potties, forKey: PottyKeys.potties)
    }
    
    func newMovement(type: PottyType) {
        let potty = Potty(time: Date(), type: type)
        m_potties.append(potty)
        writePottiesToFile()
    }
    
    func writePottiesToFile() {
        m_archiver.encode(m_potties, forKey: PottyKeys.potties)
    }
    func clearAllData() {
        
    }
}
