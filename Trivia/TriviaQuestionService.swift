//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Elizabeth Kushelevsky on 3/27/25.
//

import Foundation

class TriviaQuestionService {
    static func fetchRandomQuestion(amount: Int, type: String? = nil, completion: @escaping ([TriviaQuestion]?) -> Void) {
        let parameters = "amount=\(amount)" + ("&type=multiple")
        let url = URL(string: "https://opentdb.com/api.php?\(parameters)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("Error: \(error!.localizedDescription)")
                completion(nil)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Invalid response status code")
                completion(nil)
                return
            }
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(TriviaQuestionResponse.self, from: data)
                completion(response.results)
            } catch {
                print("Failed to decode JSON: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
}

