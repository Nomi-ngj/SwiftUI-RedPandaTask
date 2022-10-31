//
//  ProductsView.swift
//  RedPandaTask
//
//  Created by Nouman Gul on 29/10/2022.
//

import SwiftUI

// Create Products UI, then show a Products list.
struct ProductsView: View {
   
    // setup viewModel here.. we can use protocol as well to define properties for the view.
    @ObservedObject var viewModel = ProductViewModel()
    
    init(){
        // Load products once the view is initialized
        viewModel.getProducts()
        
    }
    var body: some View {
        
        if viewModel.isAnimating{ //show or hide loader
            
            // binding viewModel status with activity indicator
            ActivityIndicator(isAnimating: .constant(viewModel.isAnimating), style: .large)
        }else{
            
            NavigationView() {
                // creating ui for list for products
                List(viewModel.firebaseManager?.products ?? []) { product in
                    
                    //row product
                    ProductView(product: product).listRowBackground(Color.black)
                }
                //Set title
                .navigationBarTitle(Text("\(viewModel.title) : \(viewModel.firebaseManager?.products.count ?? 0)"))
            }
        }
    }
}

struct ProductsView_Privews: PreviewProvider {
    
    static var previews: some View{
        ProductsView()
    }
}

