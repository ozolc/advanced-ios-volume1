//
//  TestViewController.swift
//  Polyglot
//
//  Created by Maksim Nosov on 18/06/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var prompt: UILabel!
    
    var words: [String]!
    var questionCounter = 0
    var showingQuestion = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(nextTapped))
        words.shuffle()
        title = "TEST"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // the view was just shown - start asking a question now
        askQuestion()
    }
    
    @objc func nextTapped() {
        // move between showing question and answer
        showingQuestion = !showingQuestion
        
        if showingQuestion {
            // we should be showing the question – reset!
            prepareForNextQuestion()
        } else {
            // we should be showing the answer – show it now, and set the color to be green
            prompt.text = words[questionCounter].components(separatedBy: "::")[0]
            prompt.textColor = UIColor(red: 0, green: 0.7, blue: 0, alpha: 1)
        }
    }
    
    func askQuestion() {
        // move the question counter one place
        questionCounter += 1
        if questionCounter == words.count {
            // wrap it back to 0 if we've gone beyond the size of the array
            questionCounter = 0
        }
        
        // pull out the French word at the current question position
        prompt.textColor = words[questionCounter].components(separatedBy: "::")[1]
    }
    
    func prepareForNextQuestion() {
        // reset the prompt back to black
        prompt.textColor = UIColor.black
        
        // proceed with the next question
        askQuestion()
    }
}
