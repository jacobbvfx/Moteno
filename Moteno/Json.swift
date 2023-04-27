//
//  Json.swift
//  Moteno
//
//  Created by jacob on 12/04/2023.
//

import Foundation

func JsonQuote(completion: @escaping (String) -> Void) {
    struct Ticker: Codable {
        let quote: String
    }
    
    guard let url = URL(string: "http://yourip:3000/list") else {
        completion("Invalid URL")
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data else {
            completion("No data received")
            return
        }
        
        do {
            let parsedJSON = try JSONDecoder().decode(Ticker.self, from: data)
            completion(parsedJSON.quote)
        } catch {
            completion("Error parsing JSON: \(error.localizedDescription)")
        }
    }
    .resume()
}

func JsonAuthor(completion: @escaping (String) -> Void) {
    struct Ticker: Codable {
        let author: String
    }
    
    guard let url = URL(string: "http://yourip:3000/list") else {
        completion("Invalid URL")
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data else {
            completion("No data received")
            return
        }
        
        do {
            let parsedJSON = try JSONDecoder().decode(Ticker.self, from: data)
            completion(parsedJSON.author)
        } catch {
            completion("Error parsing JSON: \(error.localizedDescription)")
        }
    }
    .resume()
}


//Trash Code

//var Quote: String = "Data not loaded yet"
//
//func Json() -> String {
//
//
//    struct Ticker: Codable {
//        let quote, author: String
//    }
//
//    if let url = URL(string: "http://localhost:3000/list") {
//        URLSession.shared.dataTask(with: url) { data, response, error in
//        if let data = data {
//            let jsonDecoder = JSONDecoder()
//                do {
//                    let parsedJSON = try jsonDecoder.decode(Ticker.self, from: data)
//                    if parsedJSON.quote != nil {
//                        print("Inside loop " + parsedJSON.quote)
//                        Quote = parsedJSON.quote
//                    }
//                } catch {
//                    print(error)
//                }
//            }
//        }
//        .resume.self()
//    }
//    print("Outside loop " + Quote)
//    return Quote
//}

