//
//  ActivityIndicator.swift
//  RedPandaTask
//
//  Created by Nouman Gul on 29/10/2022.
//

import SwiftUI

struct ActivityIndicator: ActivityIndicatorPresenting, ActivityIndicatorConsumable {

    @Binding var isAnimating: Bool
    var style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
