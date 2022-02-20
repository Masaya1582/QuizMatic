


import UIKit
import GoogleMobileAds
import PKHUD

class QuizScreenViewController: UIViewController,GADFullScreenContentDelegate{
    
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
    
    private var interstitial: GADInterstitialAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        readAds()
        
    }
    
    private func setupView() {
        
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
        
        correctLabel.isHidden = true
        quizArray = csvArray[quizCount].components(separatedBy: ",")
        csvArray.shuffle()
        quizNumberLabel.text = "Question \(quizCount + 1)"
        quizTextView.text = quizArray[0]
        resetButton()
        
    }
    
    func readAds() {
        
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-3728831230250514/5361854342",request: request,completionHandler: { [self] ad, error in
            
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            interstitial = ad
            interstitial?.fullScreenContentDelegate = self
        })
        
    }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
    }
    
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did present full screen content.")
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
        
        HUD.flash(.success, delay: 1.0)
        dismiss(animated: true, completion: nil)
        
    }
    
    private func resetButton() {
        
        for (index, button) in answerButton.enumerated() {
            button.layer.cornerRadius = 20
            button.setTitle(quizArray[2 + index], for: .normal)
            switch chosenLevel {
            case 1:
                button.backgroundColor = UIColor(hex: "ffcb69", alpha: 1.0)
                back.backgroundColor = UIColor(hex: "ffcb69", alpha: 1.0)
            case 2:
                button.backgroundColor = UIColor(hex: "4cc9f0", alpha: 1.0)
                back.backgroundColor = UIColor(hex: "4cc9f0", alpha: 1.0)
            case 3:
                button.backgroundColor = UIColor(hex: "02c39a", alpha: 1.0)
                back.backgroundColor = UIColor(hex: "02c39a", alpha: 1.0)
            case 4:
                button.backgroundColor = UIColor(hex: "9d4edd", alpha: 1.0)
                back.backgroundColor = UIColor(hex: "9d4edd", alpha: 1.0)
            case 5:
                button.backgroundColor = UIColor(hex: "e5383b", alpha: 1.0)
                back.backgroundColor = UIColor(hex: "e5383b", alpha: 1.0)
            default:
                print("Error")
            }
        }
        
    }
    
    func nextQuiz() {
        
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
            self.quizNumberLabel.font = UIFont(name: "HiraKakuProN-W3", size: 35)
            self.quizNumberLabel.text = "Finish!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                let storyboard = UIStoryboard(name: "Score", bundle: nil)
                let scoreVC = storyboard.instantiateViewController(withIdentifier: "score") as! ScoreViewController
                scoreVC.correct = self.correctCount
                scoreVC.resultWord = self.resultArray
                scoreVC.finalResultLevel = self.chosenLevel
                self.present(scoreVC, animated: true)
            }
        }
        
        back.isHidden = false
        correctLabel.isHidden = true
        
    }
    
    func loadCSV(fileName: String) -> [String] {
        
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
    
    @IBAction func btnAction(_ sender: UIButton) {
        
        if sender.tag == Int(quizArray[1]) {
            correctCount += 1
            print("正解")
            judgeImageView.image = UIImage(named: "correct")
            self.judgeImageView.alpha = 0.8
            judgeImageView.isHidden = false
        }else {
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.judgeImageView.isHidden = true
            
            for button in self.answerButton{
                button.isEnabled = true
            }
            self.nextQuiz()
        }
    }
    
    @IBAction func quitButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Quit", message: "Back to top screen?", preferredStyle: .alert)
        
        let backToTop = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
            
            if self.interstitial != nil {
                self.interstitial?.present(fromRootViewController: self)
            } else {
                print("Ad wasn't ready")
            }
            
            print("Yes button tapped")
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(backToTop)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
        
    }
    
}
