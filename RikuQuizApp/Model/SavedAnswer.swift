


import Foundation

class SavedAnswer {
    
    var result = false
    
    var correctAnswerWord = ""
    
    var answeredWord = ""
    
    init(result: Bool, correctAnswerWord: String, answeredWord: String) {
        self.result = result
        self.correctAnswerWord = correctAnswerWord
        self.answeredWord = answeredWord
    }
    
}
