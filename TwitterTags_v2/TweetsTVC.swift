//
//  TweetsTVC.swift
//  TweeterTags
//
//  Created by 吴昊 on 22/03/2016.
//  Copyright © 2016 haowu. All rights reserved.
//

import UIKit

class TweetsTVC: UITableViewController,UITextFieldDelegate{

    let simpleTableIdentifier = "CuCell"
    let segueIdentifier = "showInfo"
    @IBOutlet weak var twitterQueryTextField: UITextField!{
        didSet {
            twitterQueryTextField.delegate = self
            twitterQueryTextField.text = twitterQueryText
        }
    }

    var tweets = [[Tweet]]()
    var twitterQueryText:String = "#ucd"{
        didSet{
            lastSuccessfulRequest = nil // search for new item
            twitterQueryTextField?.text = twitterQueryText
            tweets.removeAll()
            tableView.reloadData() // clear out the table view
            refresh()
        
        }
    
    }
    
    
    private var lastSuccessfulRequest: TwitterRequest?
    
    private var nextRequestToAttempt: TwitterRequest? {
        guard (lastSuccessfulRequest != nil) else {
            guard (twitterQueryTextField != nil) else {
                return nil
            }
            return TwitterRequest(search: twitterQueryText, count: 8)
        }
        return lastSuccessfulRequest!.requestForNewer
    }
    
    private func refresh(sender: UIRefreshControl?) {
        guard let request = nextRequestToAttempt else {
            sender?.endRefreshing()
            return
        }
        request.fetchTweets { (newTweets) -> Void in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                if newTweets.count > 0 {
                    self.lastSuccessfulRequest = request
                    self.tweets.insert(newTweets, atIndex: 0)
                    self.tableView.reloadData()
                }
                sender?.endRefreshing()
            }
        }
    }
    
    func refresh() {
        refreshControl?.beginRefreshing()
        refresh(refreshControl)
    }
    
    
    override func viewDidLoad() {
        twitterQueryTextField.delegate = self
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.rowHeight = 100
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension

        tableView.delegate = self
        tableView.dataSource = self

        refresh()
    }

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
    twitterQueryText = textField.text!
    twitterQueryTextField.resignFirstResponder()
    return true
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tweets.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets[section].count
    }
  

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let  cell:TweetCell? = tableView.dequeueReusableCellWithIdentifier(simpleTableIdentifier,forIndexPath: indexPath) as? TweetCell
        

//        if (tweets[indexPath.section][indexPath.row].media.count > 0){
//            
//            let url:NSURL = tweets[indexPath.section][indexPath.row].media[0].url
//            let request: NSURLRequest = NSURLRequest(URL: url)
//            NSURLConnection.sendAsynchronousRequest(
//                request, queue: NSOperationQueue.mainQueue(),
//                completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?) -> Void in
//                    if error == nil {
//                        cell?.cellImg.image = UIImage(data: data!)
//                    }
//            })
//        }
        // I always get "HTTP load failed" error when loading images, so here is one solution from internet. After that I noticed the provided solution(modify info.plist) on the bottom of the assignment instruction pdf.....
        
        if (tweets[indexPath.section][indexPath.row].media.count >= 1){
            if let url:NSURL = tweets[indexPath.section][indexPath.row].media[0].url {
                if let data = NSData(contentsOfURL: url) {
                    cell?.cellImg.image = UIImage(data: data)
                }        
            }
        } 
        // set image
        // ##Sometimes it get "HTTP load failed" even if I modified the Info.plist file, which makes me feel that I was still in china, but for the most of time it can load images smoothly.
        
        

        cell?.tweet = tweets[indexPath.section][indexPath.row]
        // set label data
        
//        if(tweets[indexPath.section][indexPath.row].mediaMentions.count >= 1){
//            for mention in tweets[indexPath.section][indexPath.row].mediaMentions{
//                print("####################")
//                print(mention.keyword)
//            }
//        }
        
        
        
        
        return cell!
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == segueIdentifier{
            if let destination =  segue.destinationViewController as? InfoViewVC{
                if let index = self.tableView.indexPathForSelectedRow{
                    destination.tweet = tweets[index.section][index.row]
//                    destination.dataSource[0] =       tweets[index.section][index.row].mediaMentions
//
//
////                    destination.dataSource[0] = tweets[index.section][index.row].
//                    destination.dataSource[1] = tweets[index.section][index.row].urls
                    
                }
            }
        
        
        }
        
    }
    
    
    
    
}
