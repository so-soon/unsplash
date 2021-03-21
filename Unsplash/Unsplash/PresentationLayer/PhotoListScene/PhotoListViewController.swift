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
        self.PhotoListTableView.dataSource = self
        self.PhotoListTableView.delegate = self
        
        configurator.configure(photoListViewController: self)
        presenter.viewDidLoad()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //MARK:- Interface Builder Links
    @IBOutlet weak var PhotoListTableView: UITableView!
    
    @IBAction func unWindToPhotoListView(_ unwindSegue : UIStoryboardSegue) {
        // Todo :
    }
    
    @IBAction func searchTextFieldEndEdit(_ sender: UITextField) {
        presenter.searchTextFieldEndEdit(with: sender.text.orEmpty())
    }
}

extension PhotoListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoListTableViewCell.id, for: indexPath) as! PhotoListTableViewCell
        
        presenter.configure(cell: cell, forRow: indexPath.row)
        
        return cell
    }
}

extension PhotoListViewController : UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let photoDataCount = presenter.numberOfRowsInSection()
        
        if photoDataCount == 0 {
            return
        }else{
            for indexPath in indexPaths {
                if photoDataCount == (indexPath.row + 1) {
                    presenter.fetchPhotoList()
                }
            }
//            tableView.reloadData() // Todo : do or dont?
        }
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

extension PhotoListViewController: PhotoListView {
    func reloadTableView(){
        DispatchQueue.main.async { [weak self] in
            self?.PhotoListTableView.reloadData()
        }
    }
}
