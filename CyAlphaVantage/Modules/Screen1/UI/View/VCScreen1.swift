//
//  VCScreen1.swift
//  CyAlphaVantage
//
//  Created by Lucy on 15/01/21.
//

import UIKit

class VCScreen1: UIViewController {

    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var viewContainer: UIView!
    @IBOutlet weak var btnCompare: UIButton!
    @IBOutlet weak var btnSettings: UIButton!
    
    @IBOutlet weak var table: UITableView!
    
    var presenter: PScreen1?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    @IBAction func actionButton(_ sender: Any) {
    }
    
    private func setupTableView() {
        let nibToRegister = UINib(nibName: String(describing: CellTableSingleInfo.self), bundle: nil)
        self.table.register(nibToRegister, forCellReuseIdentifier: String(describing: CellTableSingleInfo.self))
      
       
        self.table.delegate = self
        self.table.dataSource = self
        self.table.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        self.table.separatorInset = .zero
      
        self.table.contentInsetAdjustmentBehavior = .never
        self.table.contentOffset = CGPoint.zero
        
    }

    
}

extension VCScreen1: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
}

extension VCScreen1: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CellTableSingleInfo.self)) as! CellTableSingleInfo
       
      
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.eventHandler?.goToDetail(index: indexPath.row)
        
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 0.0
        if let pH = self.presenter?.heightTableRow {
            height = pH
        }
        return height
    }
    
    
}
