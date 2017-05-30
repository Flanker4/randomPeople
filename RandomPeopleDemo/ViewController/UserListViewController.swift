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

final class UserListViewController: UITableViewController {
    var dataProvider: UserDataProvider? = nil

    fileprivate var isRefreshing = false {
        didSet {
            if isRefreshing {
                self.tableView.bottomRefreshControl?.beginRefreshing()
            } else {
                self.tableView.bottomRefreshControl?.endRefreshing()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Friend List", comment: "")
        self.setUpDataProvider()
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
        cell?.cellViewModel = user.basicTableViewCellModel()
        return cell!
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //TODO: use router
        guard let userDetailViewController = segue.destination as? UserDetailsViewController,
              let cell = sender as? BasicTableViewCell,
              let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        userDetailViewController.detailViewModel = self.dataProvider?.items.value?[indexPath.row].userDetailViewModel()
    }

    func presentError(error: Error){
        //TODO: handle error
    }
}

extension UserListViewController {
    func setUpRefreshController() {
        if self.tableView.bottomRefreshControl != nil {
            return
        }
        let refreshControl = UIRefreshControl()
        refreshControl.triggerVerticalOffset = 50;
        refreshControl.addTarget(self, action: #selector(UserListViewController.handleRefresh(sender:)), for: .valueChanged)
        self.tableView.bottomRefreshControl = refreshControl;
    }

    func handleRefresh(sender: UIRefreshControl) {
        self.loadNextPage()
    }
}

///Data provider

extension UserListViewController {
    func loadNextPage() {
        if self.isRefreshing {
            return
        }
        self.isRefreshing = true
        self.dataProvider?.getUsers(handler: { [weak self] (result) in
            self?.isRefreshing = false
            //TODO: add error handler
        })

    }

    func setUpDataProvider() {
        self.dataProvider?.changeNotificationBlock = { [weak self] result in
            if let error = result.error{
                self?.presentError(error: error)
            }
            self?.update()
        }

        if self.dataProvider?.items.value?.count == 0 {
            self.loadNextPage()
        }
    }
}
