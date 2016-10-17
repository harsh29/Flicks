//
//  DetailViewController.swift
//  Flicks
//
//  Created by Harsh Trivedi on 10/17/16.
//  Copyright © 2016 Harsh Trivedi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailViewPosterImage: UIImageView!
    
    @IBOutlet weak var detailViewTitleLabel: UILabel!
    
    @IBOutlet weak var detailViewOverviewLabel: UILabel!
    
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet weak var detailViewScrollView: UIScrollView!
    var movie: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailViewScrollView.contentSize = CGSize(width: detailViewScrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.height);
        
        let title = movie["title"] as? String
        let overview = movie["overview"] as? String
        
       
        detailViewTitleLabel.text = title;
        detailViewOverviewLabel.text = overview;
        detailViewOverviewLabel.sizeToFit();
        
        let baseURL = "https://image.tmdb.org/t/p/w500";
        if let posterPath = movie["poster_path"] as? String{
            let imageURL = NSURL(string: baseURL + posterPath);
            detailViewPosterImage.setImageWith(imageURL! as URL);
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
