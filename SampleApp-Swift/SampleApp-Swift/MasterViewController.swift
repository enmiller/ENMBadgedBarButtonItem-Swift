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

        let addButton = UIBarButtonItem(barButtonSystemItem: .rewind,
            target: self,
            action: #selector(MasterViewController.rightButtonPressed(_:)))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func setUpLeftBarButton() {
        let image = UIImage(named: "barbuttonimage")
        let button = UIButton(type: .custom)
        if let knownImage = image {
            button.frame = CGRect(x: 0.0, y: 0.0, width: knownImage.size.width, height: knownImage.size.height)
        } else {
            button.frame = CGRect.zero;
        }
        
        button.setBackgroundImage(image, for: UIControlState())
        button.addTarget(self,
                         action: #selector(MasterViewController.leftButtonPressed(_:)),
                         for: UIControlEvents.touchUpInside)
        
        let newBarButton = ENMBadgedBarButtonItem(customView: button, value: "\(count)")
        leftBarButton = newBarButton
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    func leftButtonPressed(_ sender: UIButton) {
        count = count + 1
        leftBarButton?.badgeValue = "\(count)"
    }
    
    func rightButtonPressed(_ sender: UIButton) {
        count = 0
        leftBarButton?.badgeValue = "0"
    }
}
