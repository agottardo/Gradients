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

    /// Model
    let brain = GradientsBrain()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Let's start with a fixed (ugly) gradient. 🎨
        setGradientView(toImage: brain.currentGradient)
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
    /// - Parameter toImage: image to set as currently displayed gradient.
    ///                      If nil, nothing will happen.
    func setGradientView(toImage: CGImage?) {
        if toImage == nil {
            return
        }
        SoundsBrain.shared.notifySuccess()
        gradientView.image = UIImage(cgImage: toImage!)
    }

    // - MARK: Change gradient logic

    /// Sets the current gradient to a random gradient.
    private func goNext() {
        setGradientView(toImage: brain.next())
    }

    /// Goes back to the previously displayed gradient.
    private func goBack() {
        setGradientView(toImage: brain.back())
    }

    // - MARK: Swipe gestures handler

    /// Allows the user to move forward and backwards by swiping on the screen.
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            goNext()
        } else if gesture.direction == .right {
            goBack()
        }

    }

    // - MARK: Save to Camera Roll

    /// Called when the user presses the 'Save to Camera Roll' button.
    @IBAction func didPressSaveButton(_ sender: Any) {
        brain.saveLastGradientToCameraRoll { (err) in
            if err != nil {
                let error = UIAlertController(title: "Error saving to Camera Roll.", message: err?.localizedDescription, preferredStyle: .alert)
                error.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(error, animated: true)
            } else {
                let notice = UIAlertController(title: "Gradient saved to Camera Roll", message: "Go to the Photos app to set this gradient as your wallpaper.", preferredStyle: .alert)
                notice.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(notice, animated: true)
            }
        }
    }

}
