//
//  PlayVideoViewController.swift
//  AVFoundationDemo
//
//  Created by Andy (Liang) Dong on 9/27/15.
//  Copyright © 2015 codepath. All rights reserved.
//

import UIKit
import MediaPlayer
import MobileCoreServices
import AVKit

class PlayVideoViewController: UIViewController {

    @IBOutlet weak var browseImageView: UIImageView!
    
    let mediaUI = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mediaUI.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func startMediaBrowserFromViewController(viewController: UIViewController, usingDelegate delegate: protocol<UINavigationControllerDelegate, UIImagePickerControllerDelegate>) -> Bool {
        // 1
        if UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum) == false {
            return false
        }
        
        // 2
        mediaUI.sourceType = .SavedPhotosAlbum
        mediaUI.mediaTypes = [kUTTypeMovie as String]
        mediaUI.allowsEditing = true
        mediaUI.delegate = delegate
        
        // 3
        presentViewController(mediaUI, animated: true, completion: nil)
        return true
    }
    
    

    @IBAction func onPlayVideoButton(sender: UIButton) {
        startMediaBrowserFromViewController(self, usingDelegate: self)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


// MARK: - UIImagePickerControllerDelegate
extension PlayVideoViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            browseImageView.contentMode = .ScaleAspectFit
//            browseImageView.image = pickedImage
//            dismissViewControllerAnimated(true, completion: nil)
//        }
        
        // 1
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        // 2
        dismissViewControllerAnimated(true) {
            // 3
            if mediaType == kUTTypeMovie {
//                let moviePlayer = MPMoviePlayerViewController(contentURL: info[UIImagePickerControllerMediaURL] as! NSURL)
//                self.presentMoviePlayerViewControllerAnimated(moviePlayer)
                let player = AVPlayer(URL: info["UIImagePickerControllerMediaURL"] as! NSURL)
                let playerController = AVPlayerViewController()
                
                playerController.player = player
                self.addChildViewController(playerController)
                self.view.addSubview(playerController.view)
                playerController.view.frame = self.view.frame
                
                player.play()
     
            }
        }
    }

}


// MARK: - UINavigationControllerDelegate
extension PlayVideoViewController: UINavigationControllerDelegate {
}