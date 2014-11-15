//
//  TextField.swift
//  JaMe
//
//  Created by Jake Song on 11/13/14.
//  Copyright (c) 2014 Jake Song. All rights reserved.
//

import Cocoa

class LabelView: NSView {
  var stringValue: NSString?
  var textColor: NSColor? {
    didSet {
      needsDisplay = true
    }
  }
  var font: NSFont?

  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  override func drawRect(dirtyRect: NSRect) {
    let fontAttr = font != nil ? font! : NSFont.systemFontOfSize(NSFont.systemFontSize())
    let color = textColor != nil ? textColor! : NSColor.labelColor()
    let attrs = [NSFontAttributeName: fontAttr,
                 NSForegroundColorAttributeName: color]
    if let str = stringValue {
      let size = str.sizeWithAttributes(attrs)
      str.drawAtPoint(NSPoint(x: (frame.width - size.width) / 2, y: (frame.height - size.height) / 2),
                      withAttributes: attrs)
    }
  }

  func select() {
    textColor = selectedColor()
  }

  func deselect() {
    textColor = unselectedColor()
  }
}
