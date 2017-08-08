//
//  LoaderView.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 04/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import UIKit

class LoaderView: UIView {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var loadingMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setComponentsIDs()
        setupAppearence()
    }
    
    private func setComponentsIDs() {
        accessibilityIdentifier = "LoaderView"
        indicatorView.accessibilityIdentifier = "LoaderView.indicatorView"
        loadingMessageLabel.accessibilityIdentifier = "LoaderView.loadingMessageLabel"
    }
    
    private func setupAppearence() {
        backgroundView.backgroundColor = Colors.black.color.withAlphaComponent(0.9)
        alertView.layer.cornerRadius = alertView.frame.size.height / 5
        loadingMessageLabel.textColor = Colors.primary.color
        indicatorView.color = Colors.primary.color
    }
    
    func startAnimation(with message: String = "") {
        loadingMessageLabel.text = message
        indicatorView.startAnimating()
    }
    
}
