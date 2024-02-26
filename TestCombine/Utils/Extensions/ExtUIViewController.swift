//
//  ExtUIViewController.swift
//  TestCombine
//
//  Created by Fermin Esquisabel Garcia on 26/2/24.
//

import UIKit

var vSpinner: UIView?

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    
    func showProgress(onView: UIView?) {
        if let view = onView {
            DispatchQueue.main.async {
                let spinnerView = UIView.init(frame: view.bounds)
                spinnerView.backgroundColor = .black
                spinnerView.alpha = 0.2
                
                let ai = UIActivityIndicatorView.init(style: .large)
                ai.color = .white
                ai.startAnimating()
                ai.center = spinnerView.center
                
                DispatchQueue.main.async {
                    spinnerView.addSubview(ai)
                    view.addSubview(spinnerView)
                }
                
                vSpinner = spinnerView
            }
        }
    }
    
    func hideProgress() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner?.isHidden = true
            vSpinner = nil
        }
    }
}
