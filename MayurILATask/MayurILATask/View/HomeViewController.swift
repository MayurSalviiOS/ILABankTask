//
//  HomeViewController.swift
//  MayurILATask
//
//  Created by Neosoft on 16/05/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - IBOutlets -
    @IBOutlet weak var tableViewHome: UITableView!
    
    var viewModel : HomeViewModel!
    var selectedIndex = 0
    var searchBar: UISearchBar?
    
    //MARK: - Initializer -
    init(viewModel : HomeViewModel){
        self.viewModel = viewModel
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Constants -
    private struct HomeVCConstants{
        static let headerTableCellIdentifier = "CarouselTableViewCell"
        static let contentTableCellIdentifier = "ImageContentTableViewCell"
        static let searchTableViewHeader = "SearchHeaderView"
    }
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSearchBar()
    }
}

//MARK: - View Setup -
extension HomeViewController {
    func setupView(){
        tableViewHome.delegate = self
        tableViewHome.dataSource = self
        tableViewHome.register(UINib(nibName: HomeVCConstants.headerTableCellIdentifier, bundle: nil), forCellReuseIdentifier: HomeVCConstants.headerTableCellIdentifier )
        tableViewHome.register(UINib(nibName: HomeVCConstants.contentTableCellIdentifier, bundle: nil), forCellReuseIdentifier: HomeVCConstants.contentTableCellIdentifier )
        tableViewHome.register(UINib(nibName: HomeVCConstants.searchTableViewHeader, bundle: nil), forHeaderFooterViewReuseIdentifier: HomeVCConstants.searchTableViewHeader)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setupSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: tableViewHome.frame.size.width, height: tableViewHome.frame.size.height))
        searchBar!.delegate = self
        searchBar!.setShowsCancelButton(true, animated: true)
        searchBar!.placeholder = "Search"
    }
}

//MARK: - UITableView Delegates,Datasource -
extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            return viewModel.getNumberOfRows(index: selectedIndex)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeVCConstants.headerTableCellIdentifier, for: indexPath) as! CarouselTableViewCell
            cell.bannerData = viewModel.getCarouselData()
            cell.updateListData = { index in
                self.selectedIndex = index
                UIView.performWithoutAnimation {
                    tableView.reloadSections(IndexSet(integer: 1), with: .none)
                }
            }
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeVCConstants.contentTableCellIdentifier, for: indexPath) as! ImageContentTableViewCell
            
            if let listData = viewModel.getListingData(index: selectedIndex) {
                cell.setupData(data: listData[indexPath.row])
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            return searchBar
        }else {
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 60
        }else {
            return 1
        }
    }
}

//MARK: Search Bar Delegate
extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            viewModel.searchData(str: searchText, index: selectedIndex)
            tableViewHome.reloadData()
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.updateSearch(isSearch: false)
        tableViewHome.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.updateSearch(isSearch: false)
        searchBar.searchTextField.resignFirstResponder()
        tableViewHome.reloadData()
    }
}
