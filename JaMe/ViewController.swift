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
  var labels: [NSTextField] = []
  var fontSize: CGFloat = 0
  var currentMenu = 0

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addConstraint(NSLayoutConstraint(item: menuView, attribute: .Height, relatedBy: .Equal,
                        toItem: view, attribute: .Height, multiplier: 0.15, constant: 0))
    view.layerContentsPlacement = .ScaleProportionallyToFill
    view.translatesAutoresizingMaskIntoConstraints = false
    menuView.translatesAutoresizingMaskIntoConstraints = false
    let w = menuItemWidth(view)
    var x: CGFloat = 0
    fontSize = menuFontSize(view)
    for l in ["Movie", "TV Show", "Music", "Setting"] {
      let label = createLabel(l, fontSize)
      menuView.addSubview(label)
      menuView.addConstraint(NSLayoutConstraint(item: label, attribute: .CenterX, relatedBy: .Equal,
        toItem: menuView, attribute: .CenterX, multiplier: 1, constant: x))
      menuView.addConstraint(NSLayoutConstraint(item: label, attribute: .CenterY, relatedBy: .Equal,
        toItem: menuView, attribute: .CenterY, multiplier: 1, constant: 0))
      labels.append(label)
      x += w
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
    var x = -w * CGFloat(currentMenu)
    NSAnimationContext.runAnimationGroup({ (context) in
      for cons in self.menuView.constraints as [NSLayoutConstraint] {
        if cons.firstAttribute == .CenterX {
          cons.animator().constant = x
          x += w
        }
      }
    }) {}
  }

  override func viewDidLayout() {
    super.viewWillLayout()
    fontSize = menuFontSize(view)
    for label in labels {
      label.font = NSFont(name: "Helvetica Neue Light", size: fontSize)
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
