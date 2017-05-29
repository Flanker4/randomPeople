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
    var dataProvider: UserDataProvider? = nil
    
    fileprivate var notificationToken: NotificationToken? = nil
    
    deinit {
        notificationToken?.stop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notificationToken = self.dataProvider?.items.value?.addNotificationBlock{ [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .error(let error):
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
        guard let items = self.dataProvider?.items.value else {
            return 0
        }
        return items.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BasicTableViewCell.className, for: indexPath) as? BasicTableViewCell
        guard let items = self.dataProvider?.items.value else {
            return cell!
        }
        
        let user = items[indexPath.item]
        cell?.titleLabel?.text = user.firstName
        cell?.imgView?.af_setImage(withURL: (user.pictureThumbnail)!)
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //TODO: use router
        guard let userDetailViewController = segue.destination as? UserDetailsViewController,
            let cell = sender as? BasicTableViewCell,
            let indexPath = tableView.indexPath(for: cell) else
        {
            return
        }
        userDetailViewController.userId = self.dataProvider?.items.value?[indexPath.row].objectId
    }
}
