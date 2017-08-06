//
//  UIViewController+Extensions.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 04/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import Foundation
import UIKit

struct AlertDTO {
    var title: String
    var message: String
    var positiveActionTitle: String
    var negativeActionTitle: String?
}

extension UIViewController {
    
    func showConnectionErrorAlert(dto: AlertDTO, completion: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: dto.title, message: dto.message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: dto.positiveActionTitle, style: .default, handler: completion))
        if let negativeActionTitle = dto.negativeActionTitle {
            alertController.addAction(UIAlertAction(title: negativeActionTitle, style: .default, handler: completion))
        }
        present(alertController, animated: true, completion: nil)
    }
    
    func showLoader(with message: String = "carregando jogos...".localized) {
        let loader: LoaderView = UIView.fromNib()
        loader.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let window = UIApplication.shared.keyWindow
        window?.addSubview(loader)
        window?.bringSubview(toFront: loader)
        loader.startAnimation(with: message)
    }
    
    func stopLoader() {
        let window = UIApplication.shared.keyWindow
        window?.subviews.forEach { if $0.isKind(of: LoaderView.self) { $0.removeFromSuperview() } }
    }
    
    func addSpecialNavigation(with title: String, and id: String = "") {
        let titleLabel = UILabel()
        self.title = ""
        titleLabel.fill(with: title, and: LabelStyle.navigation)
        titleLabel.sizeToFit()
        titleLabel.accessibilityIdentifier = "\(id).navigation.title"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }
    
}
