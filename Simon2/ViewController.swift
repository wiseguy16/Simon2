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
    var delay4Timer = 0.9 // time in seconds
    var speedMPHtimer: Timer!
    var keepPlaying = true
    var hasLostYet = false
    var theIndex = 0
    var simonIndex = -1

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
    
    
    @IBOutlet weak var lastGameLabel: UILabel!
    
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
        scoreLabel.text = "Score:"
        //simonMoves = []
        keepPlaying = true
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
            scoreLabel.text = "Score: \(simonMoves.count)"
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
            scoreLabel.text = "Score: \(simonMoves.count)"
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
            scoreLabel.text = "Score: \(simonMoves.count)"
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
            scoreLabel.text = "Score: \(simonMoves.count)"
            simonGoes()
            theIndex = 0
        }
         print("Player's Stuff")
        print(playerMoves)
       
    }
    
    func simonGoes()
    {
        if keepPlaying == true
        {
            
        let newInt =  arc4random_uniform(4) + 1
        var simonColor: WhichColor
        switch newInt
            {
        case 1:
            simonColor = .red
            simonMoves.append("\(simonColor)")
            simonButtonsArray.append(redButton)
        case 2:
            simonColor = .green
            simonMoves.append("\(simonColor)")
            simonButtonsArray.append(greenButton)
        case 3:
            simonColor = .blue
            simonMoves.append("\(simonColor)")
            simonButtonsArray.append(blueButton)
        case 4:
            simonColor = .yellow
            simonMoves.append("\(simonColor)")
            simonButtonsArray.append(yellowButton)
        default:
            print("no color")
            
            }
        
           speedMPHtimer = Timer.scheduledTimer(timeInterval: delay4Timer, target: self, selector: #selector(simonAnimates), userInfo: nil, repeats: true)
       
        print("Simon's stuff")
        print(simonMoves)
        
        clearPlayerArray()
        simonIndex = -1

        }
    }
    
    func simonAnimates()
    {
        simonIndex = simonIndex + 1
        if simonIndex < simonMoves.count
            {
                animateButtonPress(simonButtonsArray[simonIndex])
            }
        else
            {
                speedMPHtimer.invalidate()
            }
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
            lastGameLabel.text = "Last Game \(scoreLabel.text!)"
            playerMoves = []
            simonMoves = []
            simonButtonsArray = []
            
             theIndex = 0
             simonIndex = -1
            keepPlaying = false

            
            speedMPHtimer.invalidate()
            

            }
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

