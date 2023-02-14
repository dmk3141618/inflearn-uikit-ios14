//
//  ViewController.swift
//  MovieApp
//
//  Created by 이치훈 on 2023/02/14.
//

import UIKit

class ViewController: UIViewController {

    var movieVO: MovieVO?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        self.searchBar.delegate = self
        self.movieTableView.delegate = self
        self.movieTableView.dataSource = self
        
        self.requestMovieAPI()
    }

    //network
    func requestMovieAPI(){
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        var components = URLComponents(string: "https://itunes.apple.com/search")
        
        let term = URLQueryItem(name: "term", value: "marvel")
        let media = URLQueryItem(name: "media", value: "movie")
        components?.queryItems = [term, media]
        
        guard let url = components?.url else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
            print( (response as! HTTPURLResponse).statusCode )
            
            if let hasData = data{
                do{
                    self.movieVO = try JSONDecoder().decode(MovieVO.self, from: hasData)
                    print(self.movieVO ?? "no data")
                    
                    DispatchQueue.main.async {
                        self.movieTableView.reloadData()
                    }
                }
                catch{
                    print(error)
                }
            }
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }

}
//MARK: - UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieVO?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        cell.titleLabel.text = self.movieVO?.results[indexPath.row].trackName
        cell.descriptionLabel.text = self.movieVO?.results[indexPath.row].shortDescription ?? "long description"
        
        let currency = self.movieVO?.results[indexPath.row].currency ?? ""
        let price = self.movieVO?.results[indexPath.row].trackPrice.description ?? ""
        
        cell.priceLabel.text = currency + price
        
        return cell
    }
    
    
}
//MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {


    }
}
