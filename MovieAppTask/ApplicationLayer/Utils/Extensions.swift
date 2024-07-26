//
//  Extensions.swift
//  MovieAppTask
//
//  Created by NourAllah Ahmed on 26/07/2024.
//

import Foundation
import UIKit
extension UIViewController {
    func addTableViewFooter(tableView: UITableView){
        let spinner = UIActivityIndicatorView()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        spinner.startAnimating()
        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = false
    }
    func removeTableFooter(tableView: UITableView){
        tableView.tableFooterView?.removeFromSuperview()
        let view = UIView()
        view.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(5))
        tableView.tableFooterView = view
        tableView.tableFooterView?.isHidden = true
    }
}
