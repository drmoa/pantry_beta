// API.swift
import Foundation

enum API {
    struct OFFResponse: Codable {
        let status: Int?
        let product: OFFProduct?
    }

    struct OFFProduct: Codable {
        let productName: String?
        let brands: String?

        enum CodingKeys: String, CodingKey {
            case productName = "product_name"
            case brands
        }
    }

    /// Fetch the product name for a given barcode from Open Food Facts.
    static func fetchProductName(barcode: String, completion: @escaping (String?) -> Void) {
        let urlString = "https://world.openfoodfacts.org/api/v0/product/\(barcode).json"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil, let data = data else {
                completion(nil)
                return
            }
            do {
                let decoded = try JSONDecoder().decode(OFFResponse.self, from: data)
                completion(decoded.product?.productName)
            } catch {
                completion(nil)
            }
        }.resume()
    }
}
