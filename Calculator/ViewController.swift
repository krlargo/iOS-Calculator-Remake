//
//  ViewController.swift
//  Calculator
//
//  Created by Kevin Largo on 9/7/16.
//  Copyright © 2016 xkevlar. All rights reserved.
//

import UIKit

enum Operator {
  case division
  case multiplication
  case subtraction
  case addition
  case none
}

class ViewController: UIViewController {
  
  var calculator = CalculatorModel();
  
  @IBOutlet weak var displayLabel: UILabel!
  
  @IBOutlet var allButtons: [UIButton]!
  @IBOutlet var operatorButtons: [UIButton]!
  @IBOutlet weak var zeroButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    //add borders
    for i in 0 ..< allButtons.count {
      allButtons[i].layer.borderWidth = 0.25;
    }
    
    zeroButton.titleLabel?.textAlignment = NSTextAlignment.Left;
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  func updateDisplay() {

    if(!calculator.inputHasDecimal()) { //if is an integer
      displayLabel.text = String(Int(calculator.displayValue));
    } else { //not an integer
      displayLabel.text = String(calculator.displayValue); //direct float to string conversion
    }
    
    //append negative sign
    if(calculator.displayValueIsNegative) {
      displayLabel.text = "-" + displayLabel.text!;
    }
  }
  
  @IBAction func zeroPressed(sender: AnyObject) {
    calculator.processDigit(0);
    updateDisplay();
  }
  
  @IBAction func onePressed(sender: AnyObject) {
    calculator.processDigit(1);
    updateDisplay();
 }
  
  @IBAction func twoPressed(sender: AnyObject) {
    calculator.processDigit(2);
    updateDisplay();
 }
  
  @IBAction func threePressed(sender: AnyObject) {
    calculator.processDigit(3);
    updateDisplay();
  }
  
  @IBAction func fourPressed(sender: AnyObject) {
    calculator.processDigit(4);
    updateDisplay();
  }
  
  @IBAction func fivePressed(sender: AnyObject) {
    calculator.processDigit(5);
    updateDisplay();
  }
  
  @IBAction func sixPressed(sender: AnyObject) {
    calculator.processDigit(6);
    updateDisplay();
  }
  
  @IBAction func sevenPressed(sender: AnyObject) {
    calculator.processDigit(7);
    updateDisplay();
  }
  
  @IBAction func eightPressed(sender: AnyObject) {
    calculator.processDigit(8);
    updateDisplay();
  }
  
  @IBAction func ninePressed(sender: AnyObject) {
    calculator.processDigit(9);
    updateDisplay();
  }
  
  @IBAction func decimalPressed(sender: AnyObject) {
    //decimal button can only be pressed once per term
    if(calculator.decimalPressed) {
      return;
    }
    
    if(calculator.beginNewTerm) {
      calculator.displayValue = 0;
      updateDisplay();
      calculator.beginNewTerm = false;
    }
    
    calculator.decimalPressed = true;
    displayLabel.text! += ".";
  }

  @IBAction func allClearPressed(sender: AnyObject) {
    calculator.currentOperator = Operator.none;
    calculator.totalValue = 0; //holds entire equation
    calculator.totalValueSet = false;
    
    calculator.resetForNewTerm();
    
    updateDisplay();
  }
  
  @IBAction func positiveNegativePressed(sender: AnyObject) {
    calculator.displayValueIsNegative = (calculator.displayValueIsNegative) ? false : true;
    updateDisplay();
  }

  
  @IBAction func percentagePressed(sender: AnyObject) {
    calculator.displayValue /= 100;
    updateDisplay();
  }
  
  //called when an operator button is tapped

  
  @IBAction func divisionPressed(sender: AnyObject) {
    calculator.setOperator(Operator.division);
    highlightButton(operatorButtons[0]);
  }
  
  @IBAction func multiplicationPressed(sender: AnyObject) {
    calculator.setOperator(Operator.multiplication);
    highlightButton(operatorButtons[1]);
  }
  
  @IBAction func subtractionPressed(sender: AnyObject) {
    calculator.setOperator(Operator.subtraction);
    highlightButton(operatorButtons[2]);
  }
  
  @IBAction func additionPressed(sender: AnyObject) {
    calculator.setOperator(Operator.addition);
    highlightButton(operatorButtons[3]);
  }
  
  @IBAction func evaluatePressed(sender: AnyObject) {
    calculator.evaluate();
    updateDisplay();
  }

  
  //Operator Button Highlighting Functions
  func highlightButton(button: UIButton?) {
    unhighlightAllButtons();
    
    if (button != nil) {
      button?.layer.borderWidth = 2;
    }
  }
  
  @IBAction func nonOperatorPressed(sender: AnyObject) {
    unhighlightAllButtons();
  }
  
  func unhighlightAllButtons() {
    for i in 0 ..< operatorButtons.count {
      operatorButtons[i].layer.borderWidth = 0.25;
    }
  }
}