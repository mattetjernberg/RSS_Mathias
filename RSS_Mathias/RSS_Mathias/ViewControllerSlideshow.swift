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
    var rssItems: [RSSItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.pagingEnabled = true
        addRSSItems()
    }
    
    private func addRSSItems() {
        guard let rssItems = rssItems else {
            print("No rss items to for slideshow")
            return
        }
        
        let size = view.frame.size
        for var i = 0; i < rssItems.count; i++ {
            let x:CGFloat = size.width * CGFloat(i)
            let y:CGFloat = 0
            let view = SlideshowView(frame: CGRect(x: x, y: y, width: size.width, height: size.height))
            view.backgroundColor = UIColor.orangeColor()
            view.rssItem = rssItems[i]
            scrollView.addSubview(view)
        }
        
        scrollView.contentSize = CGSize(width: size.width * CGFloat(rssItems.count), height: size.height)
    }
    
    private func addRSSItemView() {
        
    }
    
    @IBAction func dismiss() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
