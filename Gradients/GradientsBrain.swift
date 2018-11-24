//
//  GradientsBrain.swift
//  Gradients
//
//  Created by Andrea Gottardo on 2018-11-23.
//  Copyright © 2018 Andrea Gottardo. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics
import Photos

/**
 Generates new gradients, keeps an history so that the user can go back.
 
 - Todo: use a queue in addition to the stack, to allow the user to also move
         forward after moving backwards in the history.
 */
class GradientsBrain {
    
    // It's a singleton.
    static let shared = GradientsBrain()
    
    
    
    // Keeps the history of previously generated gradients.
    var stack = Stack<CGImage>()
    
    private init() {
        // Allow the user to go back to a maximum of 20 gradients, so that
        // we do not run out of RAM (especially on older iPhones).
        stack.setMaxSize(count: 20)
    }
    
    // MARK: Graphics stuff
    
    func gradientWithColors(color1: CGColor, color2: CGColor) -> CGImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = screenSize
        gradientLayer.colors = [color1, color2]
        UIGraphicsBeginImageContext(screenSize.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        stack.push(item: (image?.cgImage)!)
        return stack.peek()
    }
    
    func gradientWithRandomColors() -> CGImage {
        let rand1 = randomColor()
        let rand2 = randomColor()
        return gradientWithColors(color1: rand1, color2: rand2)
    }
    
    private func randomColor() -> CGColor {
        let h = CGFloat(Int.random(in: 0 ... 255))/255.0
        let s = CGFloat(Int.random(in: 0 ... 255))/255.0
        let b = CGFloat(Int.random(in: 75 ... 220))/255.0
        return UIColor(hue: h, saturation: s, brightness: b, alpha: 1.0).cgColor
    }
    
    private var screenSize: CGRect {
        return UIScreen.main.nativeBounds
    }
    
    // MARK: History
    
    func revertToPrevious() -> CGImage? {
        guard stack.count() > 1 else {
            return nil
        }
        let _ = stack.pop()
        return stack.peek()
    }
    
    func hasPrevious() -> Bool {
        return stack.count() > 1
    }
    
    // MARK: Save to Camera Roll
    
    func saveLastGradientToCameraRoll(completion: @escaping (Error?)->()) {
        
        if stack.isEmpty() {
            completion(NSError(domain: "No gradient generated yet.", code: 101, userInfo: nil))
            return
        }
        
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: UIImage(cgImage: self.stack.peek()))
        }, completionHandler: { success, error in
            if success {
                completion(nil)
            } else if let error = error {
                completion(error)
            } else {
                completion(NSError(domain: "Unknown save gradient error.", code: 102, userInfo: nil))
            }
        })
        
    }
    
    
    
    
}
