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
  @IBOutlet var titleTxt: NSTextField!
  @IBOutlet var dateTxt: NSTextField!
  @IBOutlet var aboutLabel: NSTextField!
  @IBOutlet var aboutTxt: NSScrollView!
  @IBOutlet var userTxt: NSTextField!
  @IBOutlet var aboutTxtView: NSTextView!
  
  var videoData: (title: String, description: String, date: String, user: String, coverImageURL: String, videoURL: String)!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Make BG of sub header black
    subHeader.wantsLayer = true
    let subHeaderLayer = subHeader.layer
    subHeaderLayer?.backgroundColor = CGColorCreateGenericRGB(0, 0, 0, 1)
    
    // Show metadata
    titleTxt.stringValue = videoData.title
    dateTxt.stringValue = videoData.date
    userTxt.stringValue = videoData.user
    if (videoData.description != "") {
      aboutLabel.hidden = false
      aboutTxt.hidden = false
      aboutTxtView.string = videoData.description
    }
    
    // Set up video
    myPlayer.player = AVPlayer(URL: NSURL(string: self.videoData.videoURL)!)
  }

  @IBAction func backToVideos(sender: AnyObject) {
    myPlayer.player?.pause()
    myPlayer.player = nil
    view.removeFromSuperview()
    dismissViewController(self)
  }
}
