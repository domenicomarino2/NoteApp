//
//  ToDo.swift
//  FinalNotes
//
//  Created by Domenico Marino on 12/12/21.
//

import Foundation

struct Note : Identifiable, Codable {
    var id : String = UUID().uuidString
    var title : String
    var description : String
    var date: Date?
    
    static var sampleData:  [Note] {
        [
        Note (title: "ciao", description: "ddada")
        ]
    }
}
