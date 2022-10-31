//
//  RedPandaTaskApp.swift
//  RedPandaTask
//
//  Created by Nouman Gul on 29/10/2022.
//

import SwiftUI
import Firebase

@main
struct RedPandaTaskApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ProductsView()
        }
    }
}
