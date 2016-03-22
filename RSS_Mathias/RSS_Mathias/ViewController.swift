//
//  ViewController.swift
//  RSS_Mathias
//
//  Created by Mathias Tjernberg on 2016-03-22.
//  Copyright © 2016 Mathias Tjernberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    let RSS_URL: String = "http://www.dn.se/nyheter/m/rss/"
    var parser: NSXMLParser!
    var rssItems: [RSSItem] = [RSSItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if rssItems.isEmpty {
            loadRSS()
        }
    }
    
    private func loadRSS() {
        
        guard let nsurl = NSURL(string: RSS_URL) else {
            print("Could not create a nsurl")
            return
        }
        
        activity.startAnimating()
        
        parser = NSXMLParser(contentsOfURL: nsurl)
        parser.delegate = self
        parser.parse()
    }
    
    // MARK: NSXML
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        print("ELEMENT NAME: \(elementName)")
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        activity.stopAnimating()
        tableView.reloadData()
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        activity.stopAnimating()
        print("Parse error occured with error: \(parseError)")
    }
    
    // MARK: Tableview
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

