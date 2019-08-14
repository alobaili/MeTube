//
//  FeedCell.swift
//  MeTube
//
//  Created by Abdulaziz AlObaili on 13/08/2019.
//  Copyright © 2019 Abdulaziz Alobaili. All rights reserved.
//

import UIKit

class FeedCell: BaseCell {
    
    var homeControllerNavigationController: UINavigationController?
    
    lazy var collcetionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        return cv
    }()
    
    let cellID = "cellID"
    
    var videos: [Video]?
    
    override func setupViews() {
        super.setupViews()
        
        fetchVideos()
        
        backgroundColor = .brown
        
        addSubview(collcetionView)
        
        NSLayoutConstraint.activate([
            collcetionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collcetionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collcetionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collcetionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        collcetionView.register(VideoCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    func fetchVideos() {
        API.shared.fetchVideos { (result) in
            switch result {
            case .success(let videos):
                self.videos = videos
                DispatchQueue.main.async {
                    self.collcetionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension FeedCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.row]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FeedCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoLauncher = VideoLauncher()
        videoLauncher.showVideoPlayer()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FeedCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * 9 / 16
        return CGSize(width: frame.width, height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - UIScrollViewDelegate
extension FeedCell {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // When the scroll view's y position is greater than 0 it means we are scrolling down, so hide the navigation bar
        if scrollView.contentOffset.y > 0 {
            homeControllerNavigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            // When the scroll views's y position is less than or equal to 0, it means we are at the top of the feed, so show the navigation bar
            homeControllerNavigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}
