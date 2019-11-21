//
//  HomeLoadingViewController.swift
//  Feeds
//
//  Created by Vikram on 11/20/19.
//  Copyright © 2019 T-MOBILE USA, INC. All rights reserved.
//

import UIKit
import Shimmer

class HomeLoadingViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var shimmerView: FBShimmeringView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// Used to show shimmer animation while downloading the image with the help of facebook shimmer
    func startShimmering(title: String) {
        shimmerView.isHidden = false
        loadingLabel.isHidden = false
        refreshButton.isHidden = true
        loadingLabel.text = title
        shimmerView.contentView = loadingLabel
        self.shimmerView.isShimmering = true
    }
    
    /// Used to hide shimmer animation after downloading the image
    func stopShimmering() {
        self.shimmerView.isShimmering = false
        loadingLabel.isHidden = true
        shimmerView.isHidden = true
        refreshButton.isHidden = true
    }
    
    /// Used to show error message along with refresh button
    /// - Parameter text: error message
    func showErrorMessage(_ text: String) {
        loadingLabel.text = text
        loadingLabel.isHidden = false
        shimmerView.isHidden = false
        refreshButton.isHidden = false
    }
    
    /// This function is used to refesh data by calling api in view model
    /// - Parameter sender: refesh button
    @IBAction func refreshButtonTapped(_ sender: Any) {
        HomeViewModel.sharedInstance.configureData()
    }
}
