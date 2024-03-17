//
//  FallsDisplayView.swift
//  Rotra
//
//  Created by wzy on 2024/3/15.
//

import UIKit
import SwiftUI

protocol FallsSender: AnyObject {
    var reveiver: FallsReceiver? { get set }
}

protocol FallsReceiver: AnyObject {
    func displayLabelUpdate(labels: [String])
}

struct FallsDisplayView: UIViewRepresentable {
    var fallsSender: FallsSender?
    
    func makeUIView(context: Context) -> some UIView {
        FallsDisplayUIKitView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let view = uiView as? FallsDisplayUIKitView else {
            return
        }
        
        view.fallsSender = fallsSender
    }
}

class FallsDisplayUIKitView: UIView {
    weak var fallsSender: FallsSender? {
        didSet {
            fallsSender?.reveiver = self
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !_prepared {
            
            clipsToBounds = true
            
            for _ in 0..<50 {
                let label = UILabel()
                label.font = .systemFont(ofSize: 10.0)
                label.textColor = .red
                label.isHidden = true
                addSubview(label)
                _labels.append(label)
            }
            
            _displayLink = CADisplayLink(target: self, selector: #selector(FallsDisplayUIKitView.displayUpdate))
            _displayLink?.preferredFramesPerSecond = 30
            
            _displayLink?.add(to: .main, forMode: .common)
            
            _prepared = true
        }
    }
    
    @objc
    private func displayUpdate() {
        guard _needUpdate else {
            return
        }
        
        let displayValues = _values.flatMap { $0 }
        _needUpdate = false
        _values.removeAll()
        
        let size = self.frame.size
        
        for index in 0..<displayValues.count {
            if _labels.count <= 0 {
                break
            }
            let label = _labels.removeFirst()
            label.text = displayValues[index]
            let startPoint = CGPoint(x: CGFloat.random(in: 0.0..<size.width), y: CGFloat.random(in: 0.0..<size.height))
            label.frame = CGRect(origin: startPoint, size: CGSize(width: size.width, height: 20.0))
            label.isHidden = false
            
            UIView.animate(withDuration: 1.0, animations: {
                label.frame = CGRect(
                    origin: CGPoint(x: startPoint.x, y: startPoint.y - size.height),
                    size: CGSize(width: size.width, height: 20.0)
                )
            }) { [weak self] _ in
                label.isHidden = true
                self?._labels.append(label)
            }
        }
    }
    
    private var _displayLink: CADisplayLink?
    private var _prepared = false
    
    private var _needUpdate = false
    private var _values: [[String]] = [[String]]()
    private let _semphore = DispatchSemaphore(value: 1)
    
    private var _labels: [UILabel] = [UILabel]()
}

extension FallsDisplayUIKitView: FallsReceiver {
    
    func displayLabelUpdate(labels: [String]) {
        _needUpdate = true
        _values.append(labels)
    }
}
