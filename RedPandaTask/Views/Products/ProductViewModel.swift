//
//  ProductViewModel.swift
//  RedPandaTask
//
//  Created by Nouman Gul on 29/10/2022.
//

import Foundation
import Combine

class ProductViewModel:ProductViewModelPresenting, ActivityIndicatorConsumable, ProductComsumable{
    //class helper variables
    internal var apiClient: ProductServiceManager
    
    // variables under view observation
    @Published var isAnimating: Bool = false
    @Published var firebaseManager:FirebaseManager?
    
    //Set title for view
    let title:String = Theme.constants.productTitle
    private var counter = 0
    //incase your api client is change or your firebase manager change you can use the same protocols but with different manager here..
    init(apiClient: ProductServiceManager = ProductServiceManager(), firebaseManager:FirebaseManager = FirebaseManager()) {
        self.apiClient = apiClient
        self.firebaseManager = firebaseManager
    }
    
    //fetch products from api then use those product ids to get data from firebase
    func getProducts() {
        Task {
            do {
                //show loader on screen
                isAnimating = true
                
                //fetch data from server client
                guard let serverProducts = try await apiClient.fetchProductsIds() else {
                    isAnimating = false
                    return
                }
                
                //Testing Realtime change through this function:
//                self.dummyChange()
                
//                // get firebase data here..
                await self.firebaseManager?.getProducts(with: serverProducts, completed: { [weak self] products in

                    // hide loader once the task is completed
                    self?.isAnimating = false
                })
                
            } catch {
                // you can show error on screen, for now i am just displaying the error here..
                print("Could not get games: \(error.localizedDescription)")
                
                // hide loader incase of error
                isAnimating = false
            }
        }
    }
    
    func dummyChange(){
        // change effect after 5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now()+5.0, execute: {
            let value = "Suhana Pani Puri Masala 10g"
            // updating child type with action.
            self.firebaseManager?.update(id: "-M4nT_Qdig3KKwi2vuWi", value: value, type: .name, action: .update, completion: { err in
                if let err = err {
                    debugPrint(err.localizedDescription)
                    return
                }
                self.counter += 1
                self.dummyChange()
            })
            
        })
    }
}
