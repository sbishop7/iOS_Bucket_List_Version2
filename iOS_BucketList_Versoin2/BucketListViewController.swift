//
//  ViewController.swift
//  iOS_BucketList_Versoin2
//
//  Created by Seth Bishop on 7/11/17.
//  Copyright © 2017 Seth Bishop. All rights reserved.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate {
    
//    var items = ["Finish Coding Dojo", "Design a killer iOS app", "Visit Grand Tetons", "Catchup on sleep"]
    
    var items = [BucketListItem]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
        
        
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
        cell.textLabel?.text = items[indexPath.row].text!
        return cell
        
    }
    
    
    //edit feature...
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "editItemSegue", sender: indexPath)
    }
    
    //delete feature...
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        managedObjectContext.delete(item)
        
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        
        items.remove(at: indexPath.row)
        tableView.reloadData()
        
    }
    
    //add button
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "editItemSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (sender == nil) {
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            addItemTableViewController.delegate = self
            
        } else  {
            print ("In edit mode")
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            addItemTableViewController.delegate = self
            
            let indexPath = sender as! NSIndexPath
            let item = items[indexPath.row]
            addItemTableViewController.item = item.text
            addItemTableViewController.indexPath = indexPath
            
        }
    }
    
    func fetchAllItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        do{
            let result = try managedObjectContext.fetch(request)
            items = result as! [BucketListItem]
        } catch {
            print("\(error)")
        }
        
    }
    
    func cancelButtonPressed(by controller: AddItemTableViewController) {
        print("You have hit the cancel button")
        dismiss(animated: true, completion: nil)
        
    }
    
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?) {
        
        if let ip = indexPath {
            print ("updating existing")
            
            let item = items[ip.row]
            item.text = text
        }
        else {
            print ("adding new one")
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
            item.text = text
            items.append(item)
            
        }
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        tableView.reloadData()
        
        dismiss(animated: true, completion: nil)
    }
}

