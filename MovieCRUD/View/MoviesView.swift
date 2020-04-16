//
//  MoviesView.swift
//  MovieCRUD
//
//  Created by Fernando Gomes on 15/04/20.
//  Copyright © 2020 Fernando Gomes. All rights reserved.
//

import SwiftUI

struct MoviesView: View {
    @ObservedObject var moviesVC = Movies()
    var body: some View {
        List(moviesVC.movies) { movie in
            VStack {
                Text(movie.name).font(.title)
                Text(movie.description).font(.body)
            }
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}



class Movies: ObservableObject {
    @Published var movies: [MovieModel] = []
    init() {
        MoviesViewModel().getAll { (movies, error) in
            if error != nil {
                
            }
            DispatchQueue.main.async {
                self.movies = movies
            }
            
        }
    }
}
