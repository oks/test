//
//  ViewController.swift
//  TestTask
//
//  Created by Oksana Kovalchuk on 7/3/18.
//  Copyright © 2018 Oksana Kovalchuk. All rights reserved.
//

import UIKit
import SnapKit
import Moya
import RxSwift
import UIScrollView_InfiniteScroll
import AlisterSwift

class ListVC: UIViewController {
    //here should be also pull to refresh, but I had no time for it:)
    private let tableView = UITableView()
    private let viewModel = ListVM()
    private var controller: TableController
    private let bag = DisposeBag()
    
    init() {
        controller = TableController(tableView: tableView)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupController()
        
        view.addSubview(tableView)
        tableView.rowHeight = 60
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        tableView.addInfiniteScroll { [unowned self] _ in
            self.loadData()
        }
        
        tableView.setShouldShowInfiniteScrollHandler { (_) -> Bool in
            return !self.viewModel.isLoading
        }
        
        loadData(force: true)
    }
    
    
    //MARK: - Table Setup
    
    private func setupController() {
        
        controller.configureCells { (config) in
            config.register(cell: ListCell.self, for: ListCellVM.self)
        }
        
        controller.selection = { model, _ in
            guard let viewModel = model as? ListCellVM else { return }
            
            let vc = DetailVC(photoURLString: viewModel.item.photoURLString)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    //MARK: - Data Loading
    private func dataLoaded(_ models: [Contributor], force: Bool = false) {
        
        let viewModels: [ListCellVM] = models.map { return ListCellVM(item: $0)}
        controller.storage.update({ (data) in
            if force {
                data.removeAll()
            }
            data.add(viewModels)
        })
    }
    
    private func loadData(force: Bool = false) {
        
        showProgress()
        
        do {
            try viewModel.loadContributors(force: force).subscribe(onSuccess: { (data) in
                self.hideProgress()
                DispatchQueue.main.async {
                    self.tableView.finishInfiniteScroll()
                }
                self.dataLoaded(data, force: force)
            }, onError: { (error) in
                self.showError(error)
            }).disposed(by: bag)
            
        } catch ListErrors.loadingInProgress {
            
        } catch ListErrors.allDataLoaded {
            tableView.finishInfiniteScroll()
        } catch {
            showError(error)//TODO: add extension for errors, so they will have nice user faced text
        }
    }
}
