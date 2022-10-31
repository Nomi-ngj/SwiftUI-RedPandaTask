//
//  FirebaseContracts.swift
//  RedPandaTask
//
//  Created by Nouman Gul on 31/10/2022.
//

import Foundation
import FirebaseDatabase

typealias completion = ((_ err : Error?) -> Void)

protocol FirebaseManagerDisplaying:ObservableObject{
    var products: [Product] {get set}
    var ref: DatabaseReference! {get set}
    var ids:[String] {get set}
}

protocol FirebaseManagerConsuming{
    func getProducts(with ids:[String], completed: @escaping ([Product])-> Void) async
    func update(id:String, value:String, type:FirebaseNodesSection, action:FirebaseActions, completion: completion?)
}
protocol FirebaseCruds{
    func save(data : [String:Any], ref : DatabaseReference, completion : completion?)
    func update(data : [String:Any], ref : DatabaseReference, completion : completion?)
    func delete(ref : DatabaseReference, completion : completion?)
}
