//
//  ViewController.swift
//  CatchTrans
//
//  Created by itsector on 09/03/2020.
//  Copyright © 2020 itsector. All rights reserved.
//http://camendesign.com/code/video_for_everybody/test.html

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    lazy var thumbnailImageView: UIImageView = {
       
        return UIImageView()
    }()
    
    lazy var popupView: UIView = {
       
        let _popupView = UIView()
        
        _popupView.backgroundColor = UIColor.gray
        
        return _popupView
        
    }()
    
    var bottomConstraint = NSLayoutConstraint()
    
    var popupOffset: CGFloat = 0
    
    var viewHeight: CGFloat = 0
    
    lazy var videoView: UIView = {
        
        return UIView()
    
    }()
    
    let videoURLString: String = Bundle.main.path(forResource: "clip", ofType: "mp4")!
    
    var url: URL  {
        return URL(fileURLWithPath: videoURLString)
    }
    
    lazy var asset: AVURLAsset = {
       
        var asset: AVURLAsset = AVURLAsset(url: url)
        
        return asset
    }()
    
    lazy var playerItem: AVPlayerItem = {
        
        var playerItem: AVPlayerItem = AVPlayerItem(asset: self.asset)
        
        return playerItem
    }()
    
    lazy var player: AVPlayer = {
        var player: AVPlayer = AVPlayer(playerItem: self.playerItem)
        
        player.actionAtItemEnd = .none
        
        return player
    }()
    
    lazy var playerLayer: AVPlayerLayer = {
       
        var playerLayer: AVPlayerLayer = AVPlayerLayer(player: self.player)
        
        return playerLayer
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewHeight = view.frame.size.height
        
        popupOffset = viewHeight - CGFloat(60)
        
        layout()
    }
    
    func layout() {
        
        popupView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(popupView)
        
        popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        bottomConstraint = popupView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: popupOffset)
        
        bottomConstraint.isActive = true
        
        popupView.heightAnchor.constraint(equalToConstant: viewHeight).isActive = true
        
        view.addSubview(videoView)
        
        videoView.translatesAutoresizingMaskIntoConstraints = false
        
        videoView.backgroundColor = UIColor.white
        
        videoView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 30).isActive = true
        
        videoView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -30).isActive = true
        
        videoView.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 60)
        
        NSLayoutConstraint(item: videoView, attribute: .height, relatedBy: .equal, toItem: videoView, attribute: .width, multiplier: 1, constant: 0).isActive = true
        
        view.addSubview(thumbnailImageView)
        
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        
        thumbnailImageView.backgroundColor = UIColor.white
        
        thumbnailImageView.leadingAnchor.constraint(lessThanOrEqualTo: popupView.leadingAnchor, constant: 10).isActive = true
        
        thumbnailImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        thumbnailImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        thumbnailImageView.contentMode = .scaleAspectFit
        
        videoView.layer.insertSublayer(playerLayer, at: 0)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        playerLayer.frame = videoView.bounds
        
    }
    
    func getThumbnailImage () -> UIImage? {
        
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        
        assetImgGenerate.appliesPreferredTrackTransform = true
        
        let time = CMTimeMakeWithSeconds(Float64(5), preferredTimescale: 600)
        
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            
            let thumbnail = UIImage(cgImage: img)
            
            return thumbnail
        } catch {
            
            return nil
        }
    }
}

extension AVPlayer {

    var isPlaying: Bool {
        
        return (rate != 0 && (error == nil))
    }
}

