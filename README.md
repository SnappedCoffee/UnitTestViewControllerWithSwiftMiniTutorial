Unit Test your ViewController - Mini Tutorial
===============================================
##Goal & Attribution
This is a short tutorial to get you started testing your View Controller with Swift.  It is not a complex and full tutorial about how to do unit testing with Swift. In fact, is just preventing you from having to struggle with the same issues I had.

The core solution is from Mike Cole (see http://www.iosmike.com/2014/08/unit-testing-viewcontrollers-in-swift.html). However, his solution did not work for me at first. That’s why I want to share the additional steps it took me to get this to work.

##Disclaimer
Please be aware that I am quite new to iOS development and unit testing. So do not expect great expertise, code quality and support. If you now it better please let me know how.

I noticed that with every release of XCode 6 and Swift things slightly change. Therefore, this tutorial might not work with your settings and version of XCode. I used XCode 6.1.1 (6A2008a).

To sum up, use this tutorial at your own risk.

##Why testing?
Before I start explaining, a few thoughts on why you should write unit tests:

- You should find the bugs in your app and not the users
- If your app can generate many different outputs on the same input / trigger, have may ways of behavior or uses randomly generated output it is quite tedious to test all possible variants manual. Writing automated tests makes live easier. Although writing tests takes time, it will pay out in the long term.
- You get early feedback testing small functions separately gives confidence
It can even be fun to think about the expected result first, writing a test and than try to implement the correct functionality -> see also: [Test Driven Developement (TDD)](http://en.wikipedia.org/wiki/Test-driven_development)
- Changing the application is much safer, because you know that the application breaks because of a change if a test fails. - Furthermore, the failed test is a great lead to debug.

##Unit Testing Basics
This tutorial is not about the very basics of unit testing and I don't want to re-invent the wheel. Therefore, read the following articles, if you are not familiar with the basics of unit testing with XCode:

- http://www.swiftcast.tv/articles/introduction-to-xctest6
- http://meandmark.com/blog/2014/07/an-introduction-to-swift-unit-testing/4

The first article provides you with the very basics and more important shows you two very important aspects to be able to run the tests:

1. Import the project module in the class.
2. Add the classes to the Test Target

The second article provides you basic information about how to write tests and which are the most important Asserts.

## Testing a ViewController - The Tutorial
No finally let’s get started with the tutorial. If you download the source code all the steps below have already been done. I encourage you to do the whole thing on your own to get familiar with the steps. Feel free to implement a different application and different unit tests. The core idea is to test code in the ViewController.swift.

### Step 1 - Download the Project / Create the Application
Either download the source code of this project or create you own iOS project. To be able to easily follow the tutorial, I suggest you start with my source code and later apply and adapt the following steps to your code.

After creating the project setup the storyboard, insert the Outlets and IBActions to the ViewController.swift and implement the business logic in the view controller. As you can see in my source code I created a simple label and button. The business logic is only changing the label’s text when the user clicks the button. In the following steps we want to test the function myButtonPressed(sender_ UIButton).
```
@IBAction func myButtonPressed(sender: UIButton) {

     myLabel.text = "Button has been pressed"

}
```

### Step 2 - Import the project module
Open UnitTestViewControllerWithSwiftMiniTutorialTests.swift. UnitTestViewControllerWithSwiftMiniTutorial is the name of the project. If you created your own project the name might be different. Import the project module:

```
import UIKit
import XCTest

//  Important: Import the project module
import UnitTestViewControllerWithSwiftMiniTutorial

class UnitTestViewControllerWithSwiftMiniTutorialTests: XCTestCase {
     // test functions come here (later steps)
}
```
### Step 3 - Add the classes to the Test Target
Add ViewController.swift and Main.storyboard to the Test Target. You find this setting in the right inspector after opening the file.

![TestTarget setting in the right inspector](https://github.com/SnappedCoffee/UnitTestViewControllerWithSwiftMiniTutorial/blob/master/screenshots/Screenshot_AddToTestTarget.png)

### Step 4 - Add a Storyboard ID
This is a very important step. 

1. Open Main.storyboard
2. Select the View Controller (see first screenshot below)
3. Open the identity inspector in the right inspector (see second screenshot below)
4. Add the Storyboard ID „MyStoryboard"

![Select the View Controller](https://github.com/SnappedCoffee/UnitTestViewControllerWithSwiftMiniTutorial/blob/master/screenshots/Screenshot_StoryboardID1.png)

![Open the identity inspector in the right inspector](https://github.com/SnappedCoffee/UnitTestViewControllerWithSwiftMiniTutorial/blob/master/screenshots/Screenshot_StoryboardID2.png)

### Step 5 - Implement setUp()
To be able to test code in our ViewController we need to create a ViewController instance and a storyboard in our test class UnitTestViewControllerWithSwiftMiniTutorialTests.swift. The ViewController variable has to be placed outside of the setUp() function so that it is available to the test functions. The creation of the storyboard etc. has to be placed inside of the setUp() function.

```
class UnitTestViewControllerWithSwiftMiniTutorialTests: XCTestCase {
     var vc:ViewController = ViewController()

     override func setUp() {
          super.setUp()

          var storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType))     
          vc = storyboard.instantiateViewControllerWithIdentifier("MyStoryboard") as ViewController
          vc.loadView()
          vc.viewDidLoad()

     }
     // test functions come here (next step)
}
```
This is the part I got from Mike Cole, but I had to adapt it to my situation.

### Step 6 - Implement the Unit Tests
Now we can start testing. Here are some examples:

```
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
```

To run the tests hit CMD + U. 
