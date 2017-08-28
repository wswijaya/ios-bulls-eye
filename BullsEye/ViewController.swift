//
//  ViewController.swift
//  BullsEye
//
//  Created by Wongso on 27/8/17.
//  Copyright © 2017 wswijaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func showAlert(_ sender: Any) {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        let title: String
        
        if (difference == 0) {
            title = "Perfect!"
            points += 100
        } else if (difference < 5) {
            title = "You almost had it!"
            if (difference == 1) {
                points += 50
            }
        } else if (difference < 10) {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        
        let message = "The value of the slider is: \(currentValue) \n The target value is \(targetValue)\n You scored \(points) points."
        
        score += points
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //        let actionItem = UIAlertAction(title: "OK", style: UIAlertActionStyle, handler: ((UIAlertAction) -> void)?)
        let actionItem = UIAlertAction(title: "OK", style: .default) { [weak self]
            action in
            self?.startNewRound()
            self?.updateLabels()
        }
        alertController.addAction(actionItem)
        present(alertController, animated: true, completion: nil)
        
        //view.backgroundColor = .white
        //startNewRound()
        //updateLabels()
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        currentValue = lroundf(sender.value)
        //showAlert(sender)
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    @IBAction func startOver(_ sender: Any) {
        startNewGame()
        updateLabels()
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    func startNewRound() {
        round += 1
        currentValue = 50
        targetValue = Int(arc4random_uniform(100)) + 1
        slider.value = Float(currentValue)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print("Rotated!")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        startNewRound()
        updateLabels()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)

        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

