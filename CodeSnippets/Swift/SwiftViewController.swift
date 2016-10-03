//
//  SwiftViewController.swift
//  CodeSnippets
//
//  Created by GeekRRK on 16/5/11.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

import UIKit

enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
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
    
    func greet(_ name: String, day: String) -> String {
        return "Hello \(name), today is \(day)."
    }

}
