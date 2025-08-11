//
//  PantryViewModel.swift
//  pantry
//
//  Created by Marcelino Nicasio on 8/10/25.
//

import Foundation

class PantryViewModel: ObservableObject {
    @Published var pantryItems: [PantryItem] = []
    
    init() {
        loadPantryItems()
    }
    
    func addItem(name: String, quantity: Int, expirationDate: Date) {
        let newItem = PantryItem(name: name, quantity: quantity, expirationDate: expirationDate)
        pantryItems.append(newItem)
        savePantryItems()
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
                return
            }
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
