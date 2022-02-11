//
//  ScoreViewController.swift
//  RikuQuizApp
//
//  Created by 中久木雅哉 on 2022/01/02.
//

import UIKit
import PKHUD

class ScoreViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var changeColorButton: [UIButton] = []
    
    var correct = 0
    var resultWord = [SavedAnswer]()
    var finalResultLevel = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupResultView()
        
    }
    
    func setupResultView() {
        self.overrideUserInterfaceStyle = .light
        
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        if correct >= 18{
            commentLabel.text = "You're genius!"
            
        }else if correct >= 15{
            commentLabel.text = "Try one more time!"
            
        }else{
            commentLabel.text = "Practice Everyday!"
            
        }
        scoreLabel.text = "Correct Answers:\(correct)"
        
        for button in changeColorButton{
            button.layer.cornerRadius = 20.0
            switch finalResultLevel {
            case 1:
                button.backgroundColor = .systemYellow
            case 2:
                button.backgroundColor = .systemTeal
            case 3:
                button.backgroundColor = .systemGreen
            case 4:
                button.backgroundColor = .systemPurple
            case 5:
                button.backgroundColor = .systemRed
            default:
                print("Error")
            }
        }
    }
    
    
    @IBAction func shareButtonAction(_ sender: Any) {
        let activityItems = ["I got \(correct) correct answer","#En-En Quiz"]
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        self.present(activityVC, animated: true)
    }
    
    
    @IBAction func toTopButtonAction(_ sender: Any) {
        HUD.flash(.success, delay: 1.0)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultWord.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "correctWords", for: indexPath)
        //        cell.textLabel?.text = resultWord[indexPath.row].correctAnswerWord
        //        cell.textLabel?.font = UIFont.systemFont(ofSize: 25)
        //        if resultWord[indexPath.row].result == true{
        //            cell.imageView?.image = UIImage(named: "correct")
        //        }else{
        //            cell.imageView?.image = UIImage(named: "incorrect")
        //        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! MainTableViewCell
        if resultWord[indexPath.row].result == true{
            cell.kekkaImage.image = UIImage(named: "correct")
        }else{
            cell.kekkaImage.image = UIImage(named: "incorrect")
        }
        cell.seikaiLabel.text = resultWord[indexPath.row].correctAnswerWord
        cell.seikaiLabel.font = UIFont.systemFont(ofSize: 25)
        
        return cell
    }
    
    
}
