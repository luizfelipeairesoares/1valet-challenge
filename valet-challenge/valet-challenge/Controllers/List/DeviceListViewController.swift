//
//  DeviceListViewController.swift
//  valet-challenge
//
//  Created by Luiz Felipe Aires Soares on 2022-03-31.
//

import UIKit

protocol DeviceListVCProtocol: AnyObject {
    
    init(viewModel: DeviceListViewModelProtocol)
    
    func reloadDevices()
    func showError(_ message: String)
    func showEmptyView()
    
}

class DeviceListViewController: UIViewController, DeviceListVCProtocol {
    
    // MARK: - Properties/Variables
    
    private let viewModel: DeviceListViewModelProtocol
    
    private lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.automaticallyShowsCancelButton = true
        search.obscuresBackgroundDuringPresentation = true
        search.searchBar.placeholder = "Search For Device"
        search.hidesNavigationBarDuringPresentation = false
        return search
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .lightGray
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.text = "Couldn't find your devices"
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Init
    
    required init(viewModel: DeviceListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Devices"
        
        view.backgroundColor = .white
        
        setupTableView()
        setupEmptyLabel()
        
        viewModel.assignView(self)
    }
    
    // MARK: - Protocol Functions
    
    func reloadDevices() {
        tableView.isHidden = false
        emptyLabel.isHidden = true
        tableView.reloadData()
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { [weak self] _ in
            self?.viewModel.requestDevices()
        }))
        alert.addAction(UIAlertAction(title: "Close", style: .cancel))
        present(alert, animated: true)
    }
    
    func showEmptyView() {
        tableView.isHidden = true
        emptyLabel.isHidden = false
    }
    
    // MARK: - Private functions
    
    private func setupTableView() {
        tableView.tableHeaderView = searchController.searchBar
        tableView.register(DeviceCell.self, forCellReuseIdentifier: DeviceCell.cellId)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
    
    private func setupEmptyLabel() {
        view.addSubview(emptyLabel)
        NSLayoutConstraint.activate([
            emptyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emptyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}

// MARK: - UITableViewDataSource

extension DeviceListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.devices.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

// MARK: - UITableViewDelegate

extension DeviceListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DeviceCell.cellId, for: indexPath) as? DeviceCell else {
            return UITableViewCell()
        }
        let device = viewModel.devices[indexPath.row]
        cell.setup(device: device)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let device = viewModel.devices[indexPath.row]
        let detail = DeviceDetailViewController(viewModel: DeviceDetailViewModel(device: device))
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
}

// MARK: - UISearchControllerDelegate

extension DeviceListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchForDevices(searchController.searchBar.text)
    }
    
}
