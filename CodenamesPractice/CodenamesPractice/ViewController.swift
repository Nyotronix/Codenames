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
        for noun in nounLabels {
            tempNoun = nouns[Int(arc4random_uniform(UInt32(nouns.count)))]
            while usedNouns.contains(tempNoun) {
                tempNoun = nouns[Int(arc4random_uniform(UInt32(nouns.count)))]
            }
            noun.text = tempNoun
            usedNouns.append(tempNoun)
        }
        
        //Assing teams to each noun
        var tempInt: Int
        var nounColors = [UIColor?](repeatElement(nil, count: 25))
        var choosingColors = [UIColor](repeatElement(UIColor.blue, count: 8)) + [UIColor](repeatElement(UIColor.green, count: 8))
        choosingColors += [UIColor](repeatElement(UIColor.black, count: 8))
        choosingColors += [UIColor.red]
        for noun in 0...24 {
            tempInt = Int(arc4random_uniform(UInt32(choosingColors.count)))
            nounColors[noun] = choosingColors[tempInt]
            choosingColors.remove(at: tempInt)
            nounLabels[noun].textColor = nounColors[noun]
        }
    }
    
    //MARK: Actions

}
