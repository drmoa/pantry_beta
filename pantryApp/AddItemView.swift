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

    var body: some View {
        NavigationView {
            Form {
                TextField("Item name", text: $name)
                    .autocapitalization(.words)
                Stepper("Quantity: \(quantity)", value: $quantity, in: 1...100)
                DatePicker("Expiration Date", selection: $expirationDate, displayedComponents: .date)
            }
            .navigationTitle("Add Item")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.addItem(name: name, quantity: quantity, expirationDate: expirationDate)
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}
