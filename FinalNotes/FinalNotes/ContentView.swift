//
//  ContentView.swift
//  FinalNotes
//
//  Created by Domenico Marino on 12/12/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataStore : DataStore
    @State private var modalType: ModalType? = nil
    
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
            List(){
                ForEach(dataStore.filteredNotes){
                    
                    Note in
                    Button{
                        modalType = .update(Note)
                        
                    } label: {
                       
                        Text(Note.title)
                            .multilineTextAlignment(.leading)
                            .frame( maxWidth: .infinity, alignment: .leading)
//                            .font(.title3)
                            .font(Font.title3.weight(.semibold))
                            .foregroundColor(Color(.label))
                            

                        
                        
                        Text(Note.description)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.body)
                            .foregroundColor(.gray)
                            
                            .brightness(0.1)
                            .lineLimit(1)
                        
                      
                        
                    
                    }
                    
                }
                .onDelete(perform: dataStore.deleteNote)
            }
            }
            .listStyle(InsetGroupedListStyle())
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        modalType = .new
                        
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.yellow)
                    }
                }
            }
            .navigationTitle("Notes")
                }
           
            .sheet(item: $modalType) { $0}
            .searchable(text: $dataStore.filterText, prompt: Text("Search Notes"))
            
        }

    }
       


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


