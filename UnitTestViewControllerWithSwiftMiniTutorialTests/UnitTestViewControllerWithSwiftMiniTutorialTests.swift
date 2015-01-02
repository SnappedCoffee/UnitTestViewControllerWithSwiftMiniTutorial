//
//  UnitTestViewControllerWithSwiftMiniTutorialTests.swift
//  UnitTestViewControllerWithSwiftMiniTutorialTests
//
//  Created by SnappedCoffee on 02.01.15.
//  Copyright (c) 2015 SnappedCoffee. All rights reserved.
//

import UIKit
import XCTest

//  Important: Import the project module
import UnitTestViewControllerWithSwiftMiniTutorial

class UnitTestViewControllerWithSwiftMiniTutorialTests: XCTestCase {
    
    // Important: create a variable for the view controller outside of setup(). Otherwise the variable is not available to the test functions
    var vc:ViewController = ViewController()
    
    override func setUp() {
        super.setUp()
        
        /* Set up the storyboard with the view controller.
        Source: http://www.iosmike.com/2014/08/unit-testing-viewcontrollers-in-swift.html
        Important: set the Storyboard ID to the same value as in instantiateViewControllerWithIdentifier() (e.g. MyStoryboard). Here is how: open the storyboard, select the view controller in the storyboard, select the identity inspector tab in the right inspector and finally set the Storyboard ID property in the right inspector)
        */
        
        var storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType))
        vc = storyboard.instantiateViewControllerWithIdentifier("MyStoryboard") as ViewController
        vc.loadView()
        vc.viewDidLoad()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testViewDidLoad() {
        // assert that the ViewController.view is not nil
        XCTAssertNotNil(vc.view, "View Did Not load")
    }
    
    func testMyLabelTextDidLoad() {
        // assert that myLabel was set to "Hello World" when viewDidLoad
        XCTAssertTrue(vc.myLabel.text == "Hello World", "myLabel is not set to 'Hello World', but to \(vc.myLabel.text)")
    }
    
    func testMyButtonPressedChangesMyLabel() {
        // assert that myLabel is set to "Button has been pressed", when myButton has been pressed
        vc.myButtonPressed(vc.myButton)
        XCTAssertTrue(vc.myLabel.text == "Button has been pressed", "myLabel is not set to 'Button has been pressed', but to \(vc.myLabel.text)")
    }
    
}
