//
//  util.swift
//  JaMe
//
//  Created by Jake Song on 11/9/14.
//  Copyright (c) 2014 Jake Song. All rights reserved.
//

import Foundation
import Cocoa

func after(sec: Int, closure: ()->()) {
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(sec) * Int64(NSEC_PER_SEC)), dispatch_get_main_queue(), closure)
}

func createLabel(text: String) -> LabelView {
  let label = LabelView(frame: NSRect(x: 0, y: 0, width: 10, height: 10))
  label.stringValue = text
  label.textColor = unselectedColor()
  label.setContentHuggingPriority(250, forOrientation: .Vertical)
  return label
}

func menuFrame(view: NSView) -> NSRect {
  return NSRect(x: 0.0, y: view.frame.height / 5.0, width: view.frame.width, height: view.frame.height / 6.0)
}

func menuFont(size: CGFloat) -> NSFont {
  return NSFont(name: "Helvetica Neue Light", size: size)!
}

func menuFontSize(view: NSView) -> CGFloat {
  return view.frame.height / 540 * 44
}

func menuItemWidth(view: NSView) -> CGFloat {
  return view.frame.width * 0.25
}

func menuX(view: NSView, currentMenu: Int) -> CGFloat {
  let w = menuItemWidth(view)
  return view.frame.width / 2 - w / 2 - w * CGFloat(currentMenu)
}

func selectedColor() -> NSColor {
  return NSColor.selectedControlTextColor()
}

func unselectedColor() -> NSColor {
  return NSColor.disabledControlTextColor()
}
