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

    view.addConstraint(NSLayoutConstraint(item: menuView, attribute: .Height, relatedBy: .Equal,
                        toItem: view, attribute: .Height, multiplier: 0.2, constant: 0))
    view.layerContentsPlacement = .ScaleProportionallyToFill
  }

  override var representedObject: AnyObject? {
    didSet {
    // Update the view, if already loaded.
    }
  }

  override func viewDidAppear() {
//    if let image = NSImage(contentsOfFile: "/Users/apple/hobby/test_jamp/movie/5 Centimeters Per Second (2007)/fanart.jpg") {
    if let image = NSImage(contentsOfFile: "/Users/apple/hobby/test_jamp/movie/About Time (2013)/fanart.jpg") {
      let desiredScaleFactor = gwindow?.backingScaleFactor
      let actualScaleFactor = image.recommendedLayerContentsScale(desiredScaleFactor!)

      self.view.layer?.contents = image.layerContentsForContentsScale(actualScaleFactor)
      self.view.layer?.contentsScale = actualScaleFactor

    }
    self.menuView.layer?.backgroundColor = NSColor(calibratedWhite: 1.0, alpha: 1.0).CGColor
  }

}

