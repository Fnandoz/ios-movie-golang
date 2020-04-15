//
//  MovieViewModel.swift
//  MovieCRUD
//
//  Created by Fernando Gomes on 14/04/20.
//  Copyright © 2020 Fernando Gomes. All rights reserved.
//

import Foundation

protocol MovieViewModelProtocol {
    func getMovie(by id: String, completion: @escaping (MovieModel?, Error?) -> Void)
    func deleteMovie(by id: String, completion: @escaping ([String: String], Error?) -> Void)
    func createMovie(movie: MovieModel, completion: @escaping (MovieModel?, Error?) -> Void)
}

class MovieViewModel: MovieViewModelProtocol {
    func getMovie(by id: String, completion: @escaping (MovieModel?, Error?) -> Void) {
        let url = URL(string: "http://localhost:3000/api/v1/movies/\(id)")
        
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(nil, error)
            }
            
            guard let data = data else { return }
            do {
                let success = try JSONDecoder().decode(MovieModel.self, from: data)
                completion(success, error)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    func deleteMovie(by id: String, completion: @escaping ([String : String], Error?) -> Void) {
        let url = URL(string: "http://localhost:3000/api/v1/movies/\(id)")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion([:], error)
            }
            
            guard let data = data else { return }
            do {
                let success = try JSONDecoder().decode([String: String].self, from: data)
                completion(success, error)
            } catch {
                completion([:], error)
            }
        }
        task.resume()
    }
    
    func createMovie(movie: MovieModel, completion: @escaping (MovieModel?, Error?) -> Void) {
        let url = URL(string: "http://localhost:3000/api/v1/movies/")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            request.httpBody = try JSONEncoder().encode(movie)
        } catch let error {
            completion(nil, error)
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(nil, error)
            }
            
            guard let data = data else { return }
            do {
                let success = try JSONDecoder().decode(MovieModel.self, from: data)
                completion(success, error)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
