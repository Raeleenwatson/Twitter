//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Raeleen Watson on 10/16/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileUsername: UILabel!
    @IBOutlet weak var profileScreenName: UILabel!
    @IBOutlet weak var profileFollowing: UILabel!
    @IBOutlet weak var profileFollowers: UILabel!
    @IBOutlet weak var profileTweets: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        APIManager.shared.getCurrentAccount { (user: User?, error: Error?)   in
            
            if let error = error {
                print("Error getting user: " + error.localizedDescription)
            }
            else if let user = user {
                
                self.profileImageView.af_setImage(withURL: user.profileImageUrl)
                
                self.profileUsername.text = user.name
                //print(profileUsername.text)
                self.profileScreenName.text = "@" + (user.screenName)
                self.profileFollowers.text = (user.followersCount) + " Followers"
                self.profileFollowing.text = (user.friendsCount) + " Following"
                self.profileTweets.text = (user.statusCount) + " Statuses"
            }
    
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapProfileCanel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    
    

}
