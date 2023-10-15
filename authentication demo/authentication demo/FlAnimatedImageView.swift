//
//  FlAnimatedImageView.swift
//  authentication demo
//
//  Created by Katyayani G. Raman on 10/15/23.
//

import Foundation
import SwiftUI
import FLAnimatedImage

struct FLAnimatedImageView: UIViewRepresentable {
    var gifName: String

    func makeUIView(context: Context) -> FLAnimatedImageView {
        return FLAnimatedImageView()
    }

    func updateUIView(_ uiView: FLAnimatedImageView, context: Context) {
        if let path = Bundle.main.path(forResource: gifName, ofType: "gif"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            let animatedImage = FLAnimatedImage(animatedGIFData: data)
            uiView.animatedImage = animatedImage
        }
    }
}
