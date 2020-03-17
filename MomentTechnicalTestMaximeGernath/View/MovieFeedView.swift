//
//  NewFeedView.swift
//  MomentTechnicalTestMaximeGernath
//
//  Created by Maxime Gernath on 17/03/2020.
//  Copyright © 2020 MaximeCorp. All rights reserved.
//

import SwiftUI

struct MoviesFeedView: View {
    init() {
        UITableViewCell.appearance().backgroundColor = UIColor(red: 20/255, green: 29/255, blue: 38/255, alpha: 1.0)
        UITableView.appearance().backgroundColor = UIColor(red: 20/255, green: 29/255, blue: 38/255, alpha: 1.0)
    }
    
    @ObservedObject var newsFeed = MoviesFeed()
    
    var body: some View {
        NavigationView() {
            List(newsFeed) { (movie: MoviesListItem) in
                NavigationLink(destination: MovieDetail(movie: movie)) {
                    MoviesListItemView(movie: movie)
                        .onAppear {
                            self.newsFeed.loadMoreArticles(currentItem: movie)
                    }
                }
                .navigationBarTitle(Text("Movies List").bold()).foregroundColor(Color.white)
            }
        }
    }
}

struct MoviesListItemView: View {
    var movie: MoviesListItem
    
    var body: some View {
        HStack {
            UrlImageView(urlString: movie.poster_path)
            VStack(alignment: .leading) {
                Text("\(movie.title)")
                    .font(.headline).foregroundColor(Color.white)
                Text("\(movie.overview ?? "No Author")")
                    .font(.subheadline).foregroundColor(Color.white)
            }
        }
    }
}

struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesFeedView()
    }
}
