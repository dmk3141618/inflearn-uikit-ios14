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
    
    func loadImage(urlString: String, completion: @escaping (UIImage?) -> Void){
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        if let hasURL = URL(string: urlString){
            var request = URLRequest(url: hasURL)
            request.httpMethod = "GET"
            
            let task = session.dataTask(with: request) { data, response, error in
                print( (response as! HTTPURLResponse).description )
                
                if let hasData = data {
                    completion(UIImage(data: hasData))
                    return
                }
            }
            task.resume()
            session.finishTasksAndInvalidate()
        }
        
        completion(nil)
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
        //api 요청 메서드
        
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


    }
}
