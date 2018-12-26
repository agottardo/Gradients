//
//  GradientsBrain+Save.swift
//  Gradients
//
//  Created by Andrea Gottardo on 2018-12-26.
//  Copyright © 2018 Andrea Gottardo. All rights reserved.
//

import Foundation
import Photos

extension GradientsBrain {

    // MARK: Save to Camera Roll

    func saveLastGradientToCameraRoll(completion: @escaping (Error?) -> Void) {

        if previousGradients.isEmpty() {
            completion(NSError(domain: "No gradient generated yet.", code: 101, userInfo: nil))
            return
        }

        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: UIImage(cgImage: self.currentGradient))
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
