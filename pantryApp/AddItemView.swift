//
//  AddItemView.swift
//  pantry
//
//  Created by Marcelino Nicasio on 7/9/25.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: PantryViewModel
    
    @State private var name = ""
    @State private var quantity = 1
    @State private var expirationDate = Date()
    
    var barcode: String?
    
    var body: some View {
        Form {
            TextField("Item Name", text: $name)
            Stepper(value: $quantity, in: 1...100) {
                Text("Quantity: \(quantity)")
            }
            DatePicker("Expiration Date", selection: $expirationDate, displayedComponents: .date)
        }
        .onAppear {
            if let code = barcode {
                API.fetchProductName(barcode: code) { productName in
                    DispatchQueue.main.async {
                        if let productName = productName, !productName.isEmpty {
                            name = productName
                        } else {
                            name = "Unknown Product (\(code))"
                        }
                    }
                }
            }
        }
        .navigationTitle("Add Item")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    let item = PantryItem(name: name, quantity: quantity, expirationDate: expirationDate)
                    viewModel.addItem(item)
                    dismiss()
                }
            }
        }
    }
}

