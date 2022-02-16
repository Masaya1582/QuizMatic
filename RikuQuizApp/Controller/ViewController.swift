


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
    
    @IBAction func levelSelectButton(_ sender: UIButton) {
        
        selectedLevel = sender.tag
        let storyboard = UIStoryboard(name: "Quiz", bundle: nil)
        let quizVC = storyboard.instantiateViewController(withIdentifier: "quiz") as! QuizScreenViewController
        quizVC.chosenLevel = selectedLevel
        self.present(quizVC, animated: true)

    }
    
}
