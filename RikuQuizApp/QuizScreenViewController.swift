//
//  QuizViewController.swift
//  RikuQuizApp
//
//  Created by 中久木雅哉 on 2022/01/02.
//

import UIKit
import SRCountdownTimer

class QuizScreenViewController: UIViewController{
    
    @IBOutlet weak var quizNumberLabel: UILabel!
    @IBOutlet weak var quizTextView: UITextView!
    @IBOutlet weak var judgeImageView: UIImageView!
    @IBOutlet var answerButton: [UIButton] = []
    
    var csvArray: [String] = []
    var quizArray: [String] = []
    var quizCount = 0
    var correctCount = 0
    var timerCount = 10
    var chosenLevel = 0
    var resultArray: [SavedAnswer] = []
    var imageArray: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        switch chosenLevel {
        case 1:
            csvArray = loadCSV(fileName: "levelOne")
        case 2:
            csvArray = loadCSV(fileName: "levelTwo")
        case 3:
            csvArray = loadCSV(fileName: "levelThree")
        case 4:
            csvArray = loadCSV(fileName: "levelFour")
        case 5:
            csvArray = loadCSV(fileName: "levelFive")
        default:
            print("ERROR")
        }
    
        quizArray = csvArray[quizCount].components(separatedBy: ",")
        quizNumberLabel.text = "第\(quizCount + 1)問"
        quizTextView.text = quizArray[0]
        resetButton()
        //出題の順番をシャッフルする
        csvArray.shuffle()
        print(csvArray)
    }
    
    private func resetButton() {
        for (index, button) in answerButton.enumerated() {
            button.layer.cornerRadius = 20
            button.setTitle(quizArray[2 + index], for: .normal)
            switch chosenLevel {
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

    @IBAction func btnAction(_ sender: UIButton) {
        if sender.tag == Int(quizArray[1]){
            correctCount += 1
            print("正解")
            judgeImageView.image = UIImage(named: "correct")
            judgeImageView.isHidden = false
            //resultImageArray.append(UIImage(named: "correct")!)
            
        }else{
            print("不正解")
            judgeImageView.image = UIImage(named: "incorrect")
            judgeImageView.isHidden = false
        }
        
        //配列に加える(ボタンが押されるごとに）
        let correctAnswerWord = quizArray[Int(quizArray[1])! + 1]
        let answeredWord = quizArray[sender.tag + 1]
        if correctAnswerWord == answeredWord{
            let answerResult = SavedAnswer(result: true, correctAnswerWord: correctAnswerWord, answeredWord: answeredWord)
            resultArray.append(answerResult)
        }else{
            let answerResult = SavedAnswer(result: false, correctAnswerWord: correctAnswerWord, answeredWord: answeredWord)
            resultArray.append(answerResult)
        }
        print(resultArray)
    
        print("スコア: \(correctCount)")
        judgeImageView.isHidden = false
        for button in answerButton{
            button.isEnabled = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.judgeImageView.isHidden = true
            for button in self.answerButton{
                button.isEnabled = true
            }
            self.nextQuiz()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let scoreVC = segue.destination as! ScoreViewController
        scoreVC.correct = correctCount
        scoreVC.resultWord = resultArray
        //scoreVC.resultImage = resultImageArray
        scoreVC.finalResultLevel = chosenLevel
    }
    
    //クイズの状態を初期に戻す
    func nextQuiz(){
        quizCount += 1
        if quizCount < csvArray.count{
            quizArray = csvArray[quizCount].components(separatedBy: ",")
            quizNumberLabel.text = "第\(quizCount + 1)問"
            quizTextView.text = quizArray[0]
            judgeImageView.isHidden = true
            for button in self.answerButton{
                button.isEnabled = true
            }
            resetButton()
        }else{
            performSegue(withIdentifier: "toScoreVC", sender: nil)
        }
    }
    
    @IBAction func quitButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func loadCSV(fileName: String) -> [String]{
        let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
        do{
            let csvData = try String(contentsOfFile: csvBundle,encoding: String.Encoding.utf8)
            let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
            csvArray = lineChange.components(separatedBy: "\n")
            csvArray.removeLast()
        }catch{
            print("エラー")
        }
        return csvArray
    }
}
