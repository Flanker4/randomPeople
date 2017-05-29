//
//  UserListViewController.swift
//  RandomPeopleDemo
//
//  Created by Boyko Andrey on 5/28/17.
//  Copyright © 2017 aboiko. All rights reserved.
//

import UIKit
import AlamofireImage
import CCBottomRefreshControl
class UserListViewController: UITableViewController{
    var dataProvider: UserDataProvider? = nil
    fileprivate var isRefreshing = false
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataProvider?.changeNotificationBlock = { [weak self] result in
            switch result {
            case .success(_):
                self?.update()
            case .failure(let error):
                print(error)
            }
            self?.tableView.bottomRefreshControl?.endRefreshing()
            self?.isRefreshing = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        self.setUpRefreshController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        self.tableView.bottomRefreshControl = nil
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
    
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        guard let items = self.dataProvider?.items.value else {
//            return
//        }
//        if (items.count - 1 == indexPath.item) {
//            self.refreshControl?.beginRefreshing()
//            
//        }
//    }
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


extension UserListViewController{
    func setUpRefreshController() {
        if self.tableView.bottomRefreshControl != nil  {
            return
        }
        let refreshControl = UIRefreshControl()
        refreshControl.triggerVerticalOffset = 50;
        refreshControl.addTarget(self, action: #selector(UserListViewController.handleRefresh(sender:)), for: .valueChanged)
        self.tableView.bottomRefreshControl = refreshControl;
    }
    
    func handleRefresh(sender:UIRefreshControl) {
        if self.isRefreshing {
            return
        }
        self.isRefreshing = true
        self.dataProvider?.getUsers()
    }
}
