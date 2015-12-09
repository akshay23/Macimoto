//
//  ViewController.swift
//  Macimoto
//
//  Created by Akshay Bharath on 12/7/15.
//  Copyright © 2015 Akshay Bharath. All rights reserved.
//

import Cocoa
import Alamofire
import SwiftyJSON
import DJProgressHUD_OSX

class ViewController: NSViewController {

  @IBOutlet var header: NSView!
  @IBOutlet var subHeader: NSView!
  @IBOutlet var credentialsView: NSView!
  @IBOutlet var usernameTxt: NSTextField!
  @IBOutlet var passwordTxt: NSSecureTextField!
  @IBOutlet var loginButton: NSButton!
  @IBOutlet var checkmark1: NSImageView!
  @IBOutlet var checkmark2: NSImageView!
  @IBOutlet var badLoginLabel: NSTextField!
  
  var oauthToken: String = ""
  var userID: Int = -1

  override func viewDidLoad() {
    super.viewDidLoad()

    // Make BG of sub header black
    subHeader.wantsLayer = true
    let subHeaderLayer = subHeader.layer
    subHeaderLayer?.backgroundColor = CGColorCreateGenericRGB(0, 0, 0, 1)
    
    // Change BG color of credentials view
    credentialsView.wantsLayer = true
    let credentialsLayer = credentialsView.layer
    credentialsLayer?.borderWidth = 1
    credentialsLayer?.borderColor = CGColorCreateGenericRGB(0, 0, 0, 1)
    credentialsLayer?.backgroundColor = CGColorCreateGenericRGB(255, 255, 255, 1)
    
    // Change color of the login button text
    loginButton.keyEquivalent = "\r"
    
    // Focus on username box
    passwordTxt.resignFirstResponder()
    usernameTxt.becomeFirstResponder()
    
    // Get OAuth token
    getOauthToken()
  }
  
  override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "unwindToVideos" && segue.destinationController.isKindOfClass(MyVideosVC.classForCoder()) {
      let videosViewController = segue.destinationController as! MyVideosVC
      videosViewController.oauthToken = self.oauthToken
      videosViewController.userID = self.userID
      videosViewController.loginVC = self
      videosViewController.getVideoData()
    }
  }
  
  func getOauthToken() {
    let request = Animoto.Router.requestAccessTokenURLStringAndParms()
    let authString = "\(Animoto.Router.clientID):\(Animoto.Router.clientSecret)"
    let encoded = authString.dataUsingEncoding(NSUTF8StringEncoding)!.base64EncodedStringWithOptions([])
    let headerVals = ["Authorization": "Basic \(encoded)", "Accept": "application/vnd.animoto-v4+json",
      "Content-Type": "application/vnd.animoto-v4+json", "User-Agent": "iPad 2 (WiFi) (OS 8.0) (Macimoto 1.0) (app_service 2.0)"]
    
    Alamofire.request(.POST, request.URLString, parameters: request.Params, encoding: .JSON, headers: headerVals)
      .responseJSON {
        (result) in
        
        if (result.result.isSuccess) {
          let json = JSON(result.result.value!)
          self.oauthToken = json["access_token"].stringValue
          print("The oauth token is \(self.oauthToken)")
        }
    }
  }
}

// MARK - IBActions
extension ViewController {
  @IBAction func login(sender: AnyObject) {
    badLoginLabel.hidden = true
    DJProgressHUD.showStatus("Loading..", fromView: view)
    
    // Validate user info
    let request = Animoto.Router.requestLoginStringAndParms(usernameTxt.stringValue, password: passwordTxt.stringValue)
    let headerVals = ["Authorization": "Bearer \(oauthToken)", "Accept": "application/vnd.animoto-v4+json",
      "Content-Type": "application/vnd.animoto-v4+json", "User-Agent": "iPad 2 (WiFi) (OS 8.0) (Macimoto 1.0) (app_service 2.0)"]
    
    Alamofire.request(.POST, request.URLString, parameters: request.Params, encoding: .JSON, headers: headerVals)
      .responseJSON {
        (result) in
        
        if (result.result.isSuccess) {
          let json = JSON(result.result.value!)
          print("User is logged in now!!")
          self.checkmark1.hidden = false
          self.checkmark2.hidden = false
          self.oauthToken = json["access_token"].stringValue
          self.userID = json["user"]["id"].intValue
          print("User auth token is \(self.oauthToken)")
          print("User ID is \(self.userID)")
          self.performSegueWithIdentifier("unwindToVideos", sender: self)
        } else {
          self.badLoginLabel.hidden = false
        }
        
        DJProgressHUD.dismiss()
    }
  }
}

