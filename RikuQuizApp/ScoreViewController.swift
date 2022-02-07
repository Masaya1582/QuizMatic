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
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet var changeColorButton: [UIButton] = []
    
    var correct = 0
    var resultWord = [SavedAnswer]()
    var finalResultLevel = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.overrideUserInterfaceStyle = .light
        
        if correct >= 18{
            commentLabel.text = "You're genius!"
            resultImage.image = UIImage(named: "")
        }else if correct >= 15{
            commentLabel.text = "Try one more time!"
            resultImage.image = UIImage(named: "")
        }else{
            commentLabel.text = "Practice Everyday!"
            resultImage.image = UIImage(named: "")
        }
        scoreLabel.text = "正解数:\(correct)問"
        
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
        let activityItems = ["\(correct)問正解しました。","#クイズアプリ"]
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
    
    //何匁が正解不正解だったかを表示する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "correctWords", for: indexPath)
        cell.textLabel?.text = resultWord[indexPath.row].correctAnswerWord
        cell.textLabel?.font = UIFont.systemFont(ofSize: 25)
        if resultWord[indexPath.row].result == true{
            cell.imageView?.image = UIImage(named: "correct")
        }else{
            cell.imageView?.image = UIImage(named: "incorrect")
        }
        //cell.imageView!.image = resultImage[indexPath.row]
        return cell
    }
}
