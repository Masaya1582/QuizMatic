


import UIKit
import PKHUD

class ScoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
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
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        if correct <= 1 {
            scoreLabel.text = "\(correct) correct answer"
        }else {
            scoreLabel.text = "\(correct) correct answers"
        }
        
        if correct == 20 {
            commentLabel.text = "Perfect!!!"
            commentLabel.textColor = .red
            
        }else if correct >= 15{
            commentLabel.text = "You're doing great!!"
            commentLabel.textColor = .red
            
        }else if correct >= 10{
            commentLabel.text = "You can do better!"
            commentLabel.textColor = .red
            
        }else {
            commentLabel.text = "Try one more time!"
            commentLabel.textColor = .red
        }
        
        for button in changeColorButton{
            button.layer.cornerRadius = 20.0
            switch finalResultLevel {
            case 1:
                button.backgroundColor = UIColor(hex: "ffcb69", alpha: 1.0)
            case 2:
                button.backgroundColor = UIColor(hex: "4cc9f0", alpha: 1.0)
            case 3:
                button.backgroundColor = UIColor(hex: "02c39a", alpha: 1.0)
            case 4:
                button.backgroundColor = UIColor(hex: "9d4edd", alpha: 1.0)
            case 5:
                button.backgroundColor = UIColor(hex: "e5383b", alpha: 1.0)
            default:
                print("Error")
            }
        }
    }
    
<<<<<<< HEAD
    func readAds() {
        
        let request = GADRequest()
            GADInterstitialAd.load(withAdUnitID:"ca-app-pub-3940256099942544/4411468910",request: request,completionHandler: { [self] ad, error in
                
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
          
        //HUD.flash(.success, delay: 1.0)
        HUD.flash(.label("Thank you for Playing!"), delay: 1.0)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
          
      }
    
=======
>>>>>>> ecadebc42f24c3df3d05898e6e99b8e12e8ab282
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultWord.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    
    @IBAction func shareButtonAction(_ sender: Any) {
<<<<<<< HEAD
        
=======
>>>>>>> ecadebc42f24c3df3d05898e6e99b8e12e8ab282
        let activityItems = ["Fun to learn English!","#QuizMatic"]
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        self.present(activityVC, animated: true)
    }
    
    
    @IBAction func toTopButtonAction(_ sender: Any) {
<<<<<<< HEAD
        
        if interstitial != nil {
            interstitial?.present(fromRootViewController: self)
          } else {
            self.presentingViewController?.presentingViewController?.dismiss(animated: true)
          }
=======
        HUD.flash(.label("Thank you for Playing!"), delay: 1.0)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
>>>>>>> ecadebc42f24c3df3d05898e6e99b8e12e8ab282
        
    }
    
}
