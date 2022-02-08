//
//  BaseViewController.swift
//  SpaceXLaunches
//
//  Created by Sarp  on 6.02.2022.
//

import UIKit

class BaseViewController: UIViewController {
    
    var loadingView = UIView(frame: .zero)
    var spinner = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showLoadingView() {
        loadingView = UIView(frame: view.bounds)
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubview(loadingView)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ])
        
        spinner.startAnimating()
    }

    func hideLoadingView() {
        spinner.stopAnimating()
        DispatchQueue.main.async {
            self.loadingView.removeFromSuperview()
        }
    }
    
    func showPopup(text: String) {
        let popupViewController = PopupViewController()
        popupViewController.setText(text)
        popupViewController.modalPresentationStyle = .overFullScreen
        popupViewController.modalTransitionStyle = .crossDissolve
        self.present(popupViewController, animated: true, completion: nil)
    }
}
