//
//  DeliveryListViewController.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/6/19.
//

import SnapKit
import UIKit

class DeliveryListViewController: UIViewController {
    var tableView: UITableView!
    let refreshControl = UIRefreshControl()
    var presenter: DeliveryListPresenterProtocol?
    var deliveries: [DeliveryModel] = []
    
    var isLoading: Bool = false {
        didSet(value) {
            if value {
                self.hideLoading()
            }
        }
    }
    
    //For Pagination
    var isDataLoading = false
    var isPullToRefresh = false

    override func loadView() {
        super.loadView()
        setupTableView()
        addRefreshControl()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        title = Localization.thingsToDeliver
    }

    private func setupTableView() {
        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
        UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        tableView.register(DeliveryCell.self, forCellReuseIdentifier: String(describing: DeliveryCell.self))
        tableView.snp.makeConstraints { (make) -> Void in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    private func addRefreshControl() {
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handlePullToRefresh(_:)), for: .valueChanged)
    }

    @objc
    func handlePullToRefresh(_ sender: Any) {
        isPullToRefresh = true
        presenter?.retrieveDeliveryList(onLaunch: false, offSet: 0)
    }
}

extension DeliveryListViewController: DeliveryListViewProtocol {

    func show(deliveries: [DeliveryModel]) {
        if isPullToRefresh {
            isPullToRefresh = false
            self.deliveries.removeAll()
        }
        
        self.deliveries.append(contentsOf: deliveries)
        tableView.reloadData()
        refreshControl.endRefreshing()
        hideBottomLoader()
    }

    func showError() {
        view.removeLoader()
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
        hideBottomLoader()
        let alert = UIAlertController.make(title: Localization.error,
                                                     message: Localization.somethingWentWrong,
                                                     okTitle: Localization.ok)
        present(alert, animated: true, completion: nil)

    }
    
    func loadingState() -> Bool! {
        return isLoading
    }
    
    func setLoadingState(_ loading: Bool) {
        isLoading = loading
    }

    func showLoading() {
        view.showLoader()
    }

    func hideLoading() {
        view.removeLoader()
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
        hideBottomLoader()
    }

    func showNoInternet() {
        let alert = UIAlertController.make(title: Localization.noInternetConnection,
                                                     message: Localization.checkInternetConnection,
                                                     okTitle: Localization.ok)
        present(alert, animated: true, completion: nil)
    }
    
    func noMoreDataAvailable() {
        let alert = UIAlertController.make(title: "",
                                           message: Localization.noMoreDataAvailable,
                                           okTitle: Localization.ok)
        present(alert, animated: true, completion: nil)
    }
    
    func hideBottomLoader() {
        tableView.tableFooterView = UIView()
    }
    
    func showBottomLoader() {
        let activityView = UIActivityIndicatorView(frame: CGRect(x: Constants.AppUI.Indicator.x, y: Constants.AppUI.Indicator.y, width: Constants.AppUI.Indicator.width, height: Constants.AppUI.Indicator.height))
        activityView.style = .whiteLarge
        activityView.color = Constants.AppUI.Indicator.color
        activityView.startAnimating()
        tableView.tableFooterView = activityView
    }
}

extension DeliveryListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let deliveryCell = tableView.dequeueReusableCell(withIdentifier: String(describing: DeliveryCell.self)) as? DeliveryCell {
            if !deliveries.isEmpty {
            deliveryCell.populate(deliveries: deliveries, indexPath: indexPath)
            cell = deliveryCell
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveries.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showMap(forDelivery: deliveries[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let lastElement = deliveries.count - 1
        if indexPath.row == lastElement && !loadingState() {
            showBottomLoader()
            presenter?.retrieveDeliveryList(onLaunch: false, offSet: indexPath.row + 1)
        }
    }
}

extension DeliveryListViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isDataLoading = false
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let scrollableHeight = tableView.contentOffset.y + tableView.frame.size.height
        if scrollableHeight >= tableView.contentSize.height && !isDataLoading && !isPullToRefresh {
            isDataLoading = true
            showBottomLoader()
            presenter?.retrieveDeliveryList(onLaunch: false, offSet: deliveries.count)
        }
    }
}
