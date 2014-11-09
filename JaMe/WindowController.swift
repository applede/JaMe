//
//  WindowController.swift
//  JaMe
//
//  Created by Jake Song on 10/15/14.
//  Copyright (c) 2014 Jake Song. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

  override func windowDidLoad() {
    super.windowDidLoad()

    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    let screen = NSScreen.mainScreen()
    if let f = screen?.frame {
      if f.width >= 1920 && f.height >= 1080 {
      } else {
//        window?.toggleFullScreen(self)
      }
    }

    gwindow = window
  }

}

var gwindow: NSWindow?
