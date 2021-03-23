//
//  ViewController.swift
//  Unsplash
//
//  Created by so-soon on 2021/03/20.
//

import UIKit

class PhotoListViewController: UIViewController {
    var configurator = PhotoListConfiguratorImplementation()
    var presenter: PhotoListPresenter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(photoListViewController: self)
        presenter.viewDidLoad()
        
        let cellNib = UINib(nibName: PhotoListTableViewCellImplementation.id, bundle: nil)
        self.photoListTableView.register(cellNib, forCellReuseIdentifier: PhotoListTableViewCellImplementation.id)
        
        self.photoListTableView.dataSource = self
        self.photoListTableView.delegate = self
        
        self.photoSearchBar.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.perpare(for: segue, sender: sender)
    }
    
    //MARK:- Interface Builder Links
    @IBOutlet weak var photoListTableView: UITableView!
    @IBOutlet weak var photoSearchBar: UISearchBar!
    
}

extension PhotoListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photoDataCount = presenter.numberOfRowsInSection()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoListTableViewCellImplementation.id, for: indexPath) as! PhotoListTableViewCellImplementation
        presenter.configure(cell: cell, forRow: indexPath.row)
        
        if indexPath.row == photoDataCount - 1 {
            presenter.updatePhotoList()
        }
        
        return cell
    }
}

extension PhotoListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(cellAt: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let width = UIScreen.main.bounds.width
        let height = CGFloat(presenter.photoRatioHeight(cellAt: indexPath.row)) * width
        
        return height
    }
}

extension PhotoListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchTextFieldEndEdit(with: searchBar.text)
        hideCancelButton(searchBar)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        hideCancelButton(searchBar)
    }
    
    func hideCancelButton(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
}

extension PhotoListViewController: PhotoListView {
    func reloadTableView(){
        DispatchQueue.main.async { [weak self] in
            self?.photoListTableView.reloadData()
        }
    }
    
    func moveSrollFocus(at row: Int){
        let indexPath = IndexPath(row: row, section: 0)
        self.photoListTableView.scrollToRow(at: indexPath, at: .middle, animated: false)
    }
    
    func detailViewWillAppear(){
        self.view.backgroundColor = .black
    }
    func detailViewWilldisappear(){
        if #available(iOS 13.0, *){
            self.view.backgroundColor = .systemBackground
        }else{
            self.view.backgroundColor = .white
        }
        
    }
}
