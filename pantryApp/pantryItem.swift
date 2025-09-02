//
//  pantryItem.swift
//
//  Created by Marcelino Nicasio on 7/9/25.
//

import Foundation

struct PantryItem: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var quantity: Int
    var expirationDate: Date
}
