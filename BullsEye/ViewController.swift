//
//  ViewController.swift
//  BullsEye
//
//  Created by Mercia Maguerroski on 01/08/19.
//  Copyright © 2019 Mércia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slider : UISlider! //it comes first
    @IBOutlet weak var showTargetNumber: UILabel!
    @IBOutlet weak var showScore: UILabel!
    @IBOutlet weak var showRound: UILabel!
    
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
        startNewGame()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
    }
    
    @IBAction func didTapButton() { //remember "did"
        
        let valueDifference = abs(targetValue - currentValue)
        var points = 100 - valueDifference
        score += points
        
        let title : String
        switch valueDifference {
        case 0:
            title = "Perfect!"
            points += 100
        case 1:
            title = "You almost had it!"
            points += 50
        case 1...5:
            title = "You almost had it!"
        case 5...10:
            title = "Pretty good!"
        default:
            title = "Not even close :s"
        }
        
        let message = "You scored \(points) points"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)

    }
    
    func startNewRound(){
        
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
        showRound.text = String(round)
        round += 1
        
    }
    
    func updateLabels(){
        showTargetNumber.text = String(targetValue)
        showScore.text = String(score)
    }
    
    @IBAction func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    
} // Attention to the spaces
