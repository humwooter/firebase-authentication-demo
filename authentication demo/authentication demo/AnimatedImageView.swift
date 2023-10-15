//
//  AnimatedImageView.swift
//  authentication demo
//
//  Created by Katyayani G. Raman on 10/15/23.
//

import Foundation
import UIKit
import FLAnimatedImage
import SwiftUI

struct AnimatedImageView: UIViewRepresentable {
    var data: Data
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let animatedView = FLAnimatedImageView()
        animatedView.contentMode = .scaleAspectFit
        view.addSubview(animatedView)
        animatedView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            animatedView.topAnchor.constraint(equalTo: view.topAnchor),
            animatedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            animatedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animatedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<AnimatedImageView>) {
        guard let animatedView = uiView.subviews.first as? FLAnimatedImageView else { return }
        
        let gif = FLAnimatedImage(animatedGIFData: data)
        animatedView.animatedImage = gif
    }
}
