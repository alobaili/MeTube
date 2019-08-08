//
//  VideoCell.swift
//  MeTube
//
//  Created by Abdulaziz AlObaili on 07/08/2019.
//  Copyright © 2019 Abdulaziz Alobaili. All rights reserved.
//

import UIKit

class VideoCell: BaseCell {
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "taylor-swift-blank-space-thumbnail")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "taylor-swift-profile-image")
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
            userProfileImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
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
}
