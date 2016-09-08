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
  var displayValue = CGFloat(0); //holds values for current terms

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
  
  var currentOperation = Operation.none;
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func updateDisplay() {
    displayLabel.text = String(displayValue);
  }
  
  @IBAction func zeroPressed(sender: AnyObject) {
    displayValue *= 10;
    displayValue += 0;
    updateDisplay();
  }
  
  @IBAction func onePressed(sender: AnyObject) {
    displayValue *= 10;
    displayValue += 1;
    updateDisplay();
  }
  
  @IBAction func twoPressed(sender: AnyObject) {
    displayValue *= 10;
    displayValue += 2;
    updateDisplay();
  }
  
  @IBAction func threePressed(sender: AnyObject) {
    displayValue *= 10;
    displayValue += 3;
    updateDisplay();
  }
  
  @IBAction func fourPressed(sender: AnyObject) {
    displayValue *= 10;
    displayValue += 4;
    updateDisplay();
  }
  
  @IBAction func fivePressed(sender: AnyObject) {
    displayValue *= 10;
    displayValue += 5;
    updateDisplay();
  }
  
  @IBAction func sixPressed(sender: AnyObject) {
    displayValue *= 10;
    displayValue += 6;
    updateDisplay();
  }
  
  @IBAction func sevenPressed(sender: AnyObject) {
    displayValue *= 10;
    displayValue += 7;
    updateDisplay();
  }
  
  @IBAction func eightPressed(sender: AnyObject) {
    displayValue *= 10;
    displayValue += 8;
    updateDisplay();
  }
  
  @IBAction func ninePressed(sender: AnyObject) {
    displayValue *= 10;
    displayValue += 9;
    updateDisplay();
  }
  

  @IBAction func allClearPressed(sender: AnyObject) {
    displayValue = 0;
    currentOperation = Operation.none;
    updateDisplay();
  }
  
  
  @IBAction func divisionPressed(sender: AnyObject) {
    currentOperation = Operation.division;
    totalValue = displayValue;
    displayValue = 0;
  }
  
  @IBAction func multiplicationPressed(sender: AnyObject) {
    currentOperation = Operation.multiplication;
    totalValue = displayValue;
    displayValue = 0;
  }
  
  @IBAction func subtractionPressed(sender: AnyObject) {
    currentOperation = Operation.subtraction;
    totalValue = displayValue;
    displayValue = 0;
  }
  
  @IBAction func additionPressed(sender: AnyObject) {
    currentOperation = Operation.addition;
    totalValue = displayValue;
    displayValue = 0;
  }
  
  @IBAction func evaluatePressed(sender: AnyObject) {
    switch (currentOperation) {
    case Operation.division:
      totalValue /= displayValue;
      break;
      
    case Operation.multiplication:
      totalValue *= displayValue;
      break;
      
    case Operation.subtraction:
      totalValue -= displayValue;
      break;
      
    case Operation.addition:
      totalValue += displayValue;
      break;
      
    default:
      return;
    }
    
    displayValue = totalValue;
    updateDisplay();
    
  }
  
}