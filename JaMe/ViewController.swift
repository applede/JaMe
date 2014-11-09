//
//  ViewController.swift
//  JaMe
//
//  Created by Jake Song on 10/15/14.
//  Copyright (c) 2014 Jake Song. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
  @IBOutlet weak var menuView: NSView!

  override func viewDidLoad() {
    super.viewDidLoad()

//    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[menuView]|", options: nil,
//                        metrics: nil, views:["menuView": self.menuView]))
//    view.superview!.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options: nil, metrics: nil, views:["view": self.view]))
//    let menuView = NSView()
//    view.addSubview(menuView)
//    menuView.translatesAutoresizingMaskIntoConstraints = false
//    view.translatesAutoresizingMaskIntoConstraints = false


//    view.addConstraint(NSLayoutConstraint(item: menuView, attribute: .Bottom, relatedBy: .Equal,
//                        toItem: view, attribute: .Bottom, multiplier: 0.8, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: menuView, attribute: .Height, relatedBy: .Equal,
                        toItem: view, attribute: .Height, multiplier: 0.2, constant: 0))
//    menuView.layer?.backgroundColor = NSColor.whiteColor().CGColor
//    view.needsLayout = true

    // Do any additional setup after loading the view.
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1_000_000_000), dispatch_get_main_queue(), {
////      self.view.layout()
//      if let image = NSImage(contentsOfFile: "/Users/apple/hobby/test_jamp/movie/5 Centimeters Per Second (2007)/fanart.jpg") {
//        let desiredScaleFactor = gwindow?.backingScaleFactor
//        let actualScaleFactor = image.recommendedLayerContentsScale(desiredScaleFactor!)
//
//        self.view.layer?.contents = image.layerContentsForContentsScale(actualScaleFactor)
//        self.view.layer?.contentsScale = actualScaleFactor
//        self.menuView.layer?.backgroundColor = NSColor.whiteColor().CGColor
//
//      }
//    })
  }

  override var representedObject: AnyObject? {
    didSet {
    // Update the view, if already loaded.
    }
  }

  override func viewDidAppear() {
    if let image = NSImage(contentsOfFile: "/Users/apple/hobby/test_jamp/movie/5 Centimeters Per Second (2007)/fanart.jpg") {
      let desiredScaleFactor = gwindow?.backingScaleFactor
      let actualScaleFactor = image.recommendedLayerContentsScale(desiredScaleFactor!)

      self.view.layer?.contents = image.layerContentsForContentsScale(actualScaleFactor)
      self.view.layer?.contentsScale = actualScaleFactor

    }
    self.menuView.layer?.backgroundColor = NSColor.whiteColor().CGColor
  }

}

