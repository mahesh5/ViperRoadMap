//
//  PIHomeViewController.swift
//  MyDocTask
//
//  Created by mahesh.varadara on 10/1/20.
//  Copyright (c) 2020 mahesh.varadara. All rights reserved.
//

import UIKit

final class PIHomeViewController: PIViewController {
    
    var output: PPHomeInteractorInput?
    var router: PPHomeRouterProtocol?
    // MARK: - Initializers
    var tracksVM: PVMHomeViewModel?
    var searchArray: [PVMTracks]?
    @IBOutlet weak var tracksTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var arrayPlayList:[Int] = Array()
    var limit = 10
    var totalTracks = 0
    var loadMore = true
    var isSearch = false
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupTableView()
        output?.getAllTracks()
    }
    func setupTableView() {
        tracksTableView.register(UINib(nibName: "TracksTableViewCell", bundle: nil),
                                 forCellReuseIdentifier: "HomeCell")
        tracksTableView.tableFooterView = UIView()
        var index = 0
        while index < limit {
            arrayPlayList.append(index)
            index = index + 1
        }
    }
    // MARK: - Configurator
    private func configure(configurator: PPBaseConfig = PCRHomeConfigurator.sharedInstance) {
        configurator.configure(viewController: self)
    }
    deinit {
        //dealloc called
    }
    func loadMore(indexPath: Int) -> Bool {
        if indexPath == arrayPlayList.count - 1 {
            // we are at last cell load more content
            var index = arrayPlayList.count
            limit = index + 10
            while index < limit {
                if arrayPlayList.count == totalTracks {
                    loadMore = false
                    break
                } else {
                    arrayPlayList.append(index)
                    loadMore = true
                    index = index + 1
                }
            }
        }
        return loadMore
    }
    @objc func loadTable() {
        self.tracksTableView.reloadData()
    }
}

// MARK: - PPHomePresenterOutput

extension PIHomeViewController: PPHomePresenterOutput {
    func displayErrorMessage(message: String) {
        let alert = UIAlertController(title: "MyDoc", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayPlayList(with viewModel: PVMHomeViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.totalTracks = viewModel.count ?? 0
            self?.tracksVM = viewModel
            self?.tracksTableView.reloadData()
        }
    }
}

// MARK: - TableViewDelegate Method
extension PIHomeViewController: UITableViewDataSource, UITableViewDelegate {
    // Return the number of rows for the table.
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch {
            return searchArray?.count ?? 0
        } else {
            return arrayPlayList.count

        }
    }
    // Provide a cell object for each row.
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell",
                                                  for: indexPath)
           as?   TracksTableViewCell
         //setting title
        if let cell = cell {
            if isSearch {
                if let response = searchArray?[indexPath.row] {
                    cell.updateLabel(data: response)
                }
            } else {
                if let response = tracksVM?.tracks?[indexPath.row] {
                    cell.updateLabel(data: response)
                }
            }
            
        }
         cell?.selectionStyle = .none
         return cell ?? TracksTableViewCell()
     }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let load = loadMore(indexPath: indexPath.row)
        let lastSectionIndex = tableView.numberOfSections - 1
             let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
             if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
                // print("this is the last cell")
                if load && isSearch == false {
                    let spinner = UIActivityIndicatorView(style: .medium)
                    spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                    tableView.tableFooterView = spinner
                    spinner.startAnimating()
                    tableView.tableFooterView?.isHidden = false
                    self.perform(#selector(loadTable), with: nil, afterDelay: 1.0)
                } else {
                    tableView.tableFooterView?.isHidden = true
                }
             }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tracks = tracksVM?.tracks?[indexPath.row]
        router?.navigateToDetailVC(selectedTrack: tracks)
    }
}

extension PIHomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearch = true
        searchArray = searchText.isEmpty ? tracksVM?.tracks : tracksVM?.tracks?.filter { ($0.artistName?.contains(searchText))! }
        self.tracksTableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearch = false
        searchBar.resignFirstResponder()
        self.tracksTableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadMore = true
        searchBar.resignFirstResponder()
        self.tracksTableView.reloadData()
    }

}
