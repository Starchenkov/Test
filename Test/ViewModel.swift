//
//  ViewModel.swift
//  Test
//
//  Created by Sergey Starchenkov on 10.03.2021.
//

import Foundation
import UIKit

let urlJson = "https://chat.pryaniky.com/json/data-custom-order-much-more-items-in-data.json"

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
        guard let index = elementsArray.firstIndex(where: { (item) -> Bool in
            item.name == typeCell
        }) else { return cell }
        let element = elementsArray[index]
        
        switch typeCell {
        case "hz":
            let newCell = cell as! hzTableViewCell
            newCell.label.text = element.data.text
            elementsArray.remove(at: index)
            return newCell
            
        case "selector":
            let newCell = cell as! selectorTableViewCell
            newCell.selector.removeAllSegments()
            if let variants = element.data.variants {
                for index in 0..<variants.count {
                    let variant = variants[index]
                    newCell.selector.insertSegment(withTitle: variant.text, at: variant.id, animated: false)
                    if variant.id == element.data.selectedId {
                        newCell.selector.selectedSegmentIndex = index
                    }
                }
            }
            elementsArray.remove(at: index)
            return newCell
            
        case "picture":
            let newCell = cell as! pictureTableViewCell
            newCell.label.text = element.data.text
            if let urlImage = element.data.url {
                networkManager.downloadImage(with: urlImage) { (image) in
                    newCell.picture.image = image
                }
            }
            elementsArray.remove(at: index)
            return newCell
            
        default:
            break
        }
        return cell
    }   
}
