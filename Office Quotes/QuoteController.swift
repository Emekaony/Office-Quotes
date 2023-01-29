//
//  QuoteController.swift
//  Office Quotes
//
//  Created by SHAdON . on 1/28/23.
//

import Foundation

class QuoteController {
    enum NetworkError: Error {
        case noDataReturned, tryAgain, networkFailure
    }
    
    private let baseURL = URL(string: "https://officeapi.dev/api/quotes/random")!
    
    func fetchQuote(completion: @escaping (Result<Quote, NetworkError>) -> Void) {
        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Try again, there was an error: \(error)")
                completion(.failure(.tryAgain))
                return
            }
            if let response = response as? HTTPURLResponse,
               response.statusCode == 401 {
                print("oh noo, network failure: \(response)")
                completion(.failure(.networkFailure))
                return
            }
            
            guard let data = data else {
                print("No data received form fetchQuote")
                completion(.failure(.noDataReturned))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let quote = try decoder.decode(Quote.self, from: data)
                completion(.success(quote))
            } catch {
                print("Error decoding quote data: \(error)")
                completion(.failure(.tryAgain))
            }
        }
        // do not ever forget this line in your code
        task.resume()
    }
}
