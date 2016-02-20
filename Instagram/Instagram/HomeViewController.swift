//
//  HomeViewController.swift
//  Instagram
//
//  Created by Chun Kwok on 2/16/16.
//  Copyright © 2016 Chun Kwok. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var mediaArr: [PFObject]?
    var refreshControl:UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 220.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        let query = PFQuery(className: "UserMedia")
        query.orderByDescending("_created_at")
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if media != nil {
                self.mediaArr = media
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mediaArr != nil {
            return mediaArr!.count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("InstaCell", forIndexPath: indexPath) as! InstaCell
        let media = mediaArr![indexPath.row]
        cell.capLabel.text = media["caption"] as? String
        let userImageFile = media["media"] as! PFFile
        userImageFile.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    cell.picImageView.image = image
                }
            }
        }
        
            
        return cell
    }

    func refresh(sender: AnyObject) {
        let query = PFQuery(className: "UserMedia")
        query.orderByDescending("_created_at")
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if media != nil {
                self.mediaArr = media
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
        self.refreshControl.endRefreshing()
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
