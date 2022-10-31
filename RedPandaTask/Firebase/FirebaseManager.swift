//
//  FirebaseManager.swift
//  RedPandaTask
//
//  Created by Nouman Gul on 29/10/2022.
//

import Combine
import FirebaseDatabase

class FirebaseManager: FirebaseManagerDisplaying{
    
    @Published var products: [Product] = []
    
    var ref: DatabaseReference!
    var ids:[String] = []
    
    init(databaseReference:DatabaseReference = Database.database().reference()){
        ref = databaseReference
        observeChanges()
    }

    deinit {
        self.ref = nil
        self.products = []
        self.ids = []
    }
}

extension FirebaseManager:FirebaseManagerConsuming{
    func getProducts(with ids:[String], completed: @escaping ([Product])-> Void) async {
        self.ids = ids
        Task{
            let _ = ref.getData { Error, snapshot in
                do {
                    guard let values = (snapshot?.value as? [String:Any]) else { return }
                    try self.mapData(values: values)
                    completed(self.products)
                }catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    //Testing Change in db
    func update(id:String, value:String, type:FirebaseNodesSection, action:FirebaseActions, completion: completion?){
        
        let updateRef = ref.child(type.rawValue)
        var dataValues:[String:Any] = [id:value]
        switch action {
        case .create:
            
            if type == .price{
                // incase the price added in db, wrapping value in Int
                if let intValue = Int(value){
                    dataValues = [id:intValue]
                }
                return
            }
            self.save(data: dataValues, ref: updateRef, completion: completion)
        case .update:
            if type == .price{
                // incase the price updated in db, wrapping value in Int
                if let intValue = Int(value){
                    dataValues = [id:intValue]
                }
                return
            }
            
            self.update(data: dataValues, ref: updateRef, completion: completion)
        case .delete:
            //deleting child reference id
            self.delete(ref: updateRef, completion: completion)
        }
    }
    
}

extension FirebaseManager{
    private func observeChanges(){
        ref.observe(.value) { [weak self] snapshot in
            do {
                guard let values = (snapshot.value as? [String:Any]) else { return }
                try self?.mapData(values: values)
            }catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func mapData(values:[String:Any]) throws {
        do {
            let snapData = try JSONSerialization.data(withJSONObject: values ,options: [.prettyPrinted])
            let db = try JSONDecoder().decode(FirebaseDatabaseModel.self, from: snapData)
            self.ids.forEach { productId in
                let name = db.names?[productId] ?? "-"
                let price = db.prices?[productId] ?? 0
                let image = db.images?[productId] ?? ""
                let description = db.productDescription?[productId] ?? "-"
                let product = Product(productId: productId, name: name, price: price, image: image, description: description)
                
                if let index = self.products.firstIndex(where: { $0.productId == productId }) {
                    self.products[index] = product
                }else{
                    self.products.append(product)
                }
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
}

extension FirebaseManager:FirebaseCruds{
    func save(data: [String : Any], ref: DatabaseReference, completion: completion?) {
        ref.setValue(data) { (err, reference) in
            // handle errors or anything related to completion block.
            completion?(err)
        }
    }
    
    func update(data: [String : Any], ref: DatabaseReference, completion: completion?) {
        ref.updateChildValues(data){ (err, reference) in
            // handle errors or anything related to completion block.
            completion?(err)
        }
    }
    
    func delete(ref: DatabaseReference, completion: completion?) {
        ref.removeValue(){ (err, reference) in
            // handle errors or anything related to completion block.
            completion?(err)
        }
    }
}
