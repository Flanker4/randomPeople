//
//  ViewController.swift
//  RandomPeopleDemo
//
//  Created by Boyko Andrey on 5/27/17.
//  Copyright © 2017 aboiko. All rights reserved.
//

import UIKit

final class UserDetailsViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!

    var detailViewModel: UserDetailViewModel? {
        didSet {
            if (self.isViewLoaded) {
                self.update()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.update()
    }

    func update() {
        self.title = self.detailViewModel?.fullName;
        
        self.nameLabel.text = self.detailViewModel?.fullName
        self.genderLabel.text = self.detailViewModel?.gender
        self.emailLabel.text = self.detailViewModel?.email
        if let url = self.detailViewModel?.imageURL {
            self.avatarImage.af_setImage(withURL: url)
        }
    }


}

