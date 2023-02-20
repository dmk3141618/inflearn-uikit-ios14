//
//  ViewController.swift
//  MovieApp
//
//  Created by 이치훈 on 2023/02/14.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    var movieVO: MovieVO?
    var term = ""
    var movieAPI = API()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieTableView: UITableView!
    
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        self.movieTableView.delegate = self
        self.movieTableView.dataSource = self
        
        self.requestMovieAPI()
    }
    
    //MARK: - GetAPI
    func loadImage(urlString: String, completion: @escaping (UIImage?) -> Void){
        movieAPI.request(type: .justURL(urlString: urlString)) { data, response, error in
            guard let hasData = data else {
                completion(nil)
                return
            }
            completion(UIImage(data: hasData))
        }
    }
    
    
    func requestMovieAPI() {
        
        let term = URLQueryItem(name: "term", value: term)
        let media = URLQueryItem(name: "media", value: "movie")
        
        movieAPI.request(type: .searchMovie(querys: [term,media])) { data, response, error in
            guard let hasData = data else {return}
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
    
}
//MARK: - UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieVO?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = UIStoryboard(name: "DetailViewController", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        detailVC.movieResult = self.movieVO?.results[indexPath.row]
        
        self.present(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        cell.titleLabel.text = self.movieVO?.results[indexPath.row].trackName
        cell.descriptionLabel.text = self.movieVO?.results[indexPath.row].shortDescription ??
        self.movieVO?.results[indexPath.row].longDescription
        //"long description"
        
        let currency = self.movieVO?.results[indexPath.row].currency ?? ""
        let price = self.movieVO?.results[indexPath.row].trackPrice.description ?? ""
        
        cell.priceLabel.text = currency + " " + price
        
        //use loadImage
        if let hasURL = self.movieVO?.results[indexPath.row].image{
            self.loadImage(urlString: hasURL){ data in
                DispatchQueue.main.async {
                    cell.movieImageView.image = data
                }
                
            }
        }
        
        if let dateString = self.movieVO?.results[indexPath.row].releaseDate{
            let formatter = ISO8601DateFormatter()
            if let isoDate = formatter.date(from: dateString){
                
                let myFormatter = DateFormatter()
                myFormatter.dateFormat = "yyyy년 MM월 dd일"
                cell.dateLabel.text = myFormatter.string(from: isoDate)
            }
        }
        
        return cell
    }
    

}
//MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.term = searchBar.text ?? ""
        self.requestMovieAPI()
        
        self.view.endEditing(true)
    }
}
