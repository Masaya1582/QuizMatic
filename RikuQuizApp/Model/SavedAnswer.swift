


import Foundation

class SavedAnswer {
    //結果の判定
    var result = false
    //正しい答えの単語
    var correctAnswerWord = ""
    //ユーザが選んだ答え
    var answeredWord = ""
    
    init(result: Bool, correctAnswerWord: String, answeredWord: String) {
        self.result = result
        self.correctAnswerWord = correctAnswerWord
        self.answeredWord = answeredWord
    }
    
}
