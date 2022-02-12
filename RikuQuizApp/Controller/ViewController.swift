//
//  ViewController.swift
//  RikuQuizApp
//
//  Created by 中久木雅哉 on 2022/01/02.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
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
        
        titleLabel.backgroundColor = UIColor(hex: "bde0fe", alpha: 1.0)
        levelOneButton.backgroundColor = UIColor(hex: "ffcb69", alpha: 1.0)
        levelTwoButton.backgroundColor = UIColor(hex: "4cc9f0", alpha: 1.0)
        levelThreeButton.backgroundColor = UIColor(hex: "02c39a", alpha: 1.0)
        levelFourButton.backgroundColor = UIColor(hex: "9d4edd", alpha: 1.0)
        levelFiveButton.backgroundColor = UIColor(hex: "e5383b", alpha: 1.0)
        
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
