//
//  SwiftViewController.swift
//  CodeSnippets
//
//  Created by UGOMEDIA on 16/5/11.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

import UIKit

class SwiftViewController: UIViewController {

    static let sharedInstance = SwiftViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var total = 0
        for i in 0 ..< 4 {
            total += i
        }
        print(total)
        
        total = 0
        for i in 0 ... 4 {
            total += i
        }
        print(total)
    }

}
