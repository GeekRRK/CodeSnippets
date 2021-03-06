//
//  ViewController.swift
//  Animation
//
//  Created by Geek on 16-3-20.
//  Copyright (c) 2016年 GeekRRK. All rights reserved.
//

import UIKit

class UIKitAnimationVC1: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view2.alpha = 0;
        self.view3.alpha = 0;
        
        self.animateView1()
        self.animateView2()
        self.animateView3()
    }
    
    func animateView1() {
        UIView.animate(withDuration: 5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .repeat, animations: { () -> Void in
            self.view1.center.y += 60
            }) { (Bool) -> Void in
                print("view1: complete")
        }
    }
    
    func animateView2() {
        UIView.animate(withDuration: 5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .repeat, animations: { () -> Void in
            self.view2.alpha = 1
        }) { (Bool) -> Void in
            print("view2: complete")
        }
    }
    
    func animateView3() {
        UIView.animate(withDuration: 5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .repeat, animations: { () -> Void in
            self.view3.alpha = 1
            self.view3.center.y -= 60;
        }) { (Bool) -> Void in
            print("view3: complete")
        }
    }

}

