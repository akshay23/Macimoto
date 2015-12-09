//
//  MyVideosVC.swift
//  Macimoto
//
//  Created by Akshay Bharath on 12/7/15.
//  Copyright © 2015 Akshay Bharath. All rights reserved.
//

import Cocoa
import Alamofire
import SwiftyJSON
import DJProgressHUD_OSX

class MyVideosVC: NSViewController {

  @IBOutlet var subHeader: NSView!
  @IBOutlet var videoTable: NSTableView!
  
  var loginVC: ViewController?
  var oauthToken: String = ""
  var userID: Int = -1
  var videos: [(title: String, description: String, date: String, user: String, coverImageURL: String, videoURL: String)] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Table stuff
    videoTable.rowSizeStyle = NSTableViewRowSizeStyle.Custom
    
    // Make BG of sub header black
    subHeader.wantsLayer = true
    let subHeaderLayer = subHeader.layer
    subHeaderLayer?.backgroundColor = CGColorCreateGenericRGB(0, 0, 0, 1)
  }
  
  override func viewDidAppear() {
    super.viewDidAppear()
    
    getVideoData()
  }
  
  override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showVideo" && segue.destinationController.isKindOfClass(VideoPlayerVC.classForCoder()) {
      let videoPlayerViewController = segue.destinationController as! VideoPlayerVC
      videoPlayerViewController.videoData = videos[videoTable.selectedRow]
    }
  }
  
  func getVideoData() {
    DJProgressHUD.showStatus("Getting Videos..", fromView: view)
    
    let request = Animoto.Router.requestProjectsWithPageNumber(userID, page: 1)
    let headerVals = ["Authorization": "Bearer \(oauthToken)", "Accept": "application/vnd.animoto-v4+json",
      "Content-Type": "application/vnd.animoto-v4+json", "User-Agent": "iPad 2 (WiFi) (OS 8.0) (Macimoto 1.0) (app_service 2.0)"]
    
    Alamofire.request(.GET, request.URLString, parameters: nil, encoding: .JSON, headers: headerVals)
      .responseJSON {
        (result) in
        
        if (result.result.isSuccess) {
          let json = JSON(result.result.value!)
          let projects = json["response"]["payload"]["projects"].arrayValue
          for project in projects {
            let videos = project["videos"].arrayValue
            for video in videos {
              var videoURL = ""
              var videoDate = ""
              let videoTitle = video["title"].stringValue
              let videoDescription = video["description"].stringValue
              let videoUser = video["producer"].stringValue
              let videoThumbnail = video["links"]["thumbnail_image"].stringValue
              let videoFormats = video["video_formats"].arrayValue
              for format in videoFormats {
                if (format["purpose"].stringValue == "final" && videoURL == "") {
                  videoURL = format["links"]["file"].stringValue
                  videoDate = format["created_at"].stringValue
                }
              }
              self.videos.append((videoTitle, videoDescription, videoDate, videoUser, videoThumbnail, videoURL))
            }
          }
          self.videoTable.reloadData()
        }
        
        DJProgressHUD.dismiss()
    }

  }

  @IBAction func logout(sender: AnyObject) {
    loginVC!.usernameTxt.stringValue = ""
    loginVC!.passwordTxt.stringValue = ""
    loginVC!.checkmark1.hidden = true
    loginVC!.checkmark2.hidden = true
    loginVC!.usernameTxt.becomeFirstResponder()
    view.removeFromSuperview()
    dismissViewController(self)
  }
}

extension MyVideosVC: NSTableViewDataSource {
  func numberOfRowsInTableView(tableView: NSTableView) -> Int {
    if (videos.count > 0) {
      tableView.hidden = false
    }
    return videos.count
  }
  
  func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
    return 100
  }
  
  func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
    let cell = tableView.makeViewWithIdentifier("VideoCell", owner: self) as! NSTableCellView
    
    cell.textField!.stringValue = videos[row].title
    cell.imageView!.imageFromUrl(videos[row].coverImageURL)
    
    return cell
  }
}

extension MyVideosVC: NSTableViewDelegate {
  func tableViewSelectionDidChange(notification: NSNotification) {
    if (videoTable.selectedRow < videos.count && videoTable.selectedRow > -1) {
      performSegueWithIdentifier("showVideo", sender: self)
    }
  }
}

extension NSImageView {
  public func imageFromUrl(urlString: String) {
    if let url = NSURL(string: urlString) {
      let request = NSURLRequest(URL: url)
      NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
        (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
        if let imageData = data as NSData? {
          self.image = NSImage(data: imageData)
        }
      }
    }
  }
}

