


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var selectLevelButton: [UIButton]!
    
    //レベルの識別
    var selectedLevel = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    //初期画面の設定、ボタンの角を丸くする
    private func setUpView() {
        selectLevelButton.forEach({ $0.layer.cornerRadius = 20.0 })
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
