//
//  TableViewController.swift
//  Project 4 R2
//
//  Created by Navid on 1/1/22.
//

import UIKit

class TableViewController: UITableViewController {

    var webSites = ["google.com","hackingwithswift.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewController.webSites = self.webSites
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return webSites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = webSites[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "WebView") as? ViewController else {return}
        vc.pageToLoad = URL(string: "Https://" + webSites[indexPath.row])
        print("ok")
        navigationController?.pushViewController(vc, animated: true)
        
    }

}
