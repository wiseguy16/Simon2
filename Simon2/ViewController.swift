//
//  ViewController.swift
//  Simon2
//
//  Created by Gregory Weiss on 8/20/16.
//  Copyright © 2016 Gregory Weiss. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController
{
    var audioPlayer:AVAudioPlayer!
    var delay4Timer = 0.75 // time in seconds
    var speedMPHtimer: Timer!
    var keepPlaying = true
    var hasLostYet = false
    var theIndex = 0

    var isSimonsTurn = false
    var isPlayerTurn = false
    
    enum WhichColor: Int
    {
        case red = 1
        case green
        case blue
        case yellow
        
    }
    
    var playerMoves = [String]()
    var simonMoves = [String]()
    var simonButtonsArray = [UIButton]()
    
    
    
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    
    @IBOutlet weak var gameStatusLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        gameStatusLabel.text = "Let's Play Simon!"
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   

    @IBAction func startGameTapped(_ sender: UIButton)
    {
     
        simonGoes()
    }
    
    @IBAction func yellowTapped(_ sender: UIButton)
    {
        animateButtonPress(sender)
        playerMoves.append("yellow")
        checkForLoser()
        theIndex = theIndex + 1
        if playerMoves.count == simonMoves.count
        {
            simonGoes()
            theIndex = 0
        }
         print("Player's Stuff")
        print(playerMoves)
    }

    @IBAction func blueTapped(_ sender: UIButton)
    {
        animateButtonPress(sender)
        playerMoves.append("blue")
        checkForLoser()
        theIndex = theIndex + 1
        if playerMoves.count >= simonMoves.count
        {
            simonGoes()
            theIndex = 0
        }
        print("Player's Stuff")
        print(playerMoves)
    }
    
    @IBAction func redTapped(_ sender: UIButton)
    {
        animateButtonPress(sender)
        playerMoves.append("red")
        checkForLoser()
        theIndex = theIndex + 1
        if playerMoves.count == simonMoves.count
        {
            simonGoes()
            theIndex = 0
        }
         print("Player's Stuff")
        print(playerMoves)
       
    }

    
    @IBAction func greenTapped(_ sender: UIButton)
    {
        animateButtonPress(sender)
        playerMoves.append("green")
        checkForLoser()
        theIndex = theIndex + 1
        if playerMoves.count == simonMoves.count
        {
            simonGoes()
            theIndex = 0
        }
         print("Player's Stuff")
        print(playerMoves)
       
    }
    
    func simonGoes()
    {
        let newInt =  arc4random_uniform(4) + 1
        var simonColor: WhichColor
        switch newInt {
        case 1:
            simonColor = .red
            // print("simon's Moves: ")
            // print("\(simonColor)")
            simonMoves.append("\(simonColor)")
            simonButtonsArray.append(redButton)
          //  animateButtonPress(redButton)
        case 2:
            simonColor = .green
            // print("\(simonColor)")
          //  animateButtonPress(greenButton)
            simonMoves.append("\(simonColor)")
            simonButtonsArray.append(greenButton)
        case 3:
            simonColor = .blue
            // print("\(simonColor)")
            simonMoves.append("\(simonColor)")
            simonButtonsArray.append(blueButton)
          //  animateButtonPress(blueButton)
        case 4:
            simonColor = .yellow
            //  print("\(simonColor)")
            simonMoves.append("\(simonColor)")
            simonButtonsArray.append(yellowButton)
            //animateButtonPress(yellowButton)
        default:
            print("no color")
            
        }
        
        for a in 0..<simonButtonsArray.count
        {
            animateButtonPress(simonButtonsArray[a])
        }
        print("Simon's stuff")
        print(simonMoves)
        
        clearPlayerArray()

        
    }
    
    func clearPlayerArray()
    {
        playerMoves = []
    }
    
    func checkForLoser()
        {
        if playerMoves[theIndex] == simonMoves[theIndex]
        {
             print("so far so good")
            }
            else
        {
            let audioFilePath = Bundle.main.path(forResource: "loserSound", ofType: "mp3")
            if audioFilePath != nil {
                let audioFileUrl = NSURL.fileURL(withPath: audioFilePath!)
                do {
                    audioPlayer =  try AVAudioPlayer(contentsOf: audioFileUrl)
                } catch let error1 as NSError {
                    print(error1)
                }
            }
            audioPlayer.play()

            }
        }
    
    func whichButtonWasPressed()
    {
     //   if button == square1
     //   {
            //  playSound(soundName: "tone1")
     //       playerMoves.append(button.colorString)
            
      //  }
     //   else if button == square2
     //   {
            //   playSound(soundName: "tone2")
      //      playerMoves.append(button.colorString)
      //  }
     //   else if button == square3
     //   {
            //  playSound(soundName: "tone3")
      //      playerMoves.append(button.colorString)
       // }
      //  else if button == square4
      //  {
            //  playSound(soundName: "tone4")
      //      playerMoves.append(button.colorString)
      //  }

    }

    
    func animateButtonPress(_ button: UIButton)
    {
        let tempColor = button.backgroundColor
        
        let audioName = button.title(for: .normal)!
        
        let audioFilePath = Bundle.main.path(forResource: audioName, ofType: "mp3")
        if audioFilePath != nil {
            let audioFileUrl = NSURL.fileURL(withPath: audioFilePath!)
            do {
                audioPlayer =  try AVAudioPlayer(contentsOf: audioFileUrl)
            } catch let error1 as NSError {
                print(error1)
            }
        }
        audioPlayer.play()
        button.backgroundColor = UIColor.white
        UIView.animate(withDuration: 0.3) {
            button.backgroundColor = tempColor!
        }
        
        
    }
    
    




}

