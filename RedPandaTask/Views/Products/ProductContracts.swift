//
//  ProductContracts.swift
//  RedPandaTask
//
//  Created by Nouman Gul on 29/10/2022.
//

import Foundation

protocol ProductComsumable{
    func getProducts()
}
protocol ProductViewModelPresenting:ObservableObject{
    var apiClient:ProductServiceManager { get }
    var firebaseManager:FirebaseManager? { get }
}

protocol ProductsServiceConsumable{
    func fetchProductsIds() async throws -> [String]?
}
