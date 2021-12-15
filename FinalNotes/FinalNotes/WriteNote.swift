//
//  WriteNote.swift
//  FinalNotes
//
//  Created by Domenico Marino on 12/12/21.
//

import Foundation

class WriteNote : ObservableObject {
    @Published var title = ""
    @Published var description = ""
    
    var id: String?
    
    var updating: Bool{
        id != nil
    }
    var isDisabled: Bool{
        title.isEmpty
        
    }
    init() {}
    
    init(_ currentNote: Note){
        self.title = currentNote.title
        self.description = currentNote.description
        id = currentNote.id
    }
}
