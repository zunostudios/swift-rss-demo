//
//  MasterViewController.swift
//  SwiftDemo
//
//  Created by David Nuon on 8/8/14.
//  Copyright (c) 2014 David Nuon. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    var objects : [RSSParserDelegate.BlogPost] = [];

    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.reloadData();
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let url = NSURL(string: "http://feeds.feedburner.com/zunostudios/GzuP")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in

            let parsed  = NSXMLParser(data:data);
            let del = RSSParserDelegate();
            parsed.delegate = del;
            parsed.parse();
            
            dispatch_async(dispatch_get_main_queue(), {
                for post in del.posts {
                    self.objects.append(post);
                    self.tableView.reloadData();
                }
                self.tableView.reloadData()
            })
            
            println("Reloading");
        }
        
        task.resume();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let indexPath = self.tableView.indexPathForSelectedRow()
            let object = objects[indexPath.row]
            (segue.destinationViewController as DetailViewController).detailItem = object
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        let blogPost = objects[indexPath.row];
        cell.textLabel.text = blogPost.title
        cell.detailTextLabel.text = blogPost.author
        println(blogPost.title);
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


}

