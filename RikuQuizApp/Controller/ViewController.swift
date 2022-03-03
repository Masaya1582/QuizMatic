


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
        levelOneButton.layer.cornerRadius = 20.0
        levelTwoButton.layer.cornerRadius = 20.0
        levelThreeButton.layer.cornerRadius = 20.0
        levelFourButton.layer.cornerRadius = 20.0
        levelFiveButton.layer.cornerRadius = 20.0
    }
    
    @IBAction func levelSelectButton(_ sender: UIButton) {
        selectedLevel = sender.tag
        let storyboard = UIStoryboard(name: "Quiz", bundle: nil)
        let quizVC = storyboard.instantiateViewController(withIdentifier: "quiz") as! QuizScreenViewController
        quizVC.chosenLevel = selectedLevel
        self.present(quizVC, animated: true)
    }
    
}
