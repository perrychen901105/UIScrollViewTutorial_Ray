//
//  ManagePageViewController.swift
//  PhotoScroll
//
//  Created by Perry Z Chen on 8/30/16.
//  Copyright © 2016 raywenderlich. All rights reserved.
//

import UIKit

class ManagePageViewController: UIPageViewController {

  var photos = ["photo1", "photo2", "photo3", "photo4", "photo5"]
  var currentIndex: Int!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
      
      if let viewController = viewPhotoCommentController(currentIndex ?? 0) {
        let viewContrllers = [viewController]
        // 2
        setViewControllers(viewContrllers, direction: .Forward, animated: false, completion: nil)
      }
      
        // Do any additional setup after loading the view.
    }

  func  viewPhotoCommentController(index: Int) -> PhotoCommentViewController? {
    if let storyboard = storyboard,
      page = storyboard.instantiateViewControllerWithIdentifier("PhotoCommentViewController") as? PhotoCommentViewController {
      page.photoName = photos[index]
      page.photoIndex = index
      return page
    }
    return nil
  }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension ManagePageViewController: UIPageViewControllerDataSource {
  // 1
  func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    if let viewController = viewController as? PhotoCommentViewController {
      var index = viewController.photoIndex
      guard index != NSNotFound && index != 0 else { return nil }
      index = index - 1
      return viewPhotoCommentController(index)
    }
    return nil
  }
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    if let viewController = viewController as? PhotoCommentViewController {
      var index = viewController.photoIndex
      guard index != NSNotFound else { return nil }
      index = index + 1
      guard index != photos.count else { return nil }
      return viewPhotoCommentController(index)
    }
    return nil
  }
  
  func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
    return photos.count
  }
  
  func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
    return currentIndex ?? 0
  }
}

