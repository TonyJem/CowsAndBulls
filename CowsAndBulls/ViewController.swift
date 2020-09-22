//
//  ViewController.swift
//  CowsAndBulls
//
//  Created by Anton on 2020-09-22.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    @IBOutlet var tableView: NSTableView!
    @IBOutlet var guess: NSTextField!
    
    //    Correct answer
    var answer = ""
    
    //    Array to store player's guesses
    var guesses = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startNewGame()
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    @IBAction func submitGuess(_ sender: Any) {
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return guesses.count
    }
    
    func result (for guess: String) -> String {
        var bulls = 0
        var caws = 0
        
        let guessLetters = Array(guess)
        let answerLetter = Array(answer)
        
        for (index, letter) in guessLetters.enumerated() {
            if letter == answerLetter[index] {
                bulls += 1
            } else if answerLetter.contains(letter) {
                caws += 1
            }
        }
        return " \(bulls)b \(caws)c"
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let vw = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else {
            return nil
        }
        
        if tableColumn?.title == "Guess" {
            // this is the Guess column, show a previuos guess
            vw.textField?.stringValue = guesses[row]
        } else {
            // this is the Result column, call our new method
            vw.textField?.stringValue = result(for: guesses[row])
        }
        
        return vw
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return false
    }
    
    func startNewGame(){
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

