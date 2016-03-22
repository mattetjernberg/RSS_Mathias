//
//  ViewControllerSlideshow.swift
//  RSS_Mathias
//
//  Created by Mathias Tjernberg on 2016-03-22.
//  Copyright © 2016 Mathias Tjernberg. All rights reserved.
//

import UIKit

class ViewControllerSlideshow: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    
    let TIMER_INTERVAL_IN_SECONDS = 3.0
    var rssItems: [RSSItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.pagingEnabled = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let _ = rssItems else {
            print("No rss items for slideshow")
            return
        }
        
        addRSSItems()
        NSTimer.scheduledTimerWithTimeInterval(TIMER_INTERVAL_IN_SECONDS, target: self, selector: "showNextPage", userInfo: nil, repeats: true)
    }
    
    private func addRSSItems() {
        let size = scrollView.frame.size
        for var i = 0; i < rssItems!.count; i++ {
            let x:CGFloat = size.width * CGFloat(i)
            let y:CGFloat = 0
            let rssItem = rssItems![i]
            let view = SlideshowView.loadFromNibNamed() as! SlideshowView
            view.frame = CGRect(x: x, y: y, width: size.width, height: size.height)
            view.titleLabel.text = rssItem.title
            view.pubDateLabel.text = rssItem.pubDate
            view.descriptionTextView.attributedText = rssItem.description.html2AttributedString
            scrollView.addSubview(view)
        }
        
        scrollView.contentSize = CGSize(width: size.width * CGFloat(rssItems!.count), height: size.height)
    }
    
    func showNextPage() {
        let pageWidth:CGFloat = scrollView.frame.width
        let maxWidth:CGFloat = pageWidth * CGFloat(rssItems!.count)
        let contentOffsetX:CGFloat = scrollView.contentOffset.x
        
        var targetX = contentOffsetX + pageWidth
        
        if contentOffsetX + pageWidth >= maxWidth {
            targetX = 0
        }
        
        scrollView.scrollRectToVisible(CGRectMake(targetX, 0, pageWidth, scrollView.frame.height), animated: true)
    }
    
    @IBAction func dismiss() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
