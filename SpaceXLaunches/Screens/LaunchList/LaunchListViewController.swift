//
//  ViewController.swift
//  SpaceXLaunches
//
//  Created by Sarp  on 4.02.2022.
//

import UIKit
//TODO: add error popup, refactor date?
class LaunchListViewController: BaseViewController {
    
    let viewModel = LaunchListViewModel()
    let launchListTableView = UITableView(frame: .zero)
    
    enum ListSection: Int, CaseIterable {
        case launches
    }
    
    var dataSource: UITableViewDiffableDataSource<ListSection, Launch>!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupNavigationTitle()
        setupTableView()
        getLaunches()
    }
    
    private func setupNavigationTitle() {
        view.backgroundColor = Constants.Color.backgroundColor
        title = "SpaceX Launches"
    }

    private func setupTableView() {
        launchListTableView.delegate = self
        launchListTableView.frame = view.bounds
        launchListTableView.rowHeight = 100
        launchListTableView.backgroundColor = Constants.Color.backgroundColor
        launchListTableView.register(LaunchListTableViewCell.self, forCellReuseIdentifier: LaunchListTableViewCell.identifier)
        view.addSubview(launchListTableView)
        
        dataSource = UITableViewDiffableDataSource(tableView: launchListTableView, cellProvider: { tableView, indexPath, model in
            let cell = tableView.dequeueReusableCell(withIdentifier: LaunchListTableViewCell.identifier, for: indexPath) as! LaunchListTableViewCell
            let launch = model
            cell.setData(launch: launch)
            return cell
        })
    }
    
    func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<ListSection, Launch>()
        snapshot.appendSections([.launches])
        snapshot.appendItems(self.viewModel.launches)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func getLaunches() {
        self.showLoadingView()
        viewModel.fetchLaunches()
    }
}

extension LaunchListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let launch = viewModel.launches[indexPath.row]
        let launchDetailViewController = LaunchDetailViewController()
        launchDetailViewController.setData(launch)
        self.navigationController?.pushViewController(launchDetailViewController, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard self.viewModel.hasMoreLaunches else { return }
            self.showLoadingView()
            self.viewModel.fetchLaunches(offset: self.viewModel.launchesPastOffset)
        }
    }
}

extension LaunchListViewController: LaunchListViewModelDelegate {
    func fetchLaunchSuccess() {
        self.hideLoadingView()
        self.updateDataSource()
    }
    
    func fetchLaunchFail(_ error: Error?) {
        self.hideLoadingView()
        self.showPopup(text: error?.localizedDescription ?? "")
    }
}
