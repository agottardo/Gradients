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
 */
class GradientsBrain {

    /// Keeps the history of previously generated gradients.
    var previousGradients = Stack<CGImage>()
    /// Gradients to come, used to preserve state when moving through the history.
    var nextGradients = Stack<CGImage>()

    var currentGradient: CGImage

    init() {
        // Allow the user to go back to a maximum of 20 gradients, so that
        // we do not run out of RAM (especially on older iPhones).
        previousGradients.setMaxSize(count: 20)
        nextGradients.setMaxSize(count: 20)
        // Start with an ugly gradient.
        currentGradient = GradientsBrain.gradientWithColors(color1: UIColor.red.cgColor, color2: UIColor.green.cgColor)
    }

    // MARK: Exposed functions

    func next() -> CGImage {
        previousGradients.push(item: currentGradient)
        if !nextGradients.isEmpty() {
            currentGradient = nextGradients.pop()!
        } else {
            currentGradient = GradientsBrain.gradientWithRandomColors()
        }
        return currentGradient
    }

    func back() -> CGImage? {
        if previousGradients.isEmpty() {
            return nil
        }
        nextGradients.push(item: currentGradient)
        currentGradient = previousGradients.pop()!
        return currentGradient
    }

    // MARK: Graphics stuff

    static private func gradientWithColors(color1: CGColor, color2: CGColor) -> CGImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = screenSize
        gradientLayer.colors = [color1, color2]
        UIGraphicsBeginImageContext(screenSize.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let gradient = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return gradient!.cgImage!
    }

    static private func gradientWithRandomColors() -> CGImage {
        let rand1 = randomColor()
        let rand2 = randomColor()
        return gradientWithColors(color1: rand1, color2: rand2)
    }

    static private func randomColor() -> CGColor {
        let h = CGFloat(Int.random(in: 0 ... 255))/255.0
        let s = CGFloat(Int.random(in: 0 ... 255))/255.0
        let b = CGFloat(Int.random(in: 75 ... 220))/255.0
        return UIColor(hue: h, saturation: s, brightness: b, alpha: 1.0).cgColor
    }

    static private var screenSize: CGRect {
        return UIScreen.main.nativeBounds
    }

}
