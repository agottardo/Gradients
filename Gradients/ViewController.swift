//
//  ViewController.swift
//  Gradients
//
//  Created by Andrea Gottardo on 2018-11-23.
//  Copyright © 2018 Andrea Gottardo. All rights reserved.
//

import UIKit
import AVFoundation

/**
 Application UI entry point. GradientsBrain is the corresponding model.
 */
class ViewController: UIViewController {
    
    /// The container for the gradient.
    @IBOutlet weak var gradientView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Let's start with a fixed (ugly) gradient. 🎨
        setGradientView(toImage: GradientsBrain.shared.gradientWithColors(color1: UIColor.red.cgColor, color2: UIColor.green.cgColor))
        // Allow the user to change the gradient with a left swipe... 👈
        gradientView.isUserInteractionEnabled = true
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        gradientView.addGestureRecognizer(swipeLeft)
        // ... and to go back to the previous gradient with a right swipe. 👉
        let swipeR = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeR.direction = .right
        gradientView.addGestureRecognizer(swipeR)
    }
    
    /// Sets the content of the container to the given CGImage.
    /// - Parameter toImage: image to set as currently displayed gradient
    func setGradientView(toImage: CGImage) {
        SoundsBrain.shared.notifySuccess()
        gradientView.image = UIImage(cgImage: toImage)
    }
    
    // - MARK: Save to Camera Roll
    
    /// Called when the user presses the 'Save to Camera Roll' button.
    @IBAction func didPressSaveButton(_ sender: Any) {
        GradientsBrain.shared.saveLastGradientToCameraRoll { (err) in
            if err != nil {
                let error = UIAlertController(title: "Error saving to Camera Roll.", message: err?.localizedDescription, preferredStyle: .alert)
                error.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(error, animated: true)
            }
        }
        
    }
    
    // - MARK: Shake handler
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    /// Sets a random gradient if the user shakes the device.
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            goRandom()
        }
    }
    
    // - MARK: Change gradient logic
    
    /// Sets the current gradient to a random gradient.
    private func goRandom() {
        setGradientView(toImage: GradientsBrain.shared.gradientWithRandomColors())
    }
    
    /// Goes back to the previously displayed gradient.
    private func goBack() {
        if GradientsBrain.shared.hasPrevious() {
            setGradientView(toImage: GradientsBrain.shared.revertToPrevious()!)
        }
    }
    
    // - MARK: Swipe gestures handler
    
    /// Allows the user to move forward and backwards by swiping on the screen.
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .left {
            goRandom()
        } else if gesture.direction == .right {
            goBack()
        }
        
    }


}

