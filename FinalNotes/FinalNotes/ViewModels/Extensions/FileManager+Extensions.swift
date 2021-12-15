//
//  FileManager+Extensions.swift
//  FinalNotes
//
//  Created by Domenico Marino on 12/12/21.
//

import Foundation

let fileName = "Notes.json"

extension FileManager{
    static var docDirUrl: URL{
        return Self.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    func saveDocument(contents: String, docName: String, completion: (Error?) -> Void){
        let url = Self.docDirUrl.appendingPathComponent(docName)
        do {
            try contents.write(to: url, atomically: true, encoding: .utf8)
            
        } catch {
            completion(error)
            
        }
    }
    func readDocument (docName: String, completion: (Result<Data, Error>) -> Void) {
        let url = Self.docDirUrl.appendingPathComponent(docName)
        do{
            let data = try Data(contentsOf: url)
            completion(.success(data))
        } catch{
            completion(.failure(error))
        }
    }
    func docExist (named docName: String) -> Bool{
        fileExists(atPath: Self.docDirUrl.appendingPathComponent(docName).path)
    }
}
