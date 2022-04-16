


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var levelOneButton: UIButton!
    @IBOutlet weak var levelTwoButton: UIButton!
    @IBOutlet weak var levelThreeButton: UIButton!
    @IBOutlet weak var levelFourButton: UIButton!
    @IBOutlet weak var levelFiveButton: UIButton!
    
    //レベルの識別
    var selectedLevel = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    //初期画面の設定、ボタンの角を丸くする
    private func setUpView() {
        levelOneButton.layer.cornerRadius = 20.0
        levelTwoButton.layer.cornerRadius = 20.0
        levelThreeButton.layer.cornerRadius = 20.0
        levelFourButton.layer.cornerRadius = 20.0
        levelFiveButton.layer.cornerRadius = 20.0
    }
    
    //レベル別に判断、遷移先でのボタンの色などを決定
    @IBAction func levelSelectButton(_ sender: UIButton) {
        selectedLevel = sender.tag
        let storyboard = UIStoryboard(name: "Quiz", bundle: nil)
        let quizVC = storyboard.instantiateViewController(withIdentifier: "quiz") as! QuizScreenViewController
        quizVC.chosenLevel = selectedLevel
        self.present(quizVC, animated: true)
    }
    
}
