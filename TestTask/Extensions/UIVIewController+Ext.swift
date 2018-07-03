//
//  UIVIewController+Ext.swift
//  TestTask
//
//  Created by Oksana Kovalchuk on 7/3/18.
//  Copyright © 2018 Oksana Kovalchuk. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showError(_ error: Error?) {
        if error != nil {
            
            let controller = UIAlertController(title: "Error",
                                               message: error?.localizedDescription,
                                               preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Okay :<",
                                       style: .default,
                                       handler: { (action) in
                controller.dismiss(animated: true, completion: nil)
            })
            controller.addAction(action)
            present(controller, animated: true, completion: nil)
        }
    }
    
    /// I have extension for calculating diff betwwen show and hide events. But it will be overkill for this task
    func showProgress() {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)        }
    }
    
    func hideProgress() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)        }
    }
}
