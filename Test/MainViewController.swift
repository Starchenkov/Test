//
//  MainViewController.swift
//  Test
//
//  Created by Sergey Starchenkov on 10.03.2021.
//

import UIKit

class MainViewController: UITableViewController {
    
    @IBOutlet var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchData()
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let typeCell = viewModel.getTypeCell(at: indexPath)
        
        switch typeCell {
        case "hz":
            var cell = tableView.dequeueReusableCell(withIdentifier: "hzCell", for: indexPath)
            cell = viewModel.configCell(cell: cell, typeCell: typeCell) as! hzTableViewCell
            return cell
        case "selector":
            let cell = tableView.dequeueReusableCell(withIdentifier: "selectorCell", for: indexPath)
            let newCell = viewModel.configCell(cell: cell, typeCell: typeCell) as! selectorTableViewCell
            newCell.selector.addTarget(self, action: #selector(selectorChanged(_:)), for:     .valueChanged)
            return newCell
        case "picture":
            var cell = tableView.dequeueReusableCell(withIdentifier: "pictureCell", for: indexPath)
            cell = viewModel.configCell(cell: cell, typeCell: typeCell) as! pictureTableViewCell
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let elementClick = viewModel.getTypeCell(at: indexPath)
        
        let alert = UIAlertController(title: "\(elementClick) element was click", message: "Position in the list \(indexPath.row)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    @objc func selectorChanged(_ sender: UISegmentedControl) {
        let alert = UIAlertController(title: "Selector was changed", message: "CurrentID \(sender.selectedSegmentIndex). Value = \(String(describing: sender.titleForSegment(at: sender.selectedSegmentIndex) ?? ""))", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true)
    }
}
