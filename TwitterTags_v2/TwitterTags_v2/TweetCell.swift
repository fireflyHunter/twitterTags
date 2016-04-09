//
//  TweetTVCell.swift
//  TweeterTags
//
//  Created by 吴昊 on 23/03/2016.
//  Copyright © 2016 haowu. All rights reserved.
//

import UIKit
class TweetCell: UITableViewCell {
    var tweet: Tweet? {
        didSet {
            updateCell()
        }
    }

    @IBOutlet var tText: UILabel!
    @IBOutlet var tName: UILabel!
    @IBOutlet var cellDate: UILabel!
    @IBOutlet var cellImg: UIImageView!
    
    private func updateCell() {
        
        tText?.attributedText = nil
        tName?.text = nil
        cellDate?.text = nil
        cellImg = nil
        
        // clear cell if no tweet
        guard (tweet != nil) else {
            return
        }
        
        let hashtag = tweet?.hashtags
        let urls = tweet?.urls
        let mentions = tweet?.userMentions
        let attributedString = NSMutableAttributedString(string:tweet!.text)

        for tag in hashtag!{
        let range = (tweet!.text as NSString).rangeOfString(tag.keyword)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blueColor() , range: range)
        }
        for url in urls!{
            let range = (tweet!.text as NSString).rangeOfString(url.keyword)
            attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor() , range: range)
        }
        for mention in mentions!{
            let range = (tweet!.text as NSString).rangeOfString(mention.keyword)
            attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.greenColor() , range: range)
        }
        // coloring main text based on different types of text.
        tText?.attributedText = attributedString
        
        
        tName?.text = "\(tweet!.user)"
        tName.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        // set screen name
        
        let date = "\(tweet?.created)"
//        cellDate?.text = date.substringWithRange(Range<String.Index>(start: date.startIndex.advancedBy(9), end: date.startIndex.advancedBy(25)))
        cellDate?.text = date.substringWithRange(Range<String.Index>(date.startIndex.advancedBy(9)..<date.startIndex.advancedBy(25)))

        // parse date
        
        
    }
}