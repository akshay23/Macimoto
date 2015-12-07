//
//  ViewController.swift
//  Macimoto
//
//  Created by Akshay Bharath on 12/7/15.
//  Copyright © 2015 Akshay Bharath. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

  @IBOutlet var header: NSView!
  @IBOutlet var subHeader: NSView!
  @IBOutlet var credentialsView: NSView!
  @IBOutlet var usernameTxt: NSTextField!
  @IBOutlet var passwordTxt: NSSecureTextField!
  @IBOutlet var loginButton: NSButton!

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
  }

  override var representedObject: AnyObject? {
    didSet {
    // Update the view, if already loaded.
    }
  }


}

