//
//  ViewController.swift
//  the-milky-way
//
//  Created by Steeve Fong on 2021/08/21.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    private lazy var refreshControl = {
        return UIRefreshControl()
    }()
    
    private let detailsViewControllerSegue = "DetailsViewControllerSegue"
    private let cellIdentifier = "nasaImageTableViewCell"
    private var nasaImageViewModel = NasaImageViewModel()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: String(describing: NasaImageTableViewCell.self), bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.refreshControl = refreshControl
        
        bindTableViewData()
        bindLoadingEvent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //MARK: - Rx TableView Setup
    func bindTableViewData() {
        nasaImageViewModel
            .items
            .catch({ (error) -> Observable<[NasaImage]> in
                self.showAlert(error)
                
                return Observable.empty()
            })
            .bind(to: tableView.rx.items(
                    cellIdentifier: cellIdentifier,
                    cellType: NasaImageTableViewCell.self)
            ) {
                row, model, cell in
                cell.setItem(model)
            }
            .disposed(by: bag)
        
        tableView.rx
            .modelSelected(NasaImage.self).bind { (item) in
                self.performSegue(withIdentifier: self.detailsViewControllerSegue, sender: item)
                
                if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
                    self.tableView.deselectRow(at: selectedIndexPath, animated: true)
                }
            }
            .disposed(by: bag)
        
        tableView.rx.setDelegate(self).disposed(by: bag)
        tableView.rx.didScroll.subscribe {
            event in
            let isLoading = (try? self.nasaImageViewModel.isLoading.value()) ?? false
            
            if self.tableView.isNearBottomEdge() && !isLoading {
                self.nasaImageViewModel.fetchPaginatedItems()
            }
        }.disposed(by: bag)
    }
    
    //MARK: - Rx Refresh Control and loading indicator Setup
    func bindLoadingEvent() {
        refreshControl.rx.controlEvent(.valueChanged).map { _ in
            self.nasaImageViewModel.refreshList()
        }.subscribe { event in }
        .disposed(by: bag)
        
        nasaImageViewModel.isLoading.subscribe {
            event in
            
            guard let isLoading = event.element else {
                return
            }
            
            if isLoading {
                self.loadingView.startAnimating()
            } else {
                self.loadingView.stopAnimating()
                self.refreshControl.endRefreshing()
            }
        }.disposed(by: bag)
    }
    
    private func showAlert(_ error: Error) {
        let alert = UIAlertController.init(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == detailsViewControllerSegue) {
            let viewController = segue.destination as! DetailsViewController
            viewController.nasaImage = sender as? NasaImage
        }
    }
}

//MARK: - TableViewDelegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
}
