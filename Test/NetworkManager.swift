//
//  NetworkManager.swift
//  Test
//
//  Created by Sergey Starchenkov on 09.03.2021.
//

import Foundation
import UIKit

class NetworkManager: NSObject{
    
    func fetchData(url: String, completion: @escaping (_ elementsModel: ElementsModel)->()) {
        
        guard let url = URL(string: urlJson) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, _, error) in
            
            guard let safeData = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ElementsModel.self, from: safeData)
                completion(jsonData)
                
            }catch {
                print("Error decoded JSON \(error)")
            }
        }.resume()
    }
    
    func downloadImage(with url: String, completion: @escaping (_ image: UIImage)->()) {
        
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            if let safeData = data, let image = UIImage(data: safeData) {
                
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }.resume()
    }
    
    
}
