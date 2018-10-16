//
//  ReplyViewController.swift
//  twitter_alamofire_demo
//
//  Created by Raeleen Watson on 10/14/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

protocol ReplyViewControllerDelegate: NSObjectProtocol {
    func did(post: Tweet)
}

class ReplyViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var tweetTextField: UITextView!
    @IBOutlet weak var sendTweetButton: UIButton!
    @IBOutlet weak var charCount: UILabel!
    
    weak var delegate: ReplyViewControllerDelegate?
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTextField.delegate = self


        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendTweet(_ sender: Any) {
        let replyText = tweetTextField.text
        APIManager.shared.replyTweet(with: replyText!, with: String(tweet.id)){(tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
                self.dismiss(animated: true, completion: nil)
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
                 self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // TODO: Check the proposed new text character count
        // Allow or disallow the new text
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        // TODO: Update Character Count Label
        charCount.text = String(140 - newText.characters.count)
        
        // The new text should be allowed? True/False
        return newText.characters.count < characterLimit
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        tweetTextField.text = "@" + String(tweet.user!.screenName) + " "
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
