//
//  UrlImageView.swift
//  RedPandaTask
//
//  Created by Nouman Gul on 31/10/2022.
//

//The source for this imageView with URl
//https://schwiftyui.com/swiftui/downloading-and-caching-images-in-swiftui/

import SwiftUI

struct UrlImageView: View {
    @ObservedObject var urlImageModel: UrlImageModel
    
    init(urlString: String?) {
        urlImageModel = UrlImageModel(urlString: urlString)
    }
    
    var body: some View {
        Image(uiImage: urlImageModel.image ?? UrlImageView.defaultImage!)
            .resizable()
            .scaledToFill()
            .frame(width: 80, height: 80)
    }
    
    static var defaultImage = UIImage(named: "placeholder-image")
}

