//
//  PhotoCommentViewController.swift
//  PhotoScroll
//
//  Created by Perry Z Chen on 8/30/16.
//  Copyright © 2016 raywenderlich. All rights reserved.
//

import UIKit

public class PhotoCommentViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var nameTextField: UITextField!
  public var photoName: String!
  
  public var photoIndex: Int!
  
  @IBAction func hideKeyboard(sender: AnyObject) {
    nameTextField.endEditing(true)
  }
  
  @IBAction func openZoomingController(sender: AnyObject) {
    self.performSegueWithIdentifier("zooming", sender: nil)
  }
  
    public override func viewDidLoad() {
        super.viewDidLoad()
      if let photoName = photoName {
        self.imageView.image = UIImage(named: photoName)
      }
      
      NSNotificationCenter.defaultCenter().addObserver(self,
                                                       selector: #selector(PhotoCommentViewController.keyboardWillShow(_:)),
                                                       name: UIKeyboardWillShowNotification,
                                                       object: nil)
      
      NSNotificationCenter.defaultCenter().addObserver(self,
                                                       selector: #selector(PhotoCommentViewController.keyboardWillHide(_:)),
                                                       name: UIKeyboardWillHideNotification,
                                                       object: nil)
        // Do any additional setup after loading the view.
    }
  
  func adjustInsetForKeyboardShow(show: Bool, notification: NSNotification) {
    guard let value = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else { return }
    let keyboardFrame = value.CGRectValue()
    let adjustmentHeight = (CGRectGetHeight(keyboardFrame) + 20) * (show ? 1 : -1)
    scrollView.contentInset.bottom += adjustmentHeight
    scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
  }
  
  func keyboardWillShow(notification: NSNotification) {
    adjustInsetForKeyboardShow(true, notification: notification)
  }
  
  func keyboardWillHide(notification: NSNotification) {
    adjustInsetForKeyboardShow(false, notification: notification)
  }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
      
      if let id = segue.identifier, zoomedPhotoViewController = segue.destinationViewController as? ZoomedPhotoViewController {
        if id == "zooming" {
          zoomedPhotoViewController.photoName = photoName
        }
      }
    }

}
