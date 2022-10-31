//
//  Product.swift
//  RedPandaTask
//
//  Created by Nouman Gul on 29/10/2022.
//

import Foundation

// A struct to store exactly one Product's data.
struct Product: Identifiable {
    var id = UUID()
    let productId:String
    let name: String
    let price: Int
    let image: String
    let description: String
}
