//
//  MasterViewController.swift
//  ENMBadgedBarButton
//
//  Created by Eric Miller on 6/2/14.
//  Copyright (c) 2014 Tiny Zepplin. All rights reserved.
//

import UIKit
import class BadgedBarButtonItem.BadgedBarButtonItem

class MasterViewController: UITableViewController {
    
    var objects = NSMutableArray()
    
    @IBOutlet fileprivate var rightBarButton: BadgedBarButtonItem!
    
    fileprivate(set) var leftBarButton: BadgedBarButtonItem?
    fileprivate var leftCount = 0
    fileprivate var rightCount = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        title = "My Table"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLeftBarButton()
    }
    
    func setUpLeftBarButton() {
        let image = UIImage(imageLiteralResourceName: "barbuttonimage")
        let buttonFrame: CGRect = CGRect(x: 0.0, y: 0.0, width: image.size.width, height: image.size.height)
        let barButton = BadgedBarButtonItem(
            startingBadgeValue: "\(leftCount)",
            frame: buttonFrame,
            image: image
        )
        
        leftBarButton = barButton
        leftBarButton?.addTarget(self, action: #selector(leftBarButtonTapped(_:)))
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @IBAction func leftBarButtonTapped(_ sender: BadgedBarButtonItem) {
        leftCount = leftCount + 1
        sender.badgeValue = "\(leftCount)"
    }
    
    @IBAction func rightBarButtonTapped(_ sender: BadgedBarButtonItem) {
        rightCount = rightCount + 1
        sender.badgeValue = "\(rightCount)"
    }
    
    @IBAction func reset(_ sender: UIBarButtonItem) {
        rightCount = 0
        leftCount = 0
        leftBarButton?.badgeValue = "\(leftCount)"
        rightBarButton.badgeValue = "\(rightCount)"
    }
}
