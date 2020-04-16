//
//  MovieView.swift
//  MovieCRUD
//
//  Created by Fernando Gomes on 16/04/20.
//  Copyright © 2020 Fernando Gomes. All rights reserved.
//

import SwiftUI

struct MovieView: View {
    
    @ObservedObject var movie: Movie
    
    init(movieId: String) {
        movie = Movie(id: movieId)
    }
    var body: some View {
        VStack {
            Image(systemName: "person")
            Text("\(movie.movie?.name ?? "")")
            Text("\(movie.movie?.description ?? "")")
        }
        
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(movieId: "5e939bdb96b1fe2061da9c31")
    }
}

class Movie: ObservableObject {
    @Published var movie: MovieModel?
    
    init(id: String) {
        MovieViewModel().getMovie(by: id) { (movie, error) in
            if error != nil {
                
            }
            
            DispatchQueue.main.async {
                self.movie = movie
            }
        }
    }
}
