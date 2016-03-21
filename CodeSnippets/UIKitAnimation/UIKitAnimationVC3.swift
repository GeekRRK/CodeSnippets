//
//  ViewController3.swift
//  Animation
//
//  Created by Geek on 16-3-20.
//  Copyright (c) 2016年 GeekRRK. All rights reserved.
//

import UIKit

enum AnimationDirection: Int {
    case Positive = 1
    case Negative = -1
}

class UIKitAnimationVC3: UIViewController {
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.repeat1()
    }
    
    func cubeTransition(label label: UILabel, text: String, direction: AnimationDirection) {
        let anotherLabel = UILabel(frame: label.frame)
        anotherLabel.text = text
        anotherLabel.font = label.font
        anotherLabel.textAlignment = label.textAlignment
        anotherLabel.textColor = label.textColor
        
        let anotherLabelOffset = CGFloat(direction.rawValue) * label.frame.size.height / 2.0
        
        anotherLabel.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.0, 0.1), CGAffineTransformMakeTranslation(0.0, anotherLabelOffset))
        
        label.superview!.addSubview(anotherLabel)
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: {
            anotherLabel.transform = CGAffineTransformIdentity
            label.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.0, 0.1), CGAffineTransformMakeTranslation(0.0, -anotherLabelOffset))
            }, completion: {_ in
                label.text = anotherLabel.text
                label.transform = CGAffineTransformIdentity
                
                anotherLabel.removeFromSuperview()
        })
    }
    
    func fadeImageView(imageView: UIImageView, toImage: UIImage) {
        UIView.transitionWithView(imageView, duration: 1.0, options: .TransitionCrossDissolve, animations: {
            imageView.image = toImage
            }, completion: nil)
    }
    
    func repeat1() {
        delay(seconds: 1) {
            self.cubeTransition(label: self.label, text: "Sunny", direction: .Positive)
            self.fadeImageView(self.bgImg, toImage: UIImage(named: "bg-sunny")!)
            self.repeat2()
        }
    }
    
    func repeat2() {
        delay(seconds: 1) {
            self.fadeImageView(self.bgImg, toImage: UIImage(named: "bg-snowy")!)
            self.cubeTransition(label: self.label, text: "Snowy", direction: .Negative)
            self.repeat1()
        }
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
