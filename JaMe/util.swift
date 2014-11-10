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
