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
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    static let m_path: String = Bundle.main.bundlePath;
    
    var m_potties: [Potty]
    init(potties: [Potty]) {
        m_potties = potties
    }
    required convenience init?(coder aDecoder: NSCoder) {
        guard let potties = aDecoder.decodeObject(forKey: PottyKeys.potties) as? [Potty] else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        self.init(potties: potties)
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(m_potties, forKey: PottyKeys.potties)
    }
    
    func loadPottiesFromFile() -> [Potty] {
        let data = Data()
        var unarchiver: NSKeyedUnarchiver
        do { unarchiver = try NSKeyedUnarchiver(forReadingFrom: data) } catch _ {}
    }
    func newMovement(type: PottyType) {
        m_potties.append((Date(), type))
        writeEntriesToFile()
    }
    func writeEntriesToFile() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(m_data, toFile: PottyData.ArchiveURL.path)
    }
    func clear() {
        
    }
}
