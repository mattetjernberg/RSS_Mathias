//
//  ViewController.swift
//  RSS_Mathias
//
//  Created by Mathias Tjernberg on 2016-03-22.
//  Copyright © 2016 Mathias Tjernberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate {
    
    @IBOutlet weak var tableView:UITableView!
    
    let RSS_URL: String = "http://www.dn.se/nyheter/m/rss/"
    var parser: NSXMLParser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func parseRSS() {
        
        guard let nsurl = NSURL(string: RSS_URL) else {
            print("Could not create a nsurl")
            return
        }
        
        parser = NSXMLParser(contentsOfURL: nsurl)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}

