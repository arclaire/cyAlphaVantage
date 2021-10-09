//
//  VCScreen2.swift
//  CyAlphaVantage
//
//  Created by Lucy on 15/01/21.
//

import UIKit

class VCScreen2: UIViewController {
    @IBOutlet var viewNoData: UIView!
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var viewContainer: UIView!

    @IBOutlet var viewBlur: UIVisualEffectView!
    @IBOutlet var table: UITableView!

    @IBOutlet var tableSearch: UITableView!

    @IBOutlet var activitySearch: UIActivityIndicatorView!
    @IBOutlet var activity: UIActivityIndicatorView!

    @IBOutlet var consTableBottomToSuperview: NSLayoutConstraint!
    var presenter: PScreen2?
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        registerKeyboardNotifications()
        setupTableView()

        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    private func setupTableView() {
        let nibToRegister = UINib(nibName: String(describing: CellTableDoubleInfo.self), bundle: nil)
        table.register(nibToRegister, forCellReuseIdentifier: String(describing: CellTableDoubleInfo.self))

        table.delegate = self
        table.dataSource = self
        table.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        table.separatorInset = .zero

        table.contentInsetAdjustmentBehavior = .never
        table.contentOffset = CGPoint.zero

        let nibToRegister2 = UINib(nibName: String(describing: CellTableSearchSymbol.self), bundle: nil)
        tableSearch.register(nibToRegister2, forCellReuseIdentifier: String(describing: CellTableSearchSymbol.self))

        tableSearch.delegate = self
        tableSearch.dataSource = self
        tableSearch.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableSearch.separatorInset = .zero

        tableSearch.contentOffset = CGPoint.zero
        tableSearch.isHidden = true
    }

    func displayLoading(isLoading: Bool) {
        tableSearch.isHidden = true
        if isLoading {
            viewBlur.isHidden = false
            activity.startAnimating()
        } else {
            viewBlur.isHidden = true
            activity.stopAnimating()
        }

        viewNoData.isHidden = true
    }

    func displayLoadingSearch(isLoading: Bool) {
        if isLoading {
            activitySearch.isHidden = false
            activitySearch.startAnimating()
        } else {
            activitySearch.isHidden = true
            activitySearch.stopAnimating()
        }
    }

    func reloadUI() {
        table.reloadData()
    }

    func reloadUISearch() {
        tableSearch.reloadData()
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
        // let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 30, right: 0)
        consTableBottomToSuperview.constant = -keyboardSize.height
    }

    @objc func keyboardWillHide(notification _: NSNotification) {
        consTableBottomToSuperview.constant = 0
    }
}

extension VCScreen2: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_: UISearchBar) {
        tableSearch.isHidden = true
    }

    func searchBar(_: UISearchBar, shouldChangeTextIn _: NSRange, replacementText _: String) -> Bool {
        return true
    }

    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            print("Call Services")
            tableSearch.isHidden = false
            presenter?.loadSearch(str: searchText)
        } else {
            tableSearch.isHidden = true
        }
    }
}

extension VCScreen2: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection _: Int) -> Int {
        var intCount = 0
        if tableView == table {
            if let total = presenter?.arrModel1.count {
                intCount = total
            }
        } else {
            if let total = presenter?.arrSymbol.bestMatches?.count {
                intCount = total
            }
        }

        return intCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == table {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CellTableDoubleInfo.self)) as! CellTableDoubleInfo
            if let data = presenter?.arrModel1 {
                if data.count > 0 {
                    cell.displayData1(model: data[indexPath.row], strName: presenter!.strSymbol1, isDefault: false)
                } else {
                    cell.displayData1(model: nil, strName: presenter!.strSymbol1, isDefault: true)
                }
            }

            if let data = presenter?.arrModel2 {
                if data.count > 0 {
                    cell.displayData2(model: data[indexPath.row], strName: presenter!.strSymbol1, isDefault: false)
                } else {
                    cell.displayData2(model: nil, strName: presenter!.strSymbol1, isDefault: true)
                }
            }

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CellTableSearchSymbol.self)) as! CellTableSearchSymbol
            if let data = presenter?.arrSymbol.bestMatches {
                cell.displayData(data: data[indexPath.row])
            }

            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // self.eventHandler?.goToDetail(index: indexPath.row)
        if tableView == tableSearch {
            if let data = presenter?.arrSymbol.bestMatches {
                print("Selected Symbol", data[indexPath.row].symbol!)
                presenter?.loadDataSymbolDetail(str: data[indexPath.row].symbol!) // loadSearch(str: data[indexPath.row].symbol!)
                searchBar.text = ""
                searchBar.resignFirstResponder()
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        var height: CGFloat = 0.0
        if tableView == table {
            if let pH = presenter?.heightTableRow {
                height = pH
            }
        } else {
            if let pH = presenter?.heightTableSearch {
                height = pH
            }
        }

        return height
    }
}
