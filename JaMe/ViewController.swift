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
  var labels: [LabelView] = []
  var fontSize: CGFloat = 0
  var currentMenu = 0

  override func viewDidLoad() {
    super.viewDidLoad()
//    view.addConstraint(NSLayoutConstraint(item: menuView, attribute: .Height, relatedBy: .Equal,
//                        toItem: view, attribute: .Height, multiplier: 0.15, constant: 0))
    menuView.frame = NSRect(x: 0, y: view.frame.height / 5, width: view.frame.width,
                            height: view.frame.height / 6)
    view.layerContentsPlacement = .ScaleProportionallyToFill
    view.translatesAutoresizingMaskIntoConstraints = true
    menuView.translatesAutoresizingMaskIntoConstraints = true
//    let w = menuItemWidth(view)
//    var x: CGFloat = view.frame.width / 2 - w / 2
//    let y: CGFloat = 0
//    let h = menuView.frame.height
    fontSize = menuFontSize(view)
    for l in ["Movie", "TV Show", "Music", "Setting"] {
      let label = createLabel(l, fontSize)
//      label.frame = NSRect(x: x, y: y, width: w, height: h)
      menuView.addSubview(label)
//      menuView.addConstraint(NSLayoutConstraint(item: label, attribute: .CenterX, relatedBy: .Equal,
//        toItem: menuView, attribute: .CenterX, multiplier: 1, constant: x))
//      menuView.addConstraint(NSLayoutConstraint(item: label, attribute: .CenterY, relatedBy: .Equal,
//        toItem: menuView, attribute: .CenterY, multiplier: 1, constant: 0))
      labels.append(label)
//      x += w
    }
  }

  override func moveLeft(sender: AnyObject?) {
    ++currentMenu
    move()
  }

  override func moveRight(sender: AnyObject?) {
    --currentMenu
    move()
  }

  func move() {
    let w = menuItemWidth(view)
    var x = menuX(view, currentMenu)
    NSAnimationContext.runAnimationGroup({ (context) in
      self.forEachLabel({ label, x, y, w, h in
        label.animator().frame.origin.x = x
      })
    }) {}
  }

  override func viewDidLayout() {
    super.viewDidLayout()
    fontSize = menuFontSize(view)
    forEachLabel({ label, x, y, w, h in
      label.frame = NSRect(x: x, y: y, width: w, height: h)
      label.font = NSFont(name: "Helvetica Neue Light", size: self.fontSize)
    })
  }

  func forEachLabel(fn: (LabelView, CGFloat, CGFloat, CGFloat, CGFloat) -> ()) {
    let w = menuItemWidth(view)
    var x = menuX(view, currentMenu)
    let y: CGFloat = 0
    let h = menuView.frame.height
    for label in labels {
      fn(label, x, y, w, h)
      x += w
    }
  }

  override var representedObject: AnyObject? {
    didSet {
    // Update the view, if already loaded.
    }
  }

  override func viewDidAppear() {
    super.viewDidAppear()
    gwindow?.makeFirstResponder(view)
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
