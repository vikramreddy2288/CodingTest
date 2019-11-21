//
//  ImageDescriptionCell.swift
//  Feeds
//
//  Created by Vikram on 11/20/19.
//  Copyright © 2019 T-MOBILE USA, INC. All rights reserved.
//

import UIKit
import SDWebImage
import Shimmer

class ImageDescriptionCell: BaseTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint?
    @IBOutlet weak var shimmerView: FBShimmeringView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    /// Clean up the view elements in the table before they were reused
    override func prepareForReuse() {
        titleLabel.attributedText = nil
        descriptionLabel.attributedText = nil
        cardImageView.image = nil
        shimmerView.isHidden = true
        loadingLabel.isHidden = true
    }
    
    /// Used to configure the view
    /// - Parameter option: receives table options as input which has all the information required for that view
    override func configureUI(option: TableOption) {
        tableOption = option
        titleLabel.attributedText = option.title
        descriptionLabel.attributedText = option.description
        configureImage()
        layoutIfNeeded()
    }
    
    
    /// Used to configure image view, uses SDWebImage to download the image and assign it to the imageview
    func configureImage() {
        if let imageUrl = tableOption?.image, let url = URL(string: imageUrl) {
            startShimmering()
            cardImageView?.sd_setImage(with: url, completed: { [weak self] (image, error, cacheType, url) in
                guard let self = self else {
                    return
                }
                self.stopShimmering()
                self.cardImageView.image = image
            })
        }
        if let imageHeight = tableOption?.imageHeight, imageHeight != 0 {
            imageHeightConstraint?.constant = CGFloat(imageHeight)
        }
        layoutIfNeeded()
    }
    
    
    /// Used to show shimmer animation while downloading the image with the help of facebook shimmer
    func startShimmering() {
        shimmerView.isHidden = false
        loadingLabel.isHidden = false
        shimmerView.contentView = loadingLabel
        self.shimmerView.isShimmering = true
    }
    
    /// Used to hide shimmer animation after downloading the image 
    func stopShimmering() {
        self.shimmerView.isShimmering = false
        loadingLabel.isHidden = true
        shimmerView.isHidden = true
    }
}

