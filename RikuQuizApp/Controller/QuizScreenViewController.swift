//
//  QuizViewController.swift
//  RikuQuizApp
//
//  Created by Cookie-san on 2022/01/02.
//

import UIKit


class QuizScreenViewController: UIViewController{
    
    @IBOutlet weak var quizNumberLabel: UILabel!
    @IBOutlet weak var quizTextView: UITextView!
    @IBOutlet weak var judgeImageView: UIImageView!
    @IBOutlet var answerButton: [UIButton] = []
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var correctLabel: UILabel!
    
    var csvArray: [String] = []
    var quizArray: [String] = []
    var quizCount = 0
    var correctCount = 0
    var chosenLevel = 0
    var resultArray: [SavedAnswer] = []
    var imageArray: [UIImage] = []
    var animator: UIViewPropertyAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    private func setupView() {
        self.overrideUserInterfaceStyle = .light
        correctLabel.isHidden = true
        
        
        
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
        quizNumberLabel.text = "Question \(quizCount + 1)"
        quizTextView.text = quizArray[0]
        resetButton()
        csvArray.shuffle()
        print(csvArray)
    }
    
    private func resetButton() {
        for (index, button) in answerButton.enumerated() {
            button.layer.cornerRadius = 20
            button.setTitle(quizArray[2 + index], for: .normal)
            switch chosenLevel {
            case 1:
                button.backgroundColor = UIColor(hex: "ffcb69", alpha: 0.8)
                back.backgroundColor = UIColor(hex: "ffcb69", alpha: 0.8)
            case 2:
                button.backgroundColor = UIColor(hex: "4cc9f0", alpha: 0.8)
                back.backgroundColor = UIColor(hex: "4cc9f0", alpha: 0.8)
            case 3:
                button.backgroundColor = UIColor(hex: "02c39a", alpha: 0.8)
                back.backgroundColor = UIColor(hex: "02c39a", alpha: 0.8)
            case 4:
                button.backgroundColor = UIColor(hex: "9d4edd", alpha: 0.8)
                back.backgroundColor = UIColor(hex: "9d4edd", alpha: 0.8)
            case 5:
                button.backgroundColor = UIColor(hex: "e5383b", alpha: 0.8)
                back.backgroundColor = UIColor(hex: "e5383b", alpha: 0.8)
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
            self.judgeImageView.alpha = 0.8
            judgeImageView.isHidden = false
        }else{
            print("不正解")
            judgeImageView.image = UIImage(named: "incorrect")
            self.judgeImageView.alpha = 0.8
            judgeImageView.isHidden = false
        }
        
        back.isHidden = true
        correctLabel.isHidden = false
        correctLabel.text = "Correct Answer: \(quizArray[Int(quizArray[1])! + 1])"

        let correctAnswerWord = quizArray[Int(quizArray[1])! + 1]
        let answeredWord = quizArray[sender.tag + 1]

        let answerResult = SavedAnswer(result: correctAnswerWord == answeredWord ? true : false, correctAnswerWord: correctAnswerWord, answeredWord: answeredWord)
        resultArray.append(answerResult)
        
        print(resultArray)
        
        print("スコア: \(correctCount)")
        judgeImageView.isHidden = false
        for button in answerButton{
            button.isEnabled = false
        }
        
        
//        animator = UIViewPropertyAnimator(duration: 1.0,curve: .easeInOut) {
//            self.judgeImageView.center.y += 300
//            self.judgeImageView.alpha = 0.8
//        }
//
//        animator.startAnimation()
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.judgeImageView.isHidden = true
            
            for button in self.answerButton{
                button.isEnabled = true
                self.back.isEnabled = true
            }
            self.nextQuiz()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let scoreVC = segue.destination as! ScoreViewController
        scoreVC.correct = correctCount
        scoreVC.resultWord = resultArray
        scoreVC.finalResultLevel = chosenLevel
    }
    
    //クイズの状態を初期に戻す
    func nextQuiz(){
        quizCount += 1
        if quizCount < csvArray.count{
            quizArray = csvArray[quizCount].components(separatedBy: ",")
            quizNumberLabel.text = "Question \(quizCount + 1)"
            quizTextView.text = quizArray[0]
            judgeImageView.isHidden = true
            for button in self.answerButton{
                button.isEnabled = true
            }
            resetButton()
        }else{
            self.quizNumberLabel.textColor = .red
            self.quizNumberLabel.font = UIFont(name: "HiraKakuProN-W3", size: 40)
            self.quizNumberLabel.text = "Finish!"
            self.judgeImageView.image = UIImage(named: "finish")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                self.performSegue(withIdentifier: "toScoreVC", sender: nil)
            }
        }
        
        back.isHidden = false
        correctLabel.isHidden = true
        
    }
    
    @IBAction func quitButton(_ sender: Any) {
        let alert = UIAlertController(title: "Quit", message: "Back to top screen?", preferredStyle: .alert)
        
        let backToTop = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
            self.dismiss(animated: true, completion: nil)
            print("Yes button tapped")
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(backToTop)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
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
