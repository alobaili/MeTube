//
//  VideoCell.swift
//  MeTube
//
//  Created by Abdulaziz AlObaili on 07/08/2019.
//  Copyright © 2019 Abdulaziz Alobaili. All rights reserved.
//

import UIKit

class VideoCell: BaseCell {
    var video: Video? {
        didSet {
            titleLabel.text = video?.title
            
            setupThumbnailImage()
            
            setubProfileOmage()
            
            if let channelName = video?.channel?.name, let numberOfViews = video?.number_of_views {
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let subtitleText = "\(channelName) • \(numberFormatter.string(from: NSNumber(value: numberOfViews))!) • 2 years ago"
                subtitleTextView.text = subtitleText
            }
            
            // measure the title text
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)], context: nil)
                
                titleLabelHeightConstraint?.constant = estimatedRect.size.height > 20 ? 44 : 20
            }
        }
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.text = "Taylot Swift - Blank Space"
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "TaylorSwiftVEVO • 1,604,684,607 views • 2 years ago"
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.textColor = .lightGray
        return textView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return view
    }()
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(thumbnailImageView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            userProfileImageView.heightAnchor.constraint(equalToConstant: 44),
            userProfileImageView.widthAnchor.constraint(equalToConstant: 44),
            userProfileImageView.leadingAnchor.constraint(equalTo: thumbnailImageView.leadingAnchor),
            userProfileImageView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8),
            userProfileImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -36)
        ])
        
        titleLabelHeightConstraint = titleLabel.heightAnchor.constraint(equalToConstant: 20)
        NSLayoutConstraint.activate([
            titleLabelHeightConstraint!,
            titleLabel.leadingAnchor.constraint(equalTo: userProfileImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            subtitleTextView.heightAnchor.constraint(equalToConstant: 30),
            subtitleTextView.leadingAnchor.constraint(equalTo: userProfileImageView.trailingAnchor, constant: 8),
            subtitleTextView.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor),
            subtitleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4)
        ])
        
        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        thumbnailImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    }
    
    func setupThumbnailImage() {
        if let thumbnailImageURL = video?.thumbnail_image_name {
            thumbnailImageView.loadImageUsingURLString(urlString: thumbnailImageURL)
        }
    }
    
    func setubProfileOmage() {
        if let profileImageURL = video?.channel?.profile_image_name {
            userProfileImageView.loadImageUsingURLString(urlString: profileImageURL)
        }
    }
}
