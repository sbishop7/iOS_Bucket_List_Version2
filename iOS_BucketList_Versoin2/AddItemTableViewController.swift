//
//  AddItemTableViewController.swift
//  iOS_BucketList_Versoin2
//
//  Created by Seth Bishop on 7/11/17.
//  Copyright © 2017 Seth Bishop. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController {
    
    weak var delegate: CancelButtonDelegate?

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by: self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}