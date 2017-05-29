//
//  ViewController.swift
//  RandomPeopleDemo
//
//  Created by Boyko Andrey on 5/27/17.
//  Copyright © 2017 aboiko. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {
    public var userId: String?
    var dataProvider: UserDataProvider?
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let user = self.dataProvider?.item(id: self.userId!).value else {
            return
        }
        self.nameLabel.text = user.firstName
        self.genderLabel.text = user.gender.rawValue.capitalized
        self.emailLabel.text = user.email
        self.avatarImage.af_setImage(withURL: user.pictureLarge!)
        
        // Do any additional setup after loading the view, typically from a nib.
    }



}

