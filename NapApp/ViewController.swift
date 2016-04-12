//
//  ViewController.swift
//  NapApp
//
//  Created by Parker Donat on 4/12/16.
//  Copyright © 2016 Parker Donat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addNSNotificationObserver()
        updateTimerLabel()
        setView()
    }
    
    func setView() {
        updateTimerLabel()
        // If timer is running, start button title should say "cancel". If timer is not running, title shouls say "Start Nap".
        if TimerController.sharedInstance.timer.isOn {
            startButton.setTitle("Cancel", forState: .Normal)
        } else {
            startButton.setTitle("Start Cat Nap", forState: .Normal)
        }
    }

    func addNSNotificationObserver() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.updateTimerLabel), name: "secondTick", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.presentTimerCompletedAlert), name: "timerCompleted", object: nil)
    }
        

    @IBAction func startNapButtonTapped(sender: AnyObject) {
        if TimerController.sharedInstance.timer.isOn {
            TimerController.sharedInstance.stopTimer()
        } else {
            TimerController.sharedInstance.startTimer()
        }
        setView()
    }
    
    func updateTimerLabel() {
        timerLabel.text = TimerController.sharedInstance.timeAsString()
    }
    
    func presentTimerCompletedAlert() {
        //var nameTextField: UITextField? = nil
        let alert = UIAlertController(title: "Alert!", message: "Wake up you sleepy head!", preferredStyle: .Alert)
        //alert.addTextFieldWithConfigurationHandler { (textField) in
       //     nameTextField = textField
       // }
        let action = UIAlertAction(title: "Dismiss", style: .Cancel) { (_) in
            self.setView()
           // print(nameTextField?.text)
        }
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
}

