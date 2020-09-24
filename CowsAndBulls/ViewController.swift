//
//  ViewController.swift
//  CowsAndBulls
//
//  Created by Anton on 2020-09-22.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    @IBOutlet var num1CheckBox: NSButton!
    @IBOutlet var num2CheckBox: NSButton!
    @IBOutlet var num3CheckBox: NSButton!
    @IBOutlet var num4CheckBox: NSButton!
    @IBOutlet var num5CheckBox: NSButton!
    @IBOutlet var num6CheckBox: NSButton!
    @IBOutlet var num7CheckBox: NSButton!
    @IBOutlet var num8CheckBox: NSButton!
    @IBOutlet var num9CheckBox: NSButton!
    @IBOutlet var num0CheckBox: NSButton!
    
    @IBOutlet var tableView: NSTableView!
    @IBOutlet var guess: NSTextField!
    
    
    @IBOutlet var digit1Btn: NSButton!
    @IBOutlet var digit2Btn: NSButton!
    @IBOutlet var digit3Btn: NSButton!
    @IBOutlet var digit4Btn: NSButton!
    
    @IBOutlet var digit1Stepper: NSStepper!
    @IBOutlet var digit2Stepper: NSStepper!
    @IBOutlet var digit3Stepper: NSStepper!
    @IBOutlet var digit4Stepper: NSStepper!
    
    //    Correct answer
    var answer = ""
    
    //    Array to store player's guesses
    var guesses = [String]()
    
    //    Array for check-box numbers
    var checkBoxNumbers = Array(0...9)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    @IBAction func menuNewGame (_ sender: Any) {
        startNewGame()
    }
    
    @IBAction func digitButtonsClicked(_ sender: NSButton){
        let stepper = currentStepperIs(for: sender)
        if sender.state == NSControl.StateValue.on {
            stepper.isEnabled = true
        } else {
            stepper.isEnabled = false
        }
    }
    
    @IBAction func digitSteppersClicked(_ sender: NSStepper) {
        let button = currentButtonIs(for: sender)
        button.title = String(checkBoxNumbers[Int(sender.intValue)])
    }
    
    func currentStepperIs(for sender: NSControl) -> NSStepper {
        var currentStepper: NSStepper
        switch sender.tag {
        case 1:
            currentStepper = digit2Stepper
        case 2:
            currentStepper = digit3Stepper
        case 3:
            currentStepper = digit4Stepper
        default:
            currentStepper = digit1Stepper
        }
        return currentStepper
    }
    
    func currentButtonIs(for sender: NSControl) -> NSButton {
        var currentButton: NSButton
        switch sender.tag {
        case 1:
            currentButton = digit2Btn
        case 2:
            currentButton = digit3Btn
        case 3:
            currentButton = digit4Btn
        default:
            currentButton = digit1Btn
        }
        return currentButton
    }
    
    
    
    
    @IBAction func submitGuess(_ sender: Any) {
        
        // check for 4 unique characters
        let guessString = guess.stringValue
        guard Set(guessString).count == 4 else { return }
        guard guessString.count == 4 else { return }
        
        // ensure there are no non-digit characters
        let badCharacters = CharacterSet(charactersIn: "0123456789").inverted
        guard guessString.rangeOfCharacter(from: badCharacters) == nil else { return }
        
        // add the guess to the array and table view
        guesses.insert(guessString, at: 0)
        tableView.insertRows(at: IndexSet(integer: 0), withAnimation: .slideDown)
        
        // Did the player win?
        let resultArray = result(for: guessString)
        
        if resultArray == [4,0] {
            let alert = NSAlert()
            alert.messageText = "You win !!! The number was: \(answer)"
            alert.informativeText = """
                Congratulations!
                You did it in \(guesses.count) turns.

                Click OK to play again.
                """
            alert.runModal()
            
            startNewGame()
        }
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return guesses.count
    }
    
    func result (for guess: String) -> [Int] {
        var bulls = 0
        var caws = 0
        
        let guessLetters = Array(guess)
        let answerLetters = Array(answer)
        
        for (index, letter) in guessLetters.enumerated() {
            if letter == answerLetters[index] {
                bulls += 1
            } else if answerLetters.contains(letter) {
                caws += 1
            }
        }
        return [bulls,caws]
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let vw = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else {
            return nil
        }
        let currentNumber = guesses[row]
        let numberAsArray = Array(currentNumber)
        
        let bulls = result(for: guesses[row])[0]
        let caws = result(for: guesses[row])[1]
        
        switch tableColumn?.title {
        
        case "Nr.":
            vw.textField?.stringValue = "\(guesses.count)."
        case "#1":
            vw.textField?.stringValue = String(numberAsArray[0])
        case "#2":
            vw.textField?.stringValue = String(numberAsArray[1])
        case "#3":
            vw.textField?.stringValue = String(numberAsArray[2])
        case "#4":
            vw.textField?.stringValue = String(numberAsArray[3])
        case "Matched : in Place":
            vw.textField?.stringValue = "\(bulls + caws) : \(bulls)"
        case "Bulls : Cows":
            vw.textField?.stringValue = "\(bulls)b : \(caws)c"
        default:
            vw.textField?.stringValue = ""
        }
        
        return vw
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return false
    }
    
    func startNewGame(){
        
        num1CheckBox.state = NSControl.StateValue.on
        num2CheckBox.state = NSControl.StateValue.on
        num3CheckBox.state = NSControl.StateValue.on
        num4CheckBox.state = NSControl.StateValue.on
        num5CheckBox.state = NSControl.StateValue.on
        num6CheckBox.state = NSControl.StateValue.on
        num7CheckBox.state = NSControl.StateValue.on
        num8CheckBox.state = NSControl.StateValue.on
        num9CheckBox.state = NSControl.StateValue.on
        num0CheckBox.state = NSControl.StateValue.on
        
        digit1Btn.title = String(checkBoxNumbers[0])
        digit2Btn.title = String(checkBoxNumbers[0])
        digit3Btn.title = String(checkBoxNumbers[0])
        digit4Btn.title = String(checkBoxNumbers[0])
        
        digit1Btn.state = NSControl.StateValue.on
        digit2Btn.state = NSControl.StateValue.on
        digit3Btn.state = NSControl.StateValue.on
        digit4Btn.state = NSControl.StateValue.on
        
        digit1Stepper.isEnabled = true
        digit2Stepper.isEnabled = true
        digit3Stepper.isEnabled = true
        digit4Stepper.isEnabled = true
        
        digit1Stepper.intValue = 0
        digit2Stepper.intValue = 0
        digit3Stepper.intValue = 0
        digit4Stepper.intValue = 0
        
        guess.stringValue = ""
        guesses.removeAll()
        answer = ""
        
        var numbers = Array(0...9)
        numbers.shuffle()
        
        for _ in 0 ..< 4 {
            answer.append(String(numbers.removeLast()))
        }
        
        tableView.reloadData()
    }
}

