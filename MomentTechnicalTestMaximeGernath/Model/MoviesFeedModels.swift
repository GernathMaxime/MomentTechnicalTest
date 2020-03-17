//
//  NewsFeedModels.swift
//  MomentTechnicalTestMaximeGernath
//
//  Created by Maxime Gernath on 17/03/2020.
//  Copyright © 2020 MaximeCorp. All rights reserved.
//

import Foundation

struct Global {
    static let api_key: String = "f73178cd5673afa07212f2424346be42"
}

class MoviesFeed: ObservableObject, RandomAccessCollection {
    typealias Element = MoviesListItem
    
    @Published var newsListItems = [MoviesListItem]()
    
    var startIndex: Int { newsListItems.startIndex }
    var endIndex: Int { newsListItems.endIndex }
    var loadStatus = LoadStatus.ready(nextPage: 1)
    
    var urlBase = "https://api.themoviedb.org/3/discover/movie?api_key=\(Global.api_key)&language=en-US&sort_by=popularity.desc&page="
    init() {
        loadMoreArticles()
    }
    
    subscript(position: Int) -> MoviesListItem {
        return newsListItems[position]
    }
    
    func loadMoreArticles(currentItem: MoviesListItem? = nil) {
        
        if !shouldLoadMoreData(currentItem: currentItem) {
            return
        }
        guard case let .ready(page) = loadStatus else {
            return
        }
        loadStatus = .loading(page: page)
        let urlString = "\(urlBase)\(page)"
        
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: parseMoviesFromResponse(data:response:error:))
        task.resume()
    }
    
    func shouldLoadMoreData(currentItem: MoviesListItem? = nil) -> Bool {
        guard let currentItem = currentItem else {
            return true
        }
        
        for n in (newsListItems.count - 4)...(newsListItems.count-1) {
            if n >= 0 && currentItem.uuid == newsListItems[n].uuid {
                return true
            }
        }
        return false
    }
    
    func parseMoviesFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            print("Error: \(error!)")
            loadStatus = .parseError
            return
        }
        guard let data = data else {
            print("No data found")
            loadStatus = .parseError
            return
        }
        
        let newMovies = parseMoviesFromData(data: data)
        DispatchQueue.main.async {
            self.newsListItems.append(contentsOf: newMovies)
            if newMovies.count == 0 {
                self.loadStatus = .done
            } else {
                guard case let .loading(page) = self.loadStatus else {
                    fatalError("loadSatus is in a bad state")
                }
                self.loadStatus = .ready(nextPage: page + 1)
            }
        }
    }
    
    func parseMoviesFromData(data: Data) -> [MoviesListItem] {
        var response: MoviesApiResponse
        do {
            response = try JSONDecoder().decode(MoviesApiResponse.self, from: data)
        } catch {
            print("Error parsing the JSON: \(error)")
            return []
        }
        
        return response.results ?? []
    }
    
    enum LoadStatus {
        case ready (nextPage: Int)
        case loading (page: Int)
        case parseError
        case done
    }
}

class MoviesApiResponse: Codable {
    var results: [MoviesListItem]?
}

class MoviesListItem: Identifiable, Codable {
    var uuid = UUID()
    
    var overview: String?
    var title: String
    var poster_path: String?
    var backdrop_path: String?
    var vote_average: Float
    
    enum CodingKeys: String, CodingKey {
        case overview, title, poster_path, backdrop_path, vote_average
    }
}
