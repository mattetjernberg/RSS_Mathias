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
    let VALID_TAGS: [String] = ["title", "link", "description", "pubDate", "guid"]
    var parser: NSXMLParser!
    var rssItems: [RSSItem] = [RSSItem]()
    var rssItem: RSSItem?
    var tagsFound: [String: Bool] = [String: Bool]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(14.0)]
        
        activity.hidesWhenStopped = true
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if rssItems.isEmpty {
            loadRSS()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "details" {
            print(tableView.indexPathForSelectedRow)
            guard let selectedIndexPath = tableView.indexPathForSelectedRow else {
                print("Error: selected indexpath is nil")
                return
            }
            
            tableView.deselectRowAtIndexPath(selectedIndexPath, animated: true)
            
            let detailsViewController = segue.destinationViewController as! ViewControllerDetails
            let rssItem = rssItems[selectedIndexPath.row]
            detailsViewController.title = rssItem.title
            detailsViewController.rssItem = rssItem
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
    
    private func isValidTag(tag: String) -> Bool {
        return VALID_TAGS.contains(tag)
    }
    
    // MARK: NSXML
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        //print("ELEMENT NAME: \(elementName)")
        
        switch elementName {
            case "item":
                rssItem = RSSItem()
            break
            case "title", "link", "description", "pubDate", "guid":
                tagsFound[elementName] = true
            break
            default: break
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if tagsFound["title"] == true {
            rssItem?.title += string
        } else if tagsFound["link"] == true {
            rssItem?.link += string
        } else if tagsFound["description"] == true {
            rssItem?.description += string
        } else if tagsFound["pubDate"] == true {
            rssItem?.pubDate += string
        } else if tagsFound["guid"] == true {
            rssItem?.guid += string
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName {
            case "item":
                if let item = rssItem {
                    rssItems.append(item)
                } else {
                    print("Error: rssItems was never created, can't append item")
                }
            break
            case "title", "link", "description", "pubDate", "guid":
                tagsFound[elementName] = false
            break
            default: break
        }
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
        return rssItems.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RSSCell", forIndexPath: indexPath)
        cell.textLabel?.font = UIFont.systemFontOfSize(12.0)
        let rssItem = rssItems[indexPath.row]
        cell.textLabel?.text = rssItem.title
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("details", sender: self)
    }

}

