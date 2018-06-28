//
//  ViewController.swift
//  CodenamesPractice
//
//  Created by Gus Petito on 6/27/18.
//  Copyright © 2018 GusPetito. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var outsideStack: UIStackView!
    @IBOutlet var nounLabels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting up variables for random nouns
        let fm = FileManager()
        let path = Bundle.main.path(forResource: "nouns", ofType: "txt")!
        let content = fm.contents(atPath: path)
        var nouns: Array = String(data: content!, encoding: String.Encoding.utf8)!.components(separatedBy: ",")
        nouns = nouns[...(nouns.count - 2)] + ["worm"]
        var usedNouns = [String]()
        var tempNoun = ""
        
        //Assign random noun to each label
        for view in outsideStack.subviews {
            for case let subview as UILabel in view.subviews {
                tempNoun = nouns[Int(arc4random_uniform(UInt32(nouns.count)))]
                while usedNouns.contains(tempNoun) {
                    tempNoun = nouns[Int(arc4random_uniform(UInt32(nouns.count)))]
                }
                subview.text = tempNoun
                usedNouns.append(tempNoun)
            }
        }
    }
    
    //MARK: Actions

}
