//
//  DetailViewController.swift
//  ENMBadgedBarButton
//
//  Created by Eric Miller on 6/2/14.
//  Copyright (c) 2014 Tiny Zepplin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBOutlet var detailDescriptionLabel: UILabel?


    var detailItem: AnyObject? {
        didSet {
            self.configureView()
        }
    }

    func configureView() {
        if let detail: AnyObject = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

}

