//
//  SwiftViewController.swift
//  CodeSnippets
//
//  Created by UGOMEDIA on 16/5/11.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

import UIKit

enum Rank: Int {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

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
        
        print(greet("GeekRRK", day: "Sunday"))
        
        if let convertedRank = Rank(rawValue: 11) {
            let threeDescription = convertedRank.simpleDescription()
            print(threeDescription)
        }
    }
    
    func greet(name: String, day: String) -> String {
        return "Hello \(name), today is \(day)."
    }

}
