//
//  MasterViewController.swift
//  TestBadge-Swift
//
//  Created by Eric Miller on 6/2/14.
//  Copyright (c) 2014 Yogurt Salad. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var objects = NSMutableArray()
    var leftBarButton: ENMBadgedBarButtonItem = ENMBadgedBarButtonItem()

    override func awakeFromNib() {
        super.awakeFromNib()
        title = "My Table"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLeftBarButton()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Rewind,
            target: self,
            action: "rightButtonPressed:")
        navigationItem.rightBarButtonItem = addButton
    }
    
    func setUpLeftBarButton() {
        var image = UIImage(named: "barbuttonimage")
        var button = UIButton.buttonWithType(.Custom) as UIButton
        button.frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height)
        button.setBackgroundImage(image, forState: UIControlState.Normal)
        button.addTarget(self,
            action: "leftButtonPressed:",
            forControlEvents: UIControlEvents.TouchUpInside)
        
        var newBarButton = ENMBadgedBarButtonItem(customView: button, value: "0")
        leftBarButton = newBarButton
        navigationItem.leftBarButtonItem = leftBarButton
    }

    var count = 0
    func leftButtonPressed(_sender: UIButton) {
        count++
        leftBarButton.badgeValue = "\(count)"
    }
    
    func rightButtonPressed(_sender: UIButton) {
        count = 0
        leftBarButton.badgeValue = "0"
    }
}

