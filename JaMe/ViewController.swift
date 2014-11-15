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
  var currentMenu = 0

  override func viewDidLoad() {
    super.viewDidLoad()
    view.layerContentsPlacement = .ScaleProportionallyToFill
    for l in ["Movie", "TV Show", "Music", "Setting"] {
      let label = createLabel(l)
      menuView.addSubview(label)
      labels.append(label)
    }
  }

  override func moveLeft(sender: AnyObject?) {
    if currentMenu > 0 {
      move(-1)
    }
  }

  override func moveRight(sender: AnyObject?) {
    if currentMenu < labels.count - 1 {
      move(1)
    }
  }

  func move(dir: Int) {
    labels[currentMenu].deselect()
    currentMenu += dir
    labels[currentMenu].select()
    NSAnimationContext.runAnimationGroup({ context in
      self.forEachLabel() { label, x, y, w, h in
        label.animator().frame.origin.x = x
      }
    }) {}
  }

  override func viewDidLayout() {
    super.viewDidLayout()
    menuView.frame = menuFrame(view)
    let fontSize = menuFontSize(view)
    forEachLabel() { label, x, y, w, h in
      label.frame = NSRect(x: x, y: y, width: w, height: h)
      label.font = NSFont(name: "Helvetica Neue Light", size: fontSize)
    }
    labels[currentMenu].textColor = selectedColor()
  }

  func forEachLabel(fn: (LabelView, CGFloat, CGFloat, CGFloat, CGFloat) -> ()) {
    let w = menuItemWidth(view)
    var x = menuX(view, currentMenu)
    let y = CGFloat(0)
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
