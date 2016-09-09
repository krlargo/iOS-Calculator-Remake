//
//  ViewController.swift
//  Calculator
//
//  Created by Kevin Largo on 9/7/16.
//  Copyright © 2016 xkevlar. All rights reserved.
//

import UIKit

enum Operator {
  case none
  case division
  case multiplication
  case subtraction
  case addition
}

class ViewController: UIViewController {
  
  @IBOutlet weak var displayLabel: UILabel!
  
  var currentOperator = Operator.none;
  var totalValue = CGFloat(0); //holds long running result
  var displayValue = CGFloat(0); //value currently being displayed
  var decimalPlace = CGFloat(1); //the decimal location where the next decimal should be placed
  var decimalPressed = false;
  var beginNewTerm = false;
  var totalValueSet = false;
  var displayValueIsNegative = false;

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
  
  @IBOutlet var allButtons: [UIButton]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    //add borders
    for i in 0 ..< allButtons.count {
      allButtons[i].layer.borderWidth = 0.25;
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  func updateDisplay() {

    //add to account for scientific notation & correct number of digits
    if(!inputHasDecimal()) { //if is an integer
      displayLabel.text = String(Int(displayValue));
    } else { //not an integer
      displayLabel.text = String(displayValue); //direct float to string conversion
    }
    
    //append negative sign
    if(displayValueIsNegative) {
      displayLabel.text = "-" + displayLabel.text!;
    }
  }
  
  func shiftDecimalPlace() {
    decimalPlace /= 10;
  }
  
  func processDigit(x: CGFloat) {
    
    //don't process any numbers greater than 9 digits
    if((inputHasDecimal() && String(displayValue).characters.count > 9) || //no decimal && more than 9 chars
       (!inputHasDecimal() && String(displayValue).characters.count > 10)) { //decimal && more than 10 chars
        return;
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
    
    updateDisplay();
  }
  
  func inputHasDecimal() -> Bool {
    return ceil(displayValue) != displayValue;
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
    currentOperator = Operator.none;
    totalValue = CGFloat(0); //holds entire equation
    totalValueSet = false;
    
    resetForNewTerm();
    
    updateDisplay();
  }
  
  //called before we enter a new term after an operator is tapped;
  // resets everything except for operator and total values
  func resetForNewTerm() {
    displayValue = CGFloat(0); //value currently being displayed
    decimalPlace = CGFloat(1);
    decimalPressed = false;
    beginNewTerm = true;
    displayValueIsNegative = false;
  }
  
  @IBAction func positiveNegativePressed(sender: AnyObject) {
    displayValueIsNegative = (displayValueIsNegative) ? false : true;
    updateDisplay();
  }

  
  @IBAction func percentagePressed(sender: AnyObject) {
    displayValue /= 100;
    updateDisplay();
  }
  
  //called when an operator button is tapped
  func setOperator(op: Operator) {
    
    currentOperator = op;
    
    //the first time any operator is tapped, save current value as total value
    if(!totalValueSet) {
      
      //check if first term is negative
      if(displayValueIsNegative) {
        displayValue *= -1;
      }
      
      totalValue = displayValue; //whatever is displayed is new total
      totalValueSet = true;
    }
    
    resetForNewTerm();
  }
  
  @IBAction func divisionPressed(sender: AnyObject) {
    setOperator(Operator.division);
  }
  
  @IBAction func multiplicationPressed(sender: AnyObject) {
    setOperator(Operator.multiplication);
  }
  
  @IBAction func subtractionPressed(sender: AnyObject) {
    setOperator(Operator.subtraction);
  }
  
  @IBAction func additionPressed(sender: AnyObject) {
    setOperator(Operator.addition);
  }
  
  @IBAction func evaluatePressed(sender: AnyObject) {
    evaluate();
  }
  
  func evaluate() {
    
    //check if second term is negative
    if(displayValueIsNegative) {
      displayValue *= -1;
      displayValueIsNegative = false; //reset
    }
    
    switch (currentOperator) {
    case Operator.division:
      totalValue /= displayValue;
      break;
      
    case Operator.multiplication:
      totalValue *= displayValue;
      break;
      
    case Operator.subtraction:
      totalValue -= displayValue;
      break;
      
    case Operator.addition:
      totalValue += displayValue;
      break;
      
    default:
      return;
    }
    
    //store and display evaluated value
    displayValue = totalValue;
    updateDisplay();
    
    currentOperator = Operator.none;
  }
}