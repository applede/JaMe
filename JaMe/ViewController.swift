//
//  ViewController.swift
//  JaMe
//
//  Created by Jake Song on 10/15/14.
//  Copyright (c) 2014 Jake Song. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
  var homeViewController: HomeViewController!

  override func viewDidLoad() {
    super.viewDidLoad()
    homeViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
    homeViewController.view.frame = view.frame
    view.addSubview(homeViewController.view)
    addChildViewController(homeViewController)
  }

  override var representedObject: AnyObject? {
    didSet {
    // Update the view, if already loaded.
    }
  }

}
