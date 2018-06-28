//
//  ViewController.swift
//  CodenamesPractice
//
//  Created by Gus Petito on 6/27/18.
//  Copyright © 2018 GusPetito. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var outsideStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fm = FileManager()
        let path = Bundle.main.path(forResource: "nouns", ofType: "txt")!
        let content = fm.contents(atPath: path)
        var nouns: Array = String(data: content!, encoding: String.Encoding.utf8)!.components(separatedBy: ",")
        nouns = nouns[...(nouns.count - 2)] + ["worm"]
        
        for view in outsideStack.subviews {
            for case let subview as UILabel in view.subviews {
                subview.text = nouns[Int(arc4random_uniform(UInt32(nouns.count)))]
            }
        }
    }

}