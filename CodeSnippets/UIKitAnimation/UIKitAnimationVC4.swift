//
//  ViewController4.swift
//  Animation
//
//  Created by Geek on 16-3-20.
//  Copyright (c) 2016年 GeekRRK. All rights reserved.
//

import UIKit

class UIKitAnimationVC4: UIViewController {

    @IBOutlet weak var planeImage: UIImageView!
    
    func planeDepart() {
        let originalCenter = planeImage.center
        
        UIView.animateKeyframesWithDuration(1.5, delay: 0.0, options: .Repeat, animations: {
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.25, animations: {
                self.planeImage.center.x += 80.0
                self.planeImage.center.y -= 10.0
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.1, relativeDuration: 0.4, animations: {
                self.planeImage.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_4 / 2))
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.25, relativeDuration: 0.25, animations: {
                self.planeImage.center.x += 100.0
                self.planeImage.center.y -= 50.0
                self.planeImage.alpha = 0.0
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.51, relativeDuration: 0.01, animations: {
                self.planeImage.transform = CGAffineTransformIdentity
                self.planeImage.center = CGPoint(x: 0.0, y: originalCenter.y)
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.55, relativeDuration: 0.45, animations: {
                self.planeImage.alpha = 1.0
                self.planeImage.center = originalCenter
            })
            
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        planeDepart()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
