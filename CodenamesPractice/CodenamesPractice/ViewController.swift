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
    @IBOutlet weak var turnIdentity: UILabel!
    @IBOutlet var nounButtons: [UIButton]!
    
    //MARK: Global Variables
    var turnInt: Int = 0
    var nounColors = [UIColor?](repeatElement(nil, count: 25))
    
    //MARK: Functions
    func assignColors(spymaster: Bool){
        //Assigns the colors if spymaster is true, takes away colors if false
        if spymaster{
            for noun in 0...24{
                if let color = nounColors[noun]{
                    nounButtons[noun].setTitleColor(color, for: .normal)
                }
            }
        } else {
            for noun in nounButtons{
                noun.setTitleColor(.black, for: .normal)
            }
        }
    }
    
    func changeTurn(){
        //Change the team, changing the colors of the words and the team identity label
        //Change the label
        turnInt = (turnInt + 1) % 4
        switch turnInt{
        case 0:
            turnIdentity.text = "Blue spymaster"
            assignColors(spymaster: true)
        case 1:
            turnIdentity.text = "Blue team members"
            assignColors(spymaster: false)
        case 2:
            turnIdentity.text = "Green spymaster"
            assignColors(spymaster: true)
        case 3:
            turnIdentity.text = "Green team members"
            assignColors(spymaster: false)
        default:
            turnIdentity.text = "Lol this shouldn't happen"
        }
        
    }
    
    
    
    
    
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
        for noun in nounButtons {
            tempNoun = nouns[Int(arc4random_uniform(UInt32(nouns.count)))]
            while usedNouns.contains(tempNoun) {
                tempNoun = nouns[Int(arc4random_uniform(UInt32(nouns.count)))]
            }
            noun.setTitle(tempNoun, for: .normal)
            usedNouns.append(tempNoun)
        }
        
        //Assing teams to each noun
        var tempInt: Int
        var choosingColors = [UIColor](repeatElement(UIColor.blue, count: 9)) + [UIColor](repeatElement(UIColor.green, count: 8))
        choosingColors += [UIColor](repeatElement(UIColor.black, count: 7))
        choosingColors += [UIColor.red]
        for noun in 0...24 {
            tempInt = Int(arc4random_uniform(UInt32(choosingColors.count)))
            nounColors[noun] = choosingColors[tempInt]
            choosingColors.remove(at: tempInt)
            nounButtons[noun].setTitleColor(nounColors[noun], for: .normal)
        }
    }
    
    //MARK: Actions
    @IBAction func EndTurnButton(_ sender: UIButton) {
        changeTurn()
    }
}
