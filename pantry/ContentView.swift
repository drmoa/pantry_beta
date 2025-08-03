//
//  ContentView.swift
//  pantry
//
//  Created by Marcelino Nicasio on 7/9/25.
//

import SwiftUI

enum ActiveSheet: Identifiable {
    case addItem, scanItem

    var id: Int {
        hashValue
    }
}

struct ContentView: View {
    @State private var pantryItems: [PantryItem] = []
    @State private var activeSheet: ActiveSheet? = nil
    @State private var scannedCode: String? = nil
    
    var body: some View {
        NavigationView {
            List {
                ForEach(pantryItems) { item in
                    VStack(alignment: .leading) {
                        Text(item.name).font(.headline)
                        Text("Qty: \(item.quantity) • Exp: \(item.expirationDate.formatted(.dateTime.month().day().year()))")
                            .font(.subheadline).foregroundColor(.gray)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("My Pantry")
            .toolbar {
                // NEW: Scan button on the left
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        activeSheet = .scanItem
                    } label: {
                        Label("Scan", systemImage: "barcode.viewfinder")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        activeSheet = .addItem
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(item: $activeSheet) { sheet in
                switch sheet {
                case .addItem:
                    AddItemView(pantryItems: $pantryItems)
                case .scanItem:
                    ScanItemView(scannedCode: $scannedCode)
                }
            }
            .onAppear {
                pantryItems = loadPantryItems()
            }
            .onChange(of: pantryItems) {
                savePantryItems()
            }
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        pantryItems.remove(atOffsets: offsets)
    }
    
    // 📌 Persistence helper: load saved items
    func loadPantryItems() -> [PantryItem] {
        if let data = UserDefaults.standard.data(forKey: "pantryItems") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([PantryItem].self, from: data) {
                return decoded
            }
        }
        return []
    }
    
    // 📌 Persistence helper: save items
    func savePantryItems() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(pantryItems) {
            UserDefaults.standard.set(encoded, forKey: "pantryItems")
        }
    }
}
