//
//  MasterViewController.swift
//  TestBadge-Swift
//
//  Created by Eric Miller on 6/2/14.
//  Copyright (c) 2014 Xero. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var objects = NSMutableArray()
    var leftBarButton: ENMBadgedBarButtonItem?
    var count = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        title = "My Table"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLeftBarButton()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Rewind,
            target: self,
            action: #selector(MasterViewController.rightButtonPressed(_:)))
        navigationItem.rightBarButtonItem = addButton
    }
}

extension MasterViewController {
    
    func setUpLeftBarButton() {
        let image = UIImage(named: "barbuttonimage")
        let button = UIButton(type: .Custom)
        if let knownImage = image {
            button.frame = CGRectMake(0.0, 0.0, knownImage.size.width, knownImage.size.height)
        } else {
            button.frame = CGRectZero;
        }
        
        button.setBackgroundImage(image, forState: UIControlState.Normal)
        button.addTarget(self,
            action: #selector(MasterViewController.leftButtonPressed(_:)),
            forControlEvents: UIControlEvents.TouchUpInside)
        
        let newBarButton = ENMBadgedBarButtonItem(customView: button, value: "\(count)")
        leftBarButton = newBarButton
        navigationItem.leftBarButtonItem = leftBarButton
    }
}

extension MasterViewController {
    
    func leftButtonPressed(_sender: UIButton) {
        count = count + 1
        leftBarButton?.badgeValue = "\(count)"
    }
    
    func rightButtonPressed(_sender: UIButton) {
        count = 0
        leftBarButton?.badgeValue = "0"
    }
}
