//
//  ViewController.swift
//  MeTube
//
//  Created by Abdulaziz AlObaili on 07/08/2019.
//  Copyright © 2019 Abdulaziz Alobaili. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController {
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
    }()
    
//    var videos: [Video] = {
//        var kanyeChannel = Channel()
//        kanyeChannel.name = "KanyeIsTheBestChannel"
//        kanyeChannel.profileImageName = "kanye_profile"
//
//        var blankSpaceVideo = Video()
//        blankSpaceVideo.thumbnailImageName = "taylor-swift-blank-space-thumbnail"
//        blankSpaceVideo.title = "Taylor Swift - Blank Space"
//        blankSpaceVideo.channel = kanyeChannel
//        blankSpaceVideo.numberOfViews = 93123503485
//
//        var badBloodVideo = Video()
//        badBloodVideo.thumbnailImageName = "taylor_swift_bad_blood"
//        badBloodVideo.title = "Taylor Swift - Bad Blood (feat. Kendrick Lamar)"
//        badBloodVideo.channel = kanyeChannel
//        badBloodVideo.numberOfViews = 23334432893
//
//        return [blankSpaceVideo, badBloodVideo]
//    }()
    
    var videos: [Video]?
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "  " + "Home"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        collectionView.backgroundColor = .white
        
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cellID")
        
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        setupMenuBar()
        setupNavBarButtons()
    }
    
    private func fetchVideos() {
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {
                print(error!)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [[String : Any]]
                
                self.videos = [Video]()
                
                json.forEach({ (dictionary) in
                    var video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let channelDictionary = dictionary["channel"] as! [String : Any]
                    
                    var channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    video.channel = channel
                    
                    self.videos?.append(video)
                })
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            } catch {
                print(error)
            }
            
        }.resume()
    }
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        
        NSLayoutConstraint.activate([
            menuBar.heightAnchor.constraint(equalToConstant: 50),
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.topAnchor.constraint(equalTo: view.topAnchor),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupNavBarButtons() {
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreImage = UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal)
        let moreBarButtonItem = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreBarButtonItem, searchBarButtonItem]
    }
    
    @objc func handleSearch() {
        
    }
    
    @objc func handleMore() {
        settingsLauncher.showSettings()
    }
    
    func showController(for setting: Setting) {
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.view.backgroundColor = .white
        dummySettingsViewController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }


}

// MARK: - UICollectionViewDelegate
extension HomeController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
}

// MARK: - UICollectionViewDataSource
extension HomeController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.row]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
