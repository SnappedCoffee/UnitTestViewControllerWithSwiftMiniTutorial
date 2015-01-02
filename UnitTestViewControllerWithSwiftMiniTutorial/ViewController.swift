//
//  ViewController.swift
//  UnitTestViewControllerWithSwiftMiniTutorial
//
//  Created by SnappedCoffee on 02.01.15.
//  Copyright (c) 2015 SnappedCoffee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var myButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myLabel.text = "Hello World"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func myButtonPressed(sender: UIButton) {
        
        myLabel.text = "Button has been pressed"
        
    }
    


}

