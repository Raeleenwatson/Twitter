//
//  DetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Raeleen Watson on 10/10/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import ActiveLabel

class DetailViewController: UIViewController {
    
    var tweet: Tweet!
    

    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailUserNameLabel: UILabel!
    @IBOutlet weak var detailCreatedAt: UILabel!
    @IBOutlet weak var detailTweetLabel: ActiveLabel!
    @IBOutlet weak var detailScreenName: UILabel!
    
    
    @IBOutlet weak var detailReplyButton: UIButton!
    @IBOutlet weak var detailFavoriteButton: UIButton!
    @IBOutlet weak var detailRetweetButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshData()
        if let tweet = tweet {
            let profileImage = NSURL(string: (tweet.user?.profileImage!)!)
            detailImageView.setImageWith(profileImage! as URL)
            detailUserNameLabel.text = tweet.user?.name
            detailScreenName.text = tweet.user?.screenName
            detailTweetLabel.text = tweet.text
            detailCreatedAt.text = tweet.createdAt
            
        }
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func onReply(_ sender: Any) {
    }
    
    
    @IBAction func onRetweet(_ sender: Any) {
        if(tweet?.retweeted == false){
        tweet.retweeted = true
        tweet.retweetCount += 1
        refreshData()
        APIManager.shared.retweet(with: tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error Retweeting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully Retweeted the following Tweet: \n\(tweet.text)")
            }
        }
    }
    else{
        tweet.retweeted = false
        tweet.retweetCount -= 1
        refreshData()
            APIManager.shared.undoRetweet(with: tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error Unretweeting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully Unretweeted the following Tweet: \n\(tweet.text)")
            }
        }
        
        }
    }
    
    
    @IBAction func onFavorite(_ sender: Any) {
        if(tweet.favorited == false){
            tweet.favorited = true
            tweet.favoriteCount += 1
            refreshData()
            APIManager.shared.favorite( tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
        else{
            tweet.favorited = false
            tweet.favoriteCount -= 1
            refreshData()
            APIManager.shared.unfavorite(with: tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
                
            }
        }
    }
    
    

    func refreshData() {
     
        if(tweet.favorited)! {
            detailFavoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
        }
        if(tweet.favorited == false){
            detailFavoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
        }
        if(tweet.retweeted)! {
            detailRetweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
        }
        if(tweet.retweeted==false){
            detailRetweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let replyViewController = segue.destination as! ReplyViewController
        replyViewController.tweet = tweet
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
