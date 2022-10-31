//
//  ProductServiceManager.swift
//  RedPandaTask
//
//  Created by Nouman Gul on 29/10/2022.
//

import Foundation

class ProductServiceManager:NetworkManager, ProductsServiceConsumable{
    
    func fetchProductsIds() async throws -> [String]? {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([String].self, from: data)
    }
}
