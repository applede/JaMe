//
//  ViewController.swift
//  JaMe
//
//  Created by Jake Song on 10/15/14.
//  Copyright (c) 2014 Jake Song. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
  @IBOutlet weak var menuView: NSVisualEffectView!

  override func viewDidLoad() {
    super.viewDidLoad()
//    view.frame = NSRect(x: 0, y: 0, width: 960, height: 540)

//    view.addConstraint(NSLayoutConstraint(item: view, attribute: .Width, relatedBy: .Equal,
//                        toItem: nil, attribute: .Width, multiplier: 1.0, constant: 960))
//    view.addConstraint(NSLayoutConstraint(item: view, attribute: .Height, relatedBy: .Equal,
//                        toItem: nil, attribute: .Height, multiplier: 1.0, constant: 540))
    view.addConstraint(NSLayoutConstraint(item: menuView, attribute: .Height, relatedBy: .Equal,
                        toItem: view, attribute: .Height, multiplier: 0.2, constant: 0))
    view.layerContentsPlacement = .ScaleProportionallyToFill
    view.translatesAutoresizingMaskIntoConstraints = false
    menuView.translatesAutoresizingMaskIntoConstraints = false
    let label = NSTextField(frame: NSRect(x: 0, y: 0, width: 10, height: 10))
    label.translatesAutoresizingMaskIntoConstraints = false
    label.stringValue = "Movie"
    label.textColor = NSColor.labelColor()
    label.font = NSFont(name: "Helvetica Neue Light", size: 44)
    label.editable = false
    label.bordered = false
    label.drawsBackground = false
    label.alignment = .CenterTextAlignment
    label.sizeToFit()
    menuView.addSubview(label)
    menuView.addConstraint(NSLayoutConstraint(item: label, attribute: .CenterX, relatedBy: .Equal,
      toItem: menuView, attribute: .CenterX, multiplier: 1.0, constant: 0))
    menuView.addConstraint(NSLayoutConstraint(item: label, attribute: .CenterY, relatedBy: .Equal,
      toItem: menuView, attribute: .CenterY, multiplier: 1.0, constant: 0))
    menuView.addConstraint(NSLayoutConstraint(item: label, attribute: .Width, relatedBy: .Equal,
      toItem: menuView, attribute: .Width, multiplier: 0.2, constant: 0))
//    menuView.addConstraint(NSLayoutConstraint(item: label, attribute: .Height, relatedBy: .Equal,
//      toItem: menuView, attribute: .Height, multiplier: 0.9, constant: 0))
  }

  override var representedObject: AnyObject? {
    didSet {
    // Update the view, if already loaded.
    }
  }

  override func viewDidAppear() {
    super.viewDidAppear()
    displayRandomFanart()
  }

  var fanarts: [String] = []

  func displayRandomFanart() {
    let path = randomFanartPath()
    if let image = NSImage(contentsOfFile: path) {
      let desiredScaleFactor = gwindow?.backingScaleFactor
      let actualScaleFactor = image.recommendedLayerContentsScale(desiredScaleFactor!)

      self.view.layer?.contents = image.layerContentsForContentsScale(actualScaleFactor)
      self.view.layer?.contentsScale = actualScaleFactor
      let crossfade = CABasicAnimation(keyPath:"contents")
      crossfade.duration = 0.5
      crossfade.removedOnCompletion = true
      self.view.layer?.addAnimation(crossfade, forKey:nil)
    }
    after(7) {
      self.displayRandomFanart()
    }
  }

  func randomFanartPath() -> String {
    if fanarts.count == 0 {
      let base = "/Users/apple/hobby/test_jamp/movie"
      if let e = NSFileManager.defaultManager().enumeratorAtPath(base) {
        while let item = e.nextObject() as? String {
          if item.lastPathComponent == "fanart.jpg" {
            fanarts.append(base.stringByAppendingPathComponent(item))
          }
        }
      } else {
        return ""
      }
    }
    return fanarts[Int(arc4random_uniform(UInt32(fanarts.count)))]
  }

}

