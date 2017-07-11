//
//  AddItemTableViewControllerDelegate.swift
//  iOS_BucketList_Versoin2
//
//  Created by Seth Bishop on 7/11/17.
//  Copyright © 2017 Seth Bishop. All rights reserved.
//

import Foundation

protocol AddItemTableViewControllerDelegate: class {
    
    func itemSaved(by controller: AddItemTableViewController, with text: String)
    func cancelButtonPressed(by controller: AddItemTableViewController)
    
}
