//
//  VideoPlayerVC.swift
//  Macimoto
//
//  Created by Akshay Bharath on 12/7/15.
//  Copyright © 2015 Akshay Bharath. All rights reserved.
//

import Cocoa
import AVKit
import AVFoundation

class VideoPlayerVC: NSViewController {

  @IBOutlet var subHeader: NSView!
  @IBOutlet var myPlayer: AVPlayerView!
  
  var videoData: (title: String, coverImageURL: String, videoURL: String)!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Make BG of sub header black
    subHeader.wantsLayer = true
    let subHeaderLayer = subHeader.layer
    subHeaderLayer?.backgroundColor = CGColorCreateGenericRGB(0, 0, 0, 1)
    
    // Set up video
    myPlayer.player = AVPlayer(URL: NSURL(string: self.videoData.videoURL)!)
  }

  @IBAction func backToVideos(sender: AnyObject) {
    myPlayer.player?.pause()
    myPlayer.player = nil
    dismissViewController(self)
  }
}
