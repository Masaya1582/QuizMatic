//
//  SavedAnswers.swift
//  RikuQuizApp
//
//  Created by 中久木雅哉 on 2022/01/14.
//

import Foundation

class SavedAnswer {
    // 正誤を表すフラグ（正解：true、不正解：false）
    var result = false
    
    // 正解の単語
    var correctAnswerWord = ""
    
    // 答えた単語
    var answeredWord = ""
    
    init(result: Bool, correctAnswerWord: String, answeredWord: String) {
        self.result = result
        self.correctAnswerWord = correctAnswerWord
        self.answeredWord = answeredWord
    }
}
