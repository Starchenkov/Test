//
//  ViewModel.swift
//  Test
//
//  Created by Sergey Starchenkov on 10.03.2021.
//

import Foundation
import UIKit

let urlJson = "https://pryaniky.com/static/json/sample.json"

class ViewModel: NSObject {
    
    @IBOutlet weak var networkManager: NetworkManager!
    
    private var elementsArray : [DataElements] = []
    private var viewsArray : [String] = []
    
    func fetchData() {
        networkManager.fetchData(url: urlJson) { (elementsModel) in
            self.elementsArray = elementsModel.data
            self.viewsArray = elementsModel.view
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return viewsArray.count
    }
    
    func getTypeCell(at indexPath: IndexPath) -> String {
        return viewsArray[indexPath.row]
    }
    
    func configCell(cell: UITableViewCell, typeCell: String) -> UITableViewCell {
        
        switch typeCell {
        case "hz":
            for element in elementsArray {
                if element.name == "hz" {
                    let newCell = cell as! hzTableViewCell
                    newCell.label.text = element.data.text
                    return newCell
                }
            }
        case "selector":
            for element in elementsArray {
                if element.name == "selector" {
                    let newCell = cell as! selectorTableViewCell
                    newCell.selector.removeAllSegments()
                    if let variants = element.data.variants {
                        for variant in variants {
                            newCell.selector.insertSegment(withTitle: variant.text, at: variant.id, animated: false)
                        }
                        if let selectedId = element.data.selectedId {
                            newCell.selector.selectedSegmentIndex = selectedId - 1
                        }
                    }
                    return newCell
                }
            }
        case "picture":
            for element in elementsArray {
                if element.name == "picture" {
                    let newCell = cell as! pictureTableViewCell
                    newCell.label.text = element.data.text
                    if let urlImage = element.data.url {
                        networkManager.downloadImage(with: urlImage) { (image) in
                            newCell.picture.image = image
                        }
                    }
                    return newCell
                }
            }
        default:
            break
        }
        return cell
    }
    
    
        

    
}
