//
//  SoundsBrain.swift
//  Gradients
//
//  Created by Andrea Gottardo on 2018-11-23.
//  Copyright © 2018 Andrea Gottardo. All rights reserved.
//

import Foundation
import AVFoundation

/**
 Used to play UI sounds. 🎹
 */
class SoundsBrain {

    /// It's a singleton.
    static let shared = SoundsBrain()
    private init() {}

    var player: AVAudioPlayer?

    /// Notifies the user of a successful action.
    func notifySuccess() {
        do {
            if let fileURL = Bundle.main.path(forResource: "changed", ofType: "wav") {
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
            } else {
                print("SoundsBrain: can't find the audio file.")
            }
            player?.volume = 1.0
            player?.play()
        } catch let error {
            print("SoundsBrain: notifySuccess failed with \(error.localizedDescription)")
        }
    }

}
