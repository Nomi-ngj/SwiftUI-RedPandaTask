//
//  ActivityContracts.swift
//  RedPandaTask
//
//  Created by Nouman Gul on 31/10/2022.
//

import SwiftUI

protocol ActivityIndicatorConsumable{
    var isAnimating: Bool {get set}
}
protocol ActivityIndicatorPresenting:UIViewRepresentable{
    var style: UIActivityIndicatorView.Style {get set}
}
