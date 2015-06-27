//
//  ViewController.swift
//  Demo
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit
import Swifternalization

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Swifternalization(bundle: NSBundle.mainBundle())
        let a = I18N.localizedString("welcome")
        println(a)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

