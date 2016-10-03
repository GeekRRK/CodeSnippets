//
//  ViewController3.swift
//  Animation
//
//  Created by Geek on 16-3-20.
//  Copyright (c) 2016年 GeekRRK. All rights reserved.
//

import UIKit

enum AnimationDirection: Int {
    case positive = 1
    case negative = -1
}

class UIKitAnimationVC3: UIViewController {
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.repeat1()
    }
    
    func cubeTransition(label: UILabel, text: String, direction: AnimationDirection) {
        let anotherLabel = UILabel(frame: label.frame)
        anotherLabel.text = text
        anotherLabel.font = label.font
        anotherLabel.textAlignment = label.textAlignment
        anotherLabel.textColor = label.textColor
        
        let anotherLabelOffset = CGFloat(direction.rawValue) * label.frame.size.height / 2.0
        
        anotherLabel.transform = CGAffineTransform(scaleX: 1.0, y: 0.1).concatenating(CGAffineTransform(translationX: 0.0, y: anotherLabelOffset))
        
        label.superview!.addSubview(anotherLabel)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            anotherLabel.transform = CGAffineTransform.identity
            label.transform = CGAffineTransform(scaleX: 1.0, y: 0.1).concatenating(CGAffineTransform(translationX: 0.0, y: -anotherLabelOffset))
            }, completion: {_ in
                label.text = anotherLabel.text
                label.transform = CGAffineTransform.identity
                
                anotherLabel.removeFromSuperview()
        })
    }
    
    func fadeImageView(_ imageView: UIImageView, toImage: UIImage) {
        UIView.transition(with: imageView, duration: 1.0, options: .transitionCrossDissolve, animations: {
            imageView.image = toImage
            }, completion: nil)
    }
    
    func repeat1() {
        delay(seconds: 1) {
            self.cubeTransition(label: self.label, text: "Sunny", direction: .positive)
            self.fadeImageView(self.bgImg, toImage: UIImage(named: "bg-sunny")!)
            self.repeat2()
        }
    }
    
    func repeat2() {
        delay(seconds: 1) {
            self.fadeImageView(self.bgImg, toImage: UIImage(named: "bg-snowy")!)
            self.cubeTransition(label: self.label, text: "Snowy", direction: .negative)
            self.repeat1()
        }
    }

}
