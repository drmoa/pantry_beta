//
//  PantryViewModel.swift
//  pantry
//
//  Created by Marcelino Nicasio on 8/10/25.
//

import Foundation

class PantryViewModel: ObservableObject {
    /*
     This is the data layer with add/delete/load/save logic using UserDefaults (**WILL USE CORE DATA SOON**).
     */
    @Published var pantryItems: [PantryItem] = []
    
    init() {
        loadPantryItems()
    }
    
    func addItem(_ item: PantryItem) {
        pantryItems.append(item)
    }

    
    func deleteItems(at offsets: IndexSet) {
        pantryItems.remove(atOffsets: offsets)
        savePantryItems()
    }
    
    private func loadPantryItems() {
        if let data = UserDefaults.standard.data(forKey: "pantryItems") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([PantryItem].self, from: data) {
                pantryItems = decoded
                return            }
        }
        pantryItems = []
    }
    
    private func savePantryItems() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(pantryItems) {
            UserDefaults.standard.set(encoded, forKey: "pantryItems")
        }
    }
}
