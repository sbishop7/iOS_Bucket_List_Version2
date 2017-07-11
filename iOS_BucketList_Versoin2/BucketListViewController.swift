//
//  ViewController.swift
//  iOS_BucketList_Versoin2
//
//  Created by Seth Bishop on 7/11/17.
//  Copyright © 2017 Seth Bishop. All rights reserved.
//

import UIKit

class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate {
    
    var items = ["Finish Coding Dojo", "Design a killer iOS app", "Visit Grand Tetons", "Catchup on sleep"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
        
        addItemTableViewController.delegate = self
    }
    
    func cancelButtonPressed(by controller: AddItemTableViewController) {
        print("You have hit the cancel button")
        dismiss(animated: true, completion: nil)
        
    }
    
    func itemSaved(by controller: AddItemTableViewController, with text: String) {
        print("recieved: \(text)")
        items.append(text)
        tableView.reloadData()
        
        dismiss(animated: true, completion: nil)
    }
}

