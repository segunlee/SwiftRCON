//
//  AlertProvider.swift
//  SwiftRCON
//
//  Created by LeeSeGun on 2022/01/13.
//

import Foundation
import UIKit


class AlertProvider {
    class func textField(title: String,
                         pTitle: String = "Ok",
                         nTitle: String = "Cancel",
                         placeholder: String? = nil,
                         pClosure: ((String?) -> Void)? = nil,
                         nClosure: (() -> Void)? = nil) {
        var alertTextField: UITextField?
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let pAction = UIAlertAction(title: pTitle, style: .default) { _ in
            pClosure?(alertTextField?.text)
        }
        let nAction = UIAlertAction(title: nTitle, style: .default) { _ in
            nClosure?()
        }
        alert.addAction(pAction)
        alert.addAction(nAction)
        alert.addTextField { (tf: UITextField) in
            alertTextField = tf
            alertTextField?.placeholder = placeholder
        }
        UIApplication.getTopMostViewController()?.present(alert, animated: true, completion: nil)
    }
    
    class func actionSheet(title: String, dataSoruce: [String], selectionClosure: @escaping ((String) -> Void)) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        for name in dataSoruce {
            alert.addAction(UIAlertAction(title: name, style: .default, handler: { _ in
                selectionClosure(name)
            }))
        }
        UIApplication.getTopMostViewController()?.present(alert, animated: true, completion: nil)
    }
    
    class func message(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.getTopMostViewController()?.present(alert, animated: true, completion: nil)
    }
}
