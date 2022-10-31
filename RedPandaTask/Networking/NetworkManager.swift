//
//  NetworkManager.swift
//  RedPandaTask
//
//  Created by Nouman Gul on 29/10/2022.
//

import Foundation
 

class NetworkManager: NetworkConsumable {
    var url: URL
    
    init(url: URL = Theme.networkContants.serverUrl) {
        self.url = url
    }
}
