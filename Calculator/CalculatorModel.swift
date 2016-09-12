//
//  CalculatorModel.swift
//  Calculator
//
//  Created by Kevin Largo on 9/11/16.
//  Copyright © 2016 xkevlar. All rights reserved.
//

import Foundation

class CalculatorModel {
  var currentOperator : Operator;
  var totalValue : Float; //holds long running result
  var displayValue : Float; //value currently being displayed
  var decimalPlace : Float; //the decimal location where the next decimal should be placed
  
  var decimalPressed : Bool;
  var beginNewTerm : Bool;
  var totalValueSet : Bool;
  var displayValueIsNegative : Bool;

  init() {
    currentOperator = Operator.none;
    totalValue = 0;
    displayValue = 0;
    decimalPlace = 1;
    
    decimalPressed = false;
    beginNewTerm = false;
    totalValueSet = false;
    displayValueIsNegative = false;
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
    
    currentOperator = Operator.none;
  }
  
  func inputHasDecimal() -> Bool {
    return ceil(displayValue) != displayValue;
  }
  
  func processDigit(x: Float) {
    
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
  }
  
  //called before we enter a new term after an operator is tapped;
  // resets everything except for operator and total values
  func resetForNewTerm() {
    displayValue = Float(0); //value currently being displayed
    decimalPlace = Float(1);
    decimalPressed = false;
    beginNewTerm = true;
    displayValueIsNegative = false;
  }
  
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
  
  func shiftDecimalPlace() {
    decimalPlace /= 10;
  }
}