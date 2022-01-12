//
//  UIKit+Ex.swift
//  SwiftRCON
//
//  Created by LeeSeGun on 2022/01/10.
//

import Foundation
import UIKit


extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = newValue > 0
            layer.cornerRadius = newValue
        }
    }
}

extension UITextView {
    func scrollToBottom() {
        let textCount: Int = text.count
        guard textCount >= 1 else { return }
        
        let range = NSMakeRange(text.lengthOfBytes(using: .utf8), 0);
        scrollRangeToVisible(range);
    }
}

extension UIApplication {
    public func runInBackground(_ closure: @escaping () -> Void, expirationHandler: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let taskID: UIBackgroundTaskIdentifier
            if let expirationHandler = expirationHandler {
                taskID = self.beginBackgroundTask(expirationHandler: expirationHandler)
            } else {
                taskID = self.beginBackgroundTask(expirationHandler: { })
            }
            closure()
            self.endBackgroundTask(taskID)
        }
    }
}
