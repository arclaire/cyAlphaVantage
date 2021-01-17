//
//  VCScreen1.swift
//  CyAlphaVantage
//
//  Created by Lucy on 15/01/21.
//

import UIKit

class VCScreen1: UIViewController {
    
    @IBOutlet weak var viewNoData: UIView!
    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var viewContainer: UIView!
    @IBOutlet weak var btnCompare: UIButton!
    @IBOutlet weak var btnSettings: UIButton!
    
    @IBOutlet weak var viewBlur: UIVisualEffectView!
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var tableSearch: UITableView!
    
    @IBOutlet weak var activitySearch: UIActivityIndicatorView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    
    @IBOutlet weak var consTableBottomToSuperview: NSLayoutConstraint!
    var presenter: PScreen1?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        self.registerKeyboardNotifications()
        self.setupTableView()
        self.presenter?.loadDataSymbolDetail(str: "IBM")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func actionButton(_ sender: Any) {
        if let btn = sender as? UIButton {
            if btn == self.btnCompare {
                self.goToCompare()
            }
            
            if btn == self.btnSettings {
                self.goToSettings()
            }
        }
    }
    
    private func goToCompare() {
        self.presenter?.navigateToCompare()
    }
    
    private func goToSettings() {
        self.presenter?.navigateToSettings()
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
        
        let nibToRegister2 = UINib(nibName: String(describing: CellTableSearchSymbol.self), bundle: nil)
        self.tableSearch.register(nibToRegister2, forCellReuseIdentifier: String(describing: CellTableSearchSymbol.self))
        
        self.tableSearch.delegate = self
        self.tableSearch.dataSource = self
        self.tableSearch.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        self.tableSearch.separatorInset = .zero
        
        self.tableSearch.contentOffset = CGPoint.zero
        self.tableSearch.isHidden = true
        
    }
    
    func displayLoading(isLoading: Bool) {
        self.tableSearch.isHidden = true
        if isLoading {
            self.viewBlur.isHidden = false
            self.activity.startAnimating()
        } else {
            self.viewBlur.isHidden = true
            self.activity.stopAnimating()
        }
        
        self.viewNoData.isHidden = true
        if let data = self.presenter?.arrModel {
            if data.count < 1 {
                self.viewNoData.isHidden = false
            }
        }
    }
    
    func displayLoadingSearch(isLoading: Bool) {
        if isLoading {
            self.activitySearch.isHidden = false
            self.activitySearch.startAnimating()
        } else {
            self.activitySearch.isHidden = true
            self.activitySearch.stopAnimating()
        }
    }
    
    func reloadUI(){
        self.viewNoData.isHidden = false
        if let data = self.presenter?.arrModel {
            if data.count > 0 {
                self.viewNoData.isHidden = true
                self.table.reloadData()
            }
        }
        
    }
    
    func reloadUISearch() {
        self.tableSearch.reloadData()
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        //let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 30, right: 0)
        self.consTableBottomToSuperview.constant = -keyboardSize.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.consTableBottomToSuperview.constant = 0
    }
    
}

extension VCScreen1: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.tableSearch.isHidden = true
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            print("Call Services")
            self.tableSearch.isHidden = false
            self.presenter?.loadSearch(str: searchText)
        } else {
            self.tableSearch.isHidden = true
        }
    }
}

extension VCScreen1: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var intCount = 0
        if tableView == self.table {
            if let total = self.presenter?.arrModel.count {
                intCount = total
            }
        } else {
            if let total = self.presenter?.arrSymbol.bestMatches?.count {
                intCount = total
            }
        }
        
        return intCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.table {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CellTableSingleInfo.self)) as! CellTableSingleInfo
            if let data = self.presenter?.arrModel[indexPath.row] {
                cell.displayData(data: data)
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CellTableSearchSymbol.self)) as! CellTableSearchSymbol
            if let data = self.presenter?.arrSymbol.bestMatches {
                cell.displayData(data: data[indexPath.row])
            }
            
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.eventHandler?.goToDetail(index: indexPath.row)
        if tableView == self.tableSearch {
            if let data = self.presenter?.arrSymbol.bestMatches {
                print("Selected Symbol", data[indexPath.row].symbol!)
                self.presenter?.loadDataSymbolDetail(str: data[indexPath.row].symbol!)//loadSearch(str: data[indexPath.row].symbol!)
                self.searchBar.text = data[indexPath.row].symbol!
                self.searchBar.resignFirstResponder()
                
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 0.0
        if tableView == table {
            if let pH = self.presenter?.heightTableRow {
                height = pH
            }
        } else {
            if let pH = self.presenter?.heightTableSearch {
                height = pH
            }
        }
        
        return height
    }
    
    
}
