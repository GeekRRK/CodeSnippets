//
//  ViewController2.swift
//  Animation
//
//  Created by Geek on 16-3-20.
//  Copyright (c) 2016年 GeekRRK. All rights reserved.
//

import UIKit

func delay(seconds: Double, completion:@escaping ()->()) {
    let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds)) / Double(NSEC_PER_SEC)
    
    DispatchQueue.main.asyncAfter(deadline: popTime) {
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

        status.isHidden = true
        status.center = CGPoint(x: 160, y: 300)
        view.addSubview(status)
        
        label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
        label.font = UIFont(name: "HelveticaNeue", size: 18.0)
        label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
        label.textAlignment = .center
        status.addSubview(label)
        
        statusPosition = status.center
        
        delay(seconds: 1.0) {
            self.showMessage(index: 0)
        }
    }
    
    func showMessage(index: Int) {
        label.text = message[index]
        
        UIView.transition(with: status, duration: 0.33, options: [.curveEaseOut, .transitionCurlDown], animations: {
            self.status.isHidden = false
            }, completion: {_ in
                delay(seconds: 2.0) {
                    if index < self.message.count - 1 {
                        self.removeMessage(index: index)
                    } else {
                        
                    }
                }
        })
    }
    
    func removeMessage(index: Int) {
        UIView.animate(withDuration: 0.33, delay: 0.0, options: [], animations: {
            self.status.center.x += self.view.frame.width
            }, completion: {_ in
                self.status.isHidden = true;
                self.status.center = self.statusPosition
                
                self.showMessage(index: index + 1)
        })
    }
    
}
