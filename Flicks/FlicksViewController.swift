//
//  FlicksViewController.swift
//  Flicks
//
//  Created by Harsh Trivedi on 10/17/16.
//  Copyright © 2016 Harsh Trivedi. All rights reserved.
//

import UIKit
import AFNetworking
import Alamofire
import AlamofireImage
import SwiftyJSON

class FlicksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var movies:[NSDictionary]?
    var endPoint :String = "";
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge);
    var loadingView: UIView = UIView();
    let apiKey = "65a43a35d8bc9401ed324ccf8cec00f8"
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self;
        tableView.delegate = self;
        makeNetworkRequest();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let movies = movies{
            return movies.count;
        } else{
            return 0;
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieViewCell
        
        let movie = movies![indexPath.row];
        let title = movie["title"] as! String;
        let overview = movie["overview"] as! String;
        
        let baseURL = "https://image.tmdb.org/t/p/w500";
        if let posterPath = movie["poster_path"] as? String{
                let imageURL = NSURL(string: baseURL + posterPath);
                cell.movieCellPosterView.setImageWith(imageURL! as URL);
        }
        
        
        //cell.movieCellPosterView
        cell.movieCellTitle.text = title;
        cell.movieCellOverview.text = overview;
        
        
        
        //cell.textLabel?.text = title;
        print("row \(indexPath.row) and \(title)");
        return cell;
        
    }

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell;
        let indexPath = tableView.indexPath(for: cell);
        let movie = movies![(indexPath?.row)!];
        
        let detailViewController = segue.destination as! DetailViewController;
        detailViewController.movie = movie;
        
    }
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.loadingView = UIView()
            self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
            self.loadingView.center = self.view.center
            self.loadingView.backgroundColor = UIColor.gray
            self.loadingView.alpha = 0.7
            self.loadingView.clipsToBounds = true
            self.loadingView.layer.cornerRadius = 10
            
            self.spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
            self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)
            
            self.loadingView.addSubview(self.spinner)
            self.view.addSubview(self.loadingView)
            self.spinner.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async{
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }
    
    func makeNetworkRequest(){
        
        let urlString = "https://api.themoviedb.org/3/movie/\(endPoint)?api_key=\(apiKey)";
        
        showActivityIndicator();
        Alamofire.request(urlString).responseJSON{ response in // method defaults to `.get`
            print("------------------------------------------------");
            print("response is \(response.result.value)");
            print("-------------------------------------------------");
            
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("error calling API")
                print(response.result.error!)
                return
            }

            guard let responseAsDictionary = response.result.value as? [String: AnyObject] else {
                print("cannot get 'response'")
                return
            }
            self.movies = responseAsDictionary["results"] as? [NSDictionary];
            print(self.movies);
            self.tableView.reloadData();
            self.hideActivityIndicator();
        }
    
    }

}
