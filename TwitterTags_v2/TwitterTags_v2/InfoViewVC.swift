//
//  InfoViewVC.swift
//  TwitterTags_v2
//
//  Created by 吴昊 on 25/03/2016.
//  Copyright © 2016 haowu. All rights reserved.
//

import UIKit

class InfoViewVC: UITableViewController {
    var tweet: Tweet?
    let cellIdentifier = "infoCell"
    let sectionArray = ["Images","URLs","Hashtags","Users"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.sectionArray.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section{
        case 0:
            return (tweet?.media.count)!
        case 1:
            return (tweet?.urls.count)!
        case 2:
            return (tweet?.hashtags.count)!
        case 3:
            return (tweet?.userMentions.count)!
        default:
            return 0
        }
        
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionArray[section]
       
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier,forIndexPath: indexPath) as! infoCell
        
            
//        if indexPath.section == 0 {
//        cell.textLabel?.text = "aaaaaaa"}
        
//        if (tweets[indexPath.section][indexPath.row].media.count >= 1){
//            if let url:NSURL = tweets[indexPath.section][indexPath.row].media[0].url {
//                if let data = NSData(contentsOfURL: url) {
//                    cell?.cellImg.image = UIImage(data: data)
//                }
//            }
//        }
        switch indexPath.section{
        case 0:
            if let URL:NSURL = tweet?.media[indexPath.row].url{
                if let data = NSData(contentsOfFile: "\(URL)"){
                    cell.img.image = UIImage(data: data)
                    
                }
            }
        case 1:
            cell.textLabel?.text = tweet!.urls[indexPath.row].keyword
        case 2:
            cell.textLabel?.text = tweet!.hashtags[indexPath.row].keyword
        case 3:
            cell.textLabel?.text = tweet!.userMentions[indexPath.row].keyword


        default:
            break
        }
        
        
        
        
        return cell
        
        
        
    }



}
