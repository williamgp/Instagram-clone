//
//  TableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by William Peregoy on 2015/9/18.
//  Copyright © 2015年 Parse. All rights reserved.
//

import UIKit
import Parse

class TableViewController: UITableViewController {
    
    @IBAction func logOut(sender: AnyObject) {
        
        PFUser.logOut()
        
    }
    var usernames = [""]
    var userids = [""]
    var sortedNames = [""]
    var isFollowing = ["": false]
    
    var refresher: UIRefreshControl!
    
    func refresh() {
        
        var query = PFUser.query()
        
        query?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            
            if let users = objects {
                
                self.usernames.removeAll(keepCapacity: true)
                self.userids.removeAll(keepCapacity: true)
                self.isFollowing.removeAll(keepCapacity: true)
                
                for object in users {
                    
                    if let user = object as? PFUser {
                        
                        if user.objectId! != PFUser.currentUser()?.objectId {
                            
                            self.usernames.append(user.username!)
                            self.userids.append(user.objectId!)
                            
                            var query = PFQuery(className: "followers")
                            
                            query.whereKey("follower", equalTo: (PFUser.currentUser()?.objectId!)!)
                            query.whereKey("following", equalTo: user.objectId!)
                            
                            query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                                
                                if let objects = objects {
                                    
                                    if objects.count > 0 {
                                        
                                        self.isFollowing[user.objectId!] = true
                                        
                                    } else {
                                        
                                        self.isFollowing[user.objectId!] = false
                                    }
                                    
                                }
                                
                                if self.isFollowing.count == self.usernames.count {
                                    
                                    self.tableView.reloadData()
                                    
                                    self.refresher.endRefreshing()

                                    
                                }
                                
                            })
                        }
                    }
                }
            }
            
            //self.sortedNames = self.usernames.sort(){ $0.localizedCaseInsensitiveCompare($1) == NSComparisonResult.OrderedAscending }
            
            

        })
     }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        refresher = UIRefreshControl()
        
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        
        self.tableView.addSubview(refresher)
        
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usernames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        cell.textLabel?.text = usernames[indexPath.row]
        
        let followedObjectId = userids[indexPath.row]

        if isFollowing[followedObjectId] == true {
            
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            
        }
        
        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!

        let followedObjectId = userids[indexPath.row]

        
        if isFollowing[followedObjectId] == false {
            
            isFollowing[followedObjectId] = true
        
        
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        
            var following = PFObject(className: "followers")
            following["following"] = userids[indexPath.row]
            following["follower"] = PFUser.currentUser()?.objectId
        
        
            following.saveInBackground()
            
        } else {
            
            isFollowing[followedObjectId] = false
            
            cell.accessoryType = UITableViewCellAccessoryType.None
            
            var query = PFQuery(className: "followers")
            
            query.whereKey("follower", equalTo: (PFUser.currentUser()?.objectId!)!)
            query.whereKey("following", equalTo: userids[indexPath.row])
            
            query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                
                if let objects = objects {
                    
                    for object in objects {
                        
                        object.deleteInBackground()
                    }
                }
                
                if self.isFollowing.count == self.usernames.count {
                    
                    self.tableView.reloadData()
                    
                }
                
            })
        }

        
    
        }
    
    }

