//
//  MoviesViewModel.swift
//  MovieCRUD
//
//  Created by Fernando Gomes on 14/04/20.
//  Copyright © 2020 Fernando Gomes. All rights reserved.
//

import Foundation

protocol MoviesViewModelProtocol {
    func getAll(completion: @escaping ([MovieModel], Error?) -> Void)
}

class MoviesViewModel: MoviesViewModelProtocol {
    func getAll(completion: @escaping ([MovieModel], Error?) -> Void) {
        let url = URL(string: "http://localhost:3000/api/v1/movies")
    
        
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion([], error)
            }
            
            guard let data = data else { return }
            do {
                let success = try JSONDecoder().decode([MovieModel].self, from: data)
                completion(success, error)
            } catch let fail{
                completion([], fail)
            }
        }
        task.resume()
    }    
}
