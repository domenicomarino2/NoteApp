//
//  ModalType.swift
//  FinalNotes
//
//  Created by Domenico Marino on 12/12/21.
//

import SwiftUI
enum ModalType: Identifiable, View{
    case new
    case update(Note)
    var id: String{
        switch self {
        case .new:
            return "new"
        case .update:
            return "update"
        }
    }
    
    var body: some View{
        switch self {
        case .new :
          return NoteFormView (formVM: WriteNote())
        case .update(let Note):
            return NoteFormView(formVM: WriteNote(Note))
        }
    }
    
    
}

