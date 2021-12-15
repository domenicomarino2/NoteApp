//
//  DataStore.swift
//  FinalNotes
//
//  Created by Domenico Marino on 12/12/21.
//

import Foundation

class DataStore: ObservableObject{
    @Published var notes: [Note] = []
    @Published var filterText = "" {
        didSet{
            if !filterText.isEmpty {
                filteredNotes = notes.filter{$0.title.lowercased().contains(filterText.lowercased())}

            }else{
                filteredNotes = notes
            }
            
        }
    }
    
    @Published var filteredNotes: [Note] = []
    
     
    init(){
        print(FileManager.docDirUrl.path)
        if FileManager().docExist(named: fileName){
            loadnotes()
        }
       
    }
    
    func addNote (note: Note){
        notes.append(note)
        savenotes()
        
    }
    func updateNote (note: Note){
        guard let index = notes.firstIndex(where: { $0.id == note.id}) else {return}
        notes[index] = note
        savenotes()
        filteredNotes[index] = note
       
    }
    
    func deleteNote (at indexSet: IndexSet){
        notes.remove(atOffsets: indexSet)
        savenotes()
        filteredNotes.remove(atOffsets: indexSet)
    }
    func loadnotes (){
        FileManager().readDocument(docName: fileName) { (result) in
            switch result{
            case .success(let data):
                let decoder = JSONDecoder()
                do{
                   
                    notes = try decoder.decode([Note].self, from: data)
                    filteredNotes = notes
                } catch{
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
    }
    func savenotes() {
        print("Saving notes to file system")
        let encoder = JSONEncoder()
        do{
            let data = try encoder.encode(notes)
            let jsonString = String(decoding: data, as: UTF8.self)
            FileManager().saveDocument(contents: jsonString, docName: fileName) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        } catch{
            print(error.localizedDescription)
        
        }
    }
}
