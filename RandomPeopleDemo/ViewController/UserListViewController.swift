//
//  UserListViewController.swift
//  RandomPeopleDemo
//
//  Created by Boyko Andrey on 5/28/17.
//  Copyright © 2017 aboiko. All rights reserved.
//

import UIKit
import AlamofireImage
import RealmSwift

class UserListViewController: UITableViewController{
    let userDataProvider = UserDataProvider()
    fileprivate var notificationToken: NotificationToken? = nil
    
    deinit {
        notificationToken?.stop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notificationToken = self.userDataProvider.users.addNotificationBlock{ [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
            default:
                self?.update()
            }

        }
    }
    
    func update() {
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userDataProvider.users.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BasicTableViewCell.className, for: indexPath) as? BasicTableViewCell
        let user = self.userDataProvider.users[indexPath.item]
        cell?.titleLabel?.text = user.firstName
        cell?.imgView?.af_setImage(withURL: user.pictureThumbnail!)
        return cell!
    }
}
