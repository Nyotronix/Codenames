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
    //Connecting the outermost stack view to the view controller
    @IBOutlet weak var outsideStack: UIStackView!
    //Connecting the label with the player name to the view controller
    @IBOutlet weak var turnIdentity: UILabel!
    //Connecting all the noun buttons to the view controller in an outlet collection (an array of outlets)
    @IBOutlet var nounButtons: [UIButton]!
    
    //MARK: Global Variables
    //An integer that correlates with a player's turn
    var turnInt: Int = 0
    //An array with 25 nil's, eventually is going to be full of colors
    var nounColors = [UIColor?](repeatElement(nil, count: 25))
    
    //MARK: Functions
    func assignColors(spymaster: Bool){
        //Assigns the colors if spymaster is true, takes away colors if false
        if spymaster{
            for noun in 0...24{
                //If nounColors[noun] is not nil, set color to nounColors[noun]
                if let color = nounColors[noun]{
                    //Set the color of the button with the index noun to the color it correlates to in the nounColors array
                    nounButtons[noun].setTitleColor(color, for: .normal)
                }
            }
        } else {
            for noun in nounButtons{
                //Set the color of the button with the index noun the the color black
                noun.setTitleColor(.black, for: .normal)
            }
        }
    }
    
    func changeTurn(){
        //Change the team, changing the colors of the words and the team identity label
        //Change the label
        //Make sure turnInt is only 0, 1, 2, or 3
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
        //Initializing a file manager object
        let fm = FileManager()
        //Getting the path of the text file with the nouns
        let path = Bundle.main.path(forResource: "nouns", ofType: "txt")!
        //Getting the content of the text file
        let content = fm.contents(atPath: path)
        //Create an array that is the text file seperated by commas
        var nouns: Array = String(data: content!, encoding: String.Encoding.utf8)!.components(separatedBy: ",")
        //Fix the array by removing the last value and adding the last word again
        nouns = nouns[...(nouns.count - 2)] + ["worm"]
        var usedNouns = [String]()
        var tempNoun = ""
        
        //Assign random noun to each label
        //Loops through all the buttons
        for noun in nounButtons {
            //Pick a randon noun from the array of nouns just generated
            tempNoun = nouns[Int(arc4random_uniform(UInt32(nouns.count)))]
            //Only move on when the noun is not in the list already
            while usedNouns.contains(tempNoun) {
                tempNoun = nouns[Int(arc4random_uniform(UInt32(nouns.count)))]
            }
            //Set the button text to that noun
            noun.setTitle(tempNoun, for: .normal)
            usedNouns.append(tempNoun)
        }
        
        //Assing teams to each noun
        var tempInt: Int
        //Make an array of UIColors with 9 blue, 8 green, 7 black, and 1 red
        var choosingColors = [UIColor](repeatElement(UIColor.blue, count: 9)) + [UIColor](repeatElement(UIColor.green, count: 8))
        choosingColors += [UIColor](repeatElement(UIColor.black, count: 7))
        choosingColors += [UIColor.red]
        for noun in 0...24 {
            //Choose a random int within the index of the choosingColors
            tempInt = Int(arc4random_uniform(UInt32(choosingColors.count)))
            //Add that color to the array holding the colors in correct order of the grid
            nounColors[noun] = choosingColors[tempInt]
            //Remove that color from the array to keep perfect randomness
            choosingColors.remove(at: tempInt)
            //Set the button to the correct color
            nounButtons[noun].setTitleColor(nounColors[noun], for: .normal)
        }
    }
    
    //MARK: Actions
    @IBAction func EndTurnButton(_ sender: UIButton) {
        //Change the turn
        changeTurn()
    }
}
