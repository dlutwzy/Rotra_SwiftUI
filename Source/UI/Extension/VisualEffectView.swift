//
//  VisualEffectView.swift
//  Rotra
//
//  Created by wzy on 2024/3/13.
//

import Foundation
import SwiftUI

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: Context) -> some UIView {
        UIVisualEffectView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let uiView = uiView as? UIVisualEffectView else {
            return
        }
        
        uiView.effect = effect
    }
}
