//
//  APICaller.swift
//  test1
//
//  Created by Hung Vu on 09/05/2023.
//

import Foundation
import Alamofire
class APICaller {
    static var shared = APICaller()
    func getTrack(){
       guard let url = URL(string: "https://api.jamendo.com/v3.0/tracks/?client_id=f4211734&format=jsonpretty&limit=200&boost=popularity_month") else {return}

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(String(describing: error))")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(json)
                // handle the response data here
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
        
        task.resume()
    }
    
}
//        func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
//            guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
//            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
//                guard let data = data, error == nil else {
//                    return
//                }
//
//                do {
//                    let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
//                    completion(.success(results.results))
//
//                } catch {
//                    completion(.failure(APIError.failedTogetData))
//                }
//            }
//
//            task.resume()
//        }
