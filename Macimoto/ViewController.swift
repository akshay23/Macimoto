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
  
  var oauthToken: String = ""

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
    let pstyle = NSMutableParagraphStyle()
    pstyle.alignment = NSTextAlignment.Center
    loginButton.attributedTitle = NSAttributedString(string: "Log In", attributes: [ NSForegroundColorAttributeName : NSColor.whiteColor(), NSParagraphStyleAttributeName : pstyle, NSFontAttributeName : NSFont.systemFontOfSize(16) ])
    
    // Focus on username box
    usernameTxt.becomeFirstResponder()
    
    // Get OAuth token (if empty)
    getOauthToken()
  }
  
  override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "unwindToVideos" && segue.destinationController.isKindOfClass(MyVideosVC.classForCoder()) {
      //let videosViewController = segue.destinationController as! MyVideosVC
    }
  }
  
  func getOauthToken() {
    if (oauthToken == "") {
      let request = Animoto.Router.requestAccessTokenURLStringAndParms()
      let authString = "\(Animoto.Router.clientID):\(Animoto.Router.clientSecret)"
      let encoded = authString.dataUsingEncoding(NSUTF8StringEncoding)!.base64EncodedStringWithOptions([])
      let headerVals = ["Authorization": "Basic \(encoded)", "Accept": "application/vnd.animoto-v4+json",
        "Content-Type": "application/vnd.animoto-v4+json", "User-Agent": "iPad 2 (WiFi) (OS 8.0) (Macimoto 1.0) (app_service 2.0)"]
      
      Alamofire.request(.POST, request.URLString, parameters: ["grant_type": "client_credentials"],
        encoding: .JSON, headers: headerVals)
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
}

// MARK - IBActions
extension ViewController {
  @IBAction func login(sender: AnyObject) {
    DJProgressHUD.showStatus("Loading..", fromView: view)
    
    // Validate user info
    let request = Animoto.Router.requestLoginStringAndParms()
    let headerVals = ["Authorization": "Bearer \(oauthToken)", "Accept": "application/vnd.animoto-v4+json",
      "Content-Type": "application/vnd.animoto-v4+json", "User-Agent": "iPad 2 (WiFi) (OS 8.0) (Macimoto 1.0) (app_service 2.0)"]
    
    Alamofire.request(.POST, request.URLString, parameters: ["grant_type": "password", "username": usernameTxt.stringValue,
      "password": passwordTxt.stringValue], encoding: .JSON, headers: headerVals)
      .responseJSON {
        (result) in
        
        debugPrint(result)
        
        if (result.result.isSuccess) {
          print("User is logged in now!!")
          self.checkmark1.hidden = false
          self.checkmark2.hidden = false
          DJProgressHUD.dismiss()
          self.performSegueWithIdentifier("unwindToVideos", sender: self)
        } else {
          DJProgressHUD.dismiss()
        }
    }
  }
}

