//
//  ViewController.swift
//  RikuQuizApp
//
//  Created by 中久木雅哉 on 2022/01/02.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var levelOneButton: UIButton!
    @IBOutlet weak var levelTwoButton: UIButton!
    @IBOutlet weak var levelThreeButton: UIButton!
    @IBOutlet weak var levelFourButton: UIButton!
    @IBOutlet weak var levelFiveButton: UIButton!
    
    var selectedLevel = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        
    }
    
    private func setUpView() {
        levelOneButton.layer.cornerRadius = 20.0
        levelTwoButton.layer.cornerRadius = 20.0
        levelThreeButton.layer.cornerRadius = 20.0
        levelFourButton.layer.cornerRadius = 20.0
        levelFiveButton.layer.cornerRadius = 20.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let quizScreenVC = segue.destination as! QuizScreenViewController
        quizScreenVC.chosenLevel = selectedLevel
    }
    
    @IBAction func levelSelectButton(_ sender: UIButton) {
        selectedLevel = sender.tag
        performSegue(withIdentifier: "nextQuiz", sender: nil)
    }
    
}
