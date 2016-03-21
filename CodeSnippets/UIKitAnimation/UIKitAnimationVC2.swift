//
//  ViewController2.swift
//  Animation
//
//  Created by Geek on 16-3-20.
//  Copyright (c) 2016年 GeekRRK. All rights reserved.
//

import UIKit

func delay(seconds seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds) )
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}

class UIKitAnimationVC2: UIViewController {
    let status = UIImageView(image: UIImage(named: "banner"))
    let label = UILabel()
    let message = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]
    var statusPosition = CGPoint.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        status.hidden = true
        status.center = CGPoint(x: 160, y: 300)
        view.addSubview(status)
        
        label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
        label.font = UIFont(name: "HelveticaNeue", size: 18.0)
        label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
        label.textAlignment = .Center
        status.addSubview(label)
        
        statusPosition = status.center
        
        delay(seconds: 1.0) {
            self.showMessage(index: 0)
        }
    }
    
    func showMessage(index index: Int) {
        label.text = message[index]
        
        UIView.transitionWithView(status, duration: 0.33, options: [.CurveEaseOut, .TransitionCurlDown], animations: {
            self.status.hidden = false
            }, completion: {_ in
                delay(seconds: 2.0) {
                    if index < self.message.count - 1 {
                        self.removeMessage(index: index)
                    } else {
                        
                    }
                }
        })
    }
    
    func removeMessage(index index: Int) {
        UIView.animateWithDuration(0.33, delay: 0.0, options: [], animations: {
            self.status.center.x += self.view.frame.width
            }, completion: {_ in
                self.status.hidden = true;
                self.status.center = self.statusPosition
                
                self.showMessage(index: index + 1)
        })
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
