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

func createLabel(text: String, fontSize: CGFloat) -> NSTextField {
  let label = NSTextField(frame: NSRect(x: 0, y: 0, width: 10, height: 10))
  label.translatesAutoresizingMaskIntoConstraints = false
  label.stringValue = text
  label.textColor = NSColor.labelColor()
  label.font = menuFont(fontSize)
  label.editable = false
  label.bordered = false
  label.drawsBackground = false
  label.alignment = .CenterTextAlignment
//  label.sizeToFit()
  label.setContentHuggingPriority(250, forOrientation: .Vertical)
  return label
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
