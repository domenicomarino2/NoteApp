//
//  NoteFormView.swift
//  FinalNotes
//
//  Created by Domenico Marino on 12/12/21.
//

import SwiftUI

struct NoteFormView: View {
    @EnvironmentObject var dataStore: DataStore
    @ObservedObject var formVM: WriteNote
    enum Field{
        case title
        case body
    }
    @Environment(\.dismiss) var dismiss
    @FocusState private var focusField: Field?
    var body: some View {
        NavigationView{
            
        VStack(alignment: .leading){
            TextField("Title...", text: $formVM.title)
                .focused($focusField,equals: .body)
                .font(.largeTitle)
      
                   
                    
            TextEditor( text: $formVM.description)
                .focused($focusField,equals: .body)
                .multilineTextAlignment(.leading)
                .font(.body)
                    
                    }
            
                    
        .padding()
            
            .task {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ){
                focusField = .title
                focusField = .body
                }
            }
            .navigationTitle("Notes")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: cancelButton, trailing: updateSaveButton)

        }
//        .navigationBarItems(leading: cancelButton, trailing: updateSaveButton)
    }
}

extension NoteFormView {
    func updateNote(){
        let note = Note (id: formVM.id!, title: formVM.title, description: formVM.description)
        dataStore.updateNote(note: note)
        dismiss()
    }

func addNote(){
    let note = Note(title: formVM.title, description: formVM.description)
    dataStore.addNote(note: note)
    dataStore.loadnotes()
   dismiss()
    }
    var cancelButton: some View {
        Button("Cancel"){
            dismiss()
        }.foregroundColor(.yellow)
    }
    var updateSaveButton: some View {
        Button( formVM.updating ? "Update" : "Save",
                action: formVM.updating ? updateNote: addNote)
            .disabled(formVM.isDisabled)
            .foregroundColor(.yellow)
    }
}

struct NoteFormView_Previews: PreviewProvider {
    static var previews: some View {
        NoteFormView(formVM: WriteNote())
            .environmentObject(DataStore())
    }
}
