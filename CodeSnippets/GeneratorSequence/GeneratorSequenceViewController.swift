//
//  GeneratorSequenceViewController.swift
//  CodeSnippets
//
//  Created by GeekRRK on 1/20/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

import UIKit

class GeneratorSequenceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let xs = ["A", "B", "C"]
//        let generator = CountdownGenerator(array: xs)
//        while let i = generator.next() {
//            print("Element \(i) of the array is \(xs[i])")
//        }
        
//        let xs = ["A", "B", "C"]
//        let reverseSequence = ReverseSequence(array: xs)
//        let reverseGenerator = reverseSequence.generate()
//        while let i = reverseGenerator.next() {
//            print("Index \(i) is \(xs[i])")
//        }
//
//        for i in (ReverseSequence(array: xs)) {
//            print("Index \(i) is \(xs[i])")
//        }
    }
}

protocol GeneratorType {
    typealias Element
    func next() -> Element?
}

class CountdownGenerator: GeneratorType {
    typealias Element = Int
    var element: Element
    
    init<T>(array: [T]) {
        self.element = array.count - 1
    }
    
    func next() -> Element? {
        return self.element < 0 ? nil : element--
    }
}

protocol SequenceType {
    typealias Generator: GeneratorType
    func generate() -> Generator
}

struct ReverseSequence<T>: SequenceType {
    var array: [T]
    init(array: [T]) {
        self.array = array
    }
    
    typealias Generator = CountdownGenerator
    
    func generate() -> Generator {
        return CountdownGenerator(array: array)
    }
}