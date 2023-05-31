//
//  APICaller.swift
//  test1
//
//  Created by Hung Vu on 09/05/2023.
//

import Foundation
class APICaller {
    static var shared = APICaller()
    func getTrack(completion: @escaping (Result<[Song], Error>) -> Void){
       guard let url = URL(string: "https://api.jamendo.com/v3.0/tracks/?client_id=f4211734&format=jsonpretty&limit=200&boost=popularity_month") else {return}

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(String(describing: error))")
                return
            }
            
            do {
                let json = try JSONDecoder().decode(popularTrackInMonth.self, from: data)
                completion(.success(json.results))
                // handle the response data here
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
        
        task.resume()
    }
    func search(query: String, completion: @escaping (Result<[Song], Error>) -> Void) {
        guard let escapedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(NSError(domain: "Invalid query", code: 0, userInfo: nil)))
            return
        }
        
        let urlString = "https://api.jamendo.com/v3.0/tracks/?client_id=f4211734&format=jsonpretty&limit=200&search=\(escapedQuery)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(NSError(domain: "Error fetching data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let json = try JSONDecoder().decode(popularTrackInMonth.self, from: data)
                completion(.success(json.results))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    func getTrackforTag(completion: @escaping (Result<[Song], Error>) -> Void) {
        guard let url = URL(string: "https://api.jamendo.com/v3.0/tracks/?client_id=f4211734&format=jsonpretty&limit=200&tags=%5Bblues%5D") else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(String(describing: error))")
                return
            }

            do {
                let json = try JSONDecoder().decode(popularTrackInMonth.self, from: data)
                completion(.success(json.results))
                // Handle the response data here
            } catch {
                print("Error parsing JSON: \(error)")
                completion(.failure(error))
            }
        }

        task.resume()
    }
    func getTrackforTag1(completion: @escaping (Result<[Song], Error>) -> Void) {
        guard let url = URL(string: "https://api.jamendo.com/v3.0/tracks?client_id=f4211734&format=jsonpretty&limit=200&tags=%25electronic%5D&") else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(String(describing: error))")
                return
            }

            do {
                let json = try JSONDecoder().decode(popularTrackInMonth.self, from: data)
                completion(.success(json.results))
                // Handle the response data here
            } catch {
                print("Error parsing JSON: \(error)")
                completion(.failure(error))
            }
        }

        task.resume()
    }


}
