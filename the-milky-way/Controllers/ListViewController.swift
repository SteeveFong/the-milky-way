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
    
    private let cellIdentifier = "nasaImageTableViewCell"
    private var nasaImageViewModel = NasaImageViewModel()
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rx.setDelegate(self).disposed(by: bag)
        tableView.register(UINib(nibName: String(describing: NasaImageTableViewCell.self), bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        bindTableViewData()
    }
    
    //MARK: - Rx Setup
    func bindTableViewData() {
        nasaImageViewModel
            .items
            .bind(to: tableView.rx.items(
                    cellIdentifier: cellIdentifier,
                    cellType: NasaImageTableViewCell.self)
            ) {
                row, model, cell in
                cell.setItem(model.data.first!)
            }
            .disposed(by: bag)
        
        tableView.rx
            .modelSelected(NasaImageData.self).bind { (item) in
                print(item.photographer ?? "")
            }
            .disposed(by: bag)
        
        nasaImageViewModel.fetchItems(nil)
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
