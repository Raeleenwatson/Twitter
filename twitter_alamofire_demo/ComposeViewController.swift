//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Raeleen Watson on 10/14/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AFNetworking
import AlamofireImage

protocol ComposeViewControllerDelegate: NSObjectProtocol {
    func did(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate {

    weak var delegate: ComposeViewControllerDelegate?
    
    @IBOutlet weak var composeCancelButton: UIBarButtonItem!
    @IBOutlet weak var composeImageView: UIImageView!
    @IBOutlet weak var composeCharCount: UILabel!
    @IBOutlet weak var composeTweetButton: UIButton!
    
    @IBOutlet weak var composeTweetField: UITextView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        composeTweetField.delegate = self
        let profileImage = URL(string: (User.current?.profileImage)!)
        composeImageView.af_setImage(withURL: profileImage!)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTweet(_ sender: Any) {
        APIManager.shared.composeTweet(with: composeTweetField.text!) { (tweet, error) in
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        composeTweetField.text = ""
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // TODO: Check the proposed new text character count
        // Allow or disallow the new text
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        // TODO: Update Character Count Label
        composeCharCount.text = String(140 - newText.characters.count)
        
        // The new text should be allowed? True/False
        return newText.characters.count < characterLimit
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
