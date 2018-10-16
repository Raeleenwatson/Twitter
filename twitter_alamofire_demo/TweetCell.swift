//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Raeleen Watson on 10/8/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AFNetworking
import ActiveLabel

class TweetCell: UITableViewCell {

    
    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoritedLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var tweet: Tweet! {
        didSet {
            //set outlets equal to stuff 
            refreshData()
        }
    }
    
    
    @IBAction func didTapFavorite(_ sender: Any) {
    //print("bad")
        if(tweet.favorited == false){
            tweet.favorited = true
            tweet.favoriteCount += 1
            refreshData()
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("bad2")
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
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
                
            }
        }
        
    }
    
    
    @IBAction func didTapRetweet(_ sender: Any) {
        
        if(tweet.retweeted == false){
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
    
    func refreshData() {
        
        tweetTextLabel.text = tweet.text
        usernameLabel.text = tweet.user!.name
        screenNameLabel.text = tweet.user!.screenName
        createdAtLabel.text = tweet.createdAt
        retweetLabel.text = String(tweet.retweetCount)
        favoritedLabel.text = String(tweet.favoriteCount)
        tweetImageView.image = nil
        
        
        if(tweet.favorited)!{
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
        }
        if(tweet.favorited == false){
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
        }
        if(tweet.retweeted)!{
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
        }
        if(tweet.retweeted==false){
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
        }

        let profileImage = NSURL(string: tweet.user!.profileImage!)
        tweetImageView.setImageWith(profileImage! as URL)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
