//
//  MyVideosVC.swift
//  Macimoto
//
//  Created by Akshay Bharath on 12/7/15.
//  Copyright © 2015 Akshay Bharath. All rights reserved.
//

import Cocoa

class MyVideosVC: NSViewController {

  @IBOutlet var subHeader: NSView!
  
  var isLoggedIn: Bool = false

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Make BG of sub header black
    subHeader.wantsLayer = true
    let subHeaderLayer = subHeader.layer
    subHeaderLayer?.backgroundColor = CGColorCreateGenericRGB(0, 0, 0, 1)
  }
  
  override func viewDidAppear() {
    super.viewDidAppear()
  }
}
