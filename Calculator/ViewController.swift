//
//  ViewController.swift
//  Calculator
//
//  Created by Kevin Largo on 9/7/16.
//  Copyright © 2016 xkevlar. All rights reserved.
//

import UIKit

enum Operation {
  case none
  case division
  case multiplication
  case subtraction
  case addition
}

class ViewController: UIViewController {
  
  @IBOutlet weak var displayLabel: UILabel!
  
  var totalValue = CGFloat(0); //holds entire equation
  var displayValue = CGFloat(0); //value currently being displayed
  var secondTermValue = CGFloat(0); //holds values for current terms
  var currentOperation = Operation.none;
  var decimalPressed = false;
  var decimalPlace = CGFloat(1);
  var evaluated = false; //if current display is evaluated
  var beginNewTerm = false;


  @IBOutlet weak var allClearButton: UIButton!
  @IBOutlet weak var positiveNegativeButton: UIButton!
  @IBOutlet weak var percentageButton: UIButton!
  
  @IBOutlet var numberButtons: [UIButton]!
  @IBOutlet weak var decimalButton: UIButton!
  
  @IBOutlet weak var divideButton: UIButton!
  @IBOutlet weak var multiplyButton: UIButton!
  @IBOutlet weak var subtractButton: UIButton!
  @IBOutlet weak var addButton: UIButton!
  @IBOutlet weak var equalsButton: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func updateDisplay() {
    if(decimalPressed) { //display value as is
      displayLabel.text = String(displayValue);
    } else { //display value as integer (no decimal)
      displayLabel.text = String(Int(displayValue));
    }
  }
  
  func shiftDecimalPlace() {
    decimalPlace /= 10;
  }
  
  func processDigit(x: CGFloat) {
    if(displayValue * 10 > 999999999) { //if next inputted integer breaks max
      return; //don't process anymore digits
    }
    
    //if inputting term after operation button was tapped
    if(beginNewTerm) {
      displayValue = 0;
      beginNewTerm = false;
    }
    
    if(decimalPressed) {
      shiftDecimalPlace();
      displayValue += x * decimalPlace;
      
    } else {
      displayValue *= 10;
      displayValue += x;
    }
    
    secondTermValue = displayValue;
    
    updateDisplay();
  }
  
  @IBAction func zeroPressed(sender: AnyObject) {
    processDigit(0);
  }
  
  @IBAction func onePressed(sender: AnyObject) {
    processDigit(1);
 }
  
  @IBAction func twoPressed(sender: AnyObject) {
    processDigit(2);
 }
  
  @IBAction func threePressed(sender: AnyObject) {
    processDigit(3);
  }
  
  @IBAction func fourPressed(sender: AnyObject) {
    processDigit(4);
  }
  
  @IBAction func fivePressed(sender: AnyObject) {
    processDigit(5);
  }
  
  @IBAction func sixPressed(sender: AnyObject) {
    processDigit(6);
  }
  
  @IBAction func sevenPressed(sender: AnyObject) {
    processDigit(7);
  }
  
  @IBAction func eightPressed(sender: AnyObject) {
    processDigit(8);
  }
  
  @IBAction func ninePressed(sender: AnyObject) {
    processDigit(9);
  }
  
  
  @IBAction func decimalPressed(sender: AnyObject) {
    //decimal button can only be pressed once per term
    if(decimalPressed) {
      return;
    }
    
    if(beginNewTerm) {
      displayValue = 0;
      updateDisplay();
      beginNewTerm = false;
    }
    
    decimalPressed = true;
    displayLabel.text! += ".";
  }

  @IBAction func allClearPressed(sender: AnyObject) {
    currentOperation = Operation.none;
    displayValue = 0;
    secondTermValue = 0;
    decimalPressed = false;
    decimalPlace = 1;
    updateDisplay();
  }
  
  func resetForNewTerm() {
    displayValue = 0; //value itself is reset, not on screen label text
//    secondTermValue = 0;
    decimalPressed = false;
    decimalPlace = 1;
    beginNewTerm = true;
  }
  
  var lastPressed = Operation.none;
  
  func setOperation(op: Operation) {
    
    currentOperation = op;
    totalValue = displayValue; //whatever is displayed is new total

    resetForNewTerm(); //reset for next input
  }
  
  @IBAction func divisionPressed(sender: AnyObject) {
    setOperation(Operation.division);
  }
  
  @IBAction func multiplicationPressed(sender: AnyObject) {
    setOperation(Operation.multiplication);
  }
  
  @IBAction func subtractionPressed(sender: AnyObject) {
    setOperation(Operation.subtraction);
  }
  
  @IBAction func additionPressed(sender: AnyObject) {
    setOperation(Operation.addition);
  }
  
  @IBAction func evaluatePressed(sender: AnyObject) {
    evaluate();
  }
  
  func evaluate() {
    switch (currentOperation) {
    case Operation.division:
      totalValue /= secondTermValue;
      break;
      
    case Operation.multiplication:
      totalValue *= secondTermValue;
      break;
      
    case Operation.subtraction:
      totalValue -= secondTermValue;
      break;
      
    case Operation.addition:
      totalValue += secondTermValue;
      break;
      
    default:
      return;
    }
    
    displayValue = totalValue;
    updateDisplay();
    
    currentOperation = Operation.none;
    evaluated = true;
  }
}