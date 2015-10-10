//
//  testViewController.swift
//  Instagram-clone
//
//  Created by William Peregoy on 2015/10/10.
//  Copyright © 2015年 Parse. All rights reserved.
//

import UIKit
import Parse

class testViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if PFUser.currentUser()?.objectId != nil {
        
            print(PFUser.currentUser()?.objectId)
            
        } else {
            
            print("nil")
        }
        

        // Do any additional setup after loading the view.
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
