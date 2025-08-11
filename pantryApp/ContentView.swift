//
//  ContentView.swift
//  pantry
//
//  Created by Marcelino Nicasio on 7/9/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PantryViewModel()
    @State private var showingAddItem = false
    @State private var showingScanner = false
    @State private var scannedCode: String?

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.pantryItems) { item in
                    PantryItemRow(item: item)
                }
                .onDelete(perform: viewModel.deleteItems)
            }
            .navigationTitle("Pantry")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        showingScanner = true
                    } label: {
                        Image(systemName: "barcode.viewfinder")
                    }

                    Button {
                        showingAddItem = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddItem) {
                AddItemView(viewModel: viewModel)
            }
            .sheet(isPresented: $showingScanner) {
                ScanItemView(scannedCode: $scannedCode)
            }
            .onChange(of: scannedCode) {
                if let code = scannedCode {
                    print("Scanned barcode in ContentView: \(code)")
                }
            }
        }
    }
}

struct PantryItemRow: View {
    let item: PantryItem

    var body: some View {
        VStack(alignment: .leading) {
            Text(item.name)
                .font(.headline)
            Text("Qty: \(item.quantity) • Exp: \(item.expirationDate.formatted(.dateTime.month().day().year()))")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
