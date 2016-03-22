//
//  ViewControllerDetails.swift
//  RSS_Mathias
//
//  Created by Mathias Tjernberg on 2016-03-22.
//  Copyright © 2016 Mathias Tjernberg. All rights reserved.
//

import UIKit

class ViewControllerDetails: UIViewController {
    @IBOutlet weak var pubDateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var linkButton: UIButton!
    
    var rssItem: RSSItem?
    
    override func viewDidLoad() {
        guard let rssItem = rssItem else {
            print("Error: No rss item for details")
            return
        }
        
        descriptionTextView.text = rssItem.description
        pubDateLabel.text = rssItem.pubDate
        linkButton.setTitle(rssItem.link, forState: UIControlState.Normal)
    }
    
    @IBAction func linkTapped(sender: UIButton) {
        if let linkButtonText = sender.titleLabel?.text {
            if let nsurl = NSURL(string: linkButtonText) {
                UIApplication.sharedApplication().openURL(nsurl)
            }
        }
    }
}