//
//  ViewController.swift
//  DemoOrdering
//
//  Created by Tomasz Szulc on 28/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit
import Swifternalization

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        order()
    }
    
    func order() {
        Swifternalization(bundle: NSBundle.mainBundle())
        
        println(Swifternalization.localizedString("hello-base-test"))
        
        for num in 0...1000 {
            let format = Swifternalization.localizedExpressionString("cars", value: "\(num)")
            let localizedString = String(format: format, num)
            println(localizedString)
        }
    }
}
