//
//  UserTableViewCell.swift
//  RandomPeopleDemo
//
//  Created by Boyko Andrey on 5/28/17.
//  Copyright © 2017 aboiko. All rights reserved.
//

import UIKit

class BasicTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    var cellViewModel: BasicTableViewCellModel? {
        didSet {
            self.titleLabel?.text = cellViewModel?.title
            if let url = cellViewModel?.imageURL {
                self.imgView?.af_setImage(withURL: url)
            } else {
                self.imgView?.image = nil
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.imgView.image = nil
    }
}
