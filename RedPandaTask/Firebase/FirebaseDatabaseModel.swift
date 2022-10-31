//
//  FirebaseDatabaseModel.swift
//  RedPandaTask
//
//  Created by Nouman Gul on 29/10/2022.
//

import Foundation

struct FirebaseDatabaseModel:Codable{
    let names:[String:String]?
    let productDescription:[String:String]?
    let images:[String:String]?
    let prices:[String:Int]?
    
    enum CodingKeys: String, CodingKey {
        case names = "product-name"
        case productDescription = "product-desc"
        case images = "product-image"
        case prices = "product-price"
    }
}


