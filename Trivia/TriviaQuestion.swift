//
//  TriviaQuestion.swift
//  Trivia
//
//  Created by Mari Batilando on 4/6/23.
//

import Foundation

struct TriviaQuestionResponse: Decodable {
    let results: [TriviaQuestion]
}

struct TriviaQuestion: Decodable {
  let category: String
  let question: String
  let correctAnswer: String
  let incorrectAnswers: [String]
    
    private enum CodingKeys: String, CodingKey {
        case category
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}

extension String {
    var htmlDecoded: String {
        guard let data = self.data(using: .utf8) else { return self }
        if let attributedString = try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
        ) {
            return attributedString.string
        }
        return self
    }
}
