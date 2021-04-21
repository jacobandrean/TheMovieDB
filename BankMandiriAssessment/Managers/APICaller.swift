//
//  APICaller.swift
//  BankMandiriAssessment
//
//  Created by Jacob Andrean on 20/04/21.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let apiKey = "api_key=9cf5ae4b51f89dfbf930cffb014510ce"
        static let baseEndpoint = "https://api.themoviedb.org/3"
        static let language = "&language=en-US"
        static let sortBy = "&sort_by=popularity.desc"
//        https://api.themoviedb.org/3/genre/movie/list?api_key=9cf5ae4b51f89dfbf930cffb014510ce&language=en-US
//        https://api.themoviedb.org/3/discover/movie?api_key=9cf5ae4b51f89dfbf930cffb014510ce&language=en-US&sort_by=popularity.desc&page=1&with_genres=28
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    public func getGenres(completion: @escaping (Result<[Genre], Error>) -> Void) {
        let urlString = Constants.baseEndpoint + "/genre/movie/list?" + Constants.apiKey + Constants.language
        createRequest(with: URL(string: urlString), type: .GET) { (request) in
            let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(AllGenres.self, from: data)
                    completion(.success(result.genres))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getMovies(for genre: Genre, page: Int = 1, completion: @escaping (Result<[MovieResult], Error>) -> Void) {
        let urlString = Constants.baseEndpoint + "/discover/movie?" + Constants.apiKey + Constants.language + Constants.sortBy + "&page=\(page)&with_genres=\(genre.id)"
        createRequest(with: URL(string: urlString), type: .GET) { (request) in
            let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(AllMovies.self, from: data)
                    completion(.success(result.results))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    //https://api.themoviedb.org/3/movie/644083/videos?api_key=9cf5ae4b51f89dfbf930cffb014510ce&language=en-US

    public func getVideo(for movieID: Int, completion: @escaping (Result<VideoResult,Error>) -> Void) {
        let urlString = Constants.baseEndpoint + "/movie/\(movieID)/videos?" + Constants.apiKey + Constants.language
        createRequest(with: URL(string: urlString), type: .GET) { (request) in
            let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(Video.self, from: data)
                    if let res = result.results.first {
                        completion(.success(res))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    enum HTTPMethod: String {
        case GET, POST
    }
    
    private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
        guard let url = url else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        completion(request)
    }
    
}
