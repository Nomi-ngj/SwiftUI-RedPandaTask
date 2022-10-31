//
//  ProductView.swift
//  RedPandaTask
//
//  Created by Nouman Gul on 29/10/2022.
//

import SwiftUI

// A view that shows the data for one Product.
struct ProductView: View {
    var product: Product

    var body: some View {
        HStack{
            UrlImageView(urlString: product.image).cornerRadius(8)
            VStack(alignment:.leading){
                Text("\(product.name)").font(.headline).foregroundColor(.white)
                Text("\(product.description)").font(.subheadline).foregroundColor(.white)
            }.padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            Spacer()
            VStack(alignment:.trailing){
                if product.price > 0 {
                    Text("\(Theme.constants.currencySymbol): \(product.price)").font(.subheadline).foregroundColor(.white)
                }else{
                    Text("-").font(.subheadline).foregroundColor(.white)
                }
            }.padding()
        }
    }
}
