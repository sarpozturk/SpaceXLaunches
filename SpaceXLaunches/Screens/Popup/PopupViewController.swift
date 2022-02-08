//
//  PopupViewController.swift
//  SpaceXLaunches
//
//  Created by Sarp  on 7.02.2022.
//

import UIKit

class PopupViewController: UIViewController {
    
    var viewSource: PopupView {
        return self.view as! PopupView
    }
    
    override func loadView() {
        view = PopupView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSourceObserver()
    }
    
    func setText(_ text: String) {
        viewSource.setText(text)
    }
}

extension PopupViewController {
    func viewSourceObserver() {
        viewSource.dissmissViewController = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
    }
}
