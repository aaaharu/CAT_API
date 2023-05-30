//
//  URLViewController.swift
//  CAT_API
//
//  Created by 김은지 on 2023/05/23.
//

import UIKit

class URLViewController: UIViewController {
    
    var currentPage = 0
    let pageSize = 12
    
    weak var firstVC: ViewController?
    
    init(firstVC: ViewController) {
        self.firstVC = firstVC
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeGetRequest()
        
    }
    
    func makeGetRequest() {
        let urlString = "https://api.thecatapi.com/v1/images/search?limit=\(pageSize)&page=\(currentPage)"
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error:", error.localizedDescription)
                return
            }
            
            guard let data = data else {
                print("No data")
                return
            }
            
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    let images = jsonArray.compactMap { $0["url"] as? String }
                    self?.loadImages(from: images)
                    self?.currentPage += 1 // 다음 페이지로 넘어감
                } else {
                    print("Failed to parse JSON")
                }
            } catch {
                print("Error in JSON serialization:", error.localizedDescription)
            }
        }
        
        dataTask.resume()
    }
    
    
    func loadImages(from urls: [String]) {
        DispatchQueue.global().async {
            let images = urls.compactMap { url -> UIImage? in
                guard let imageURL = URL(string: url), let data = try? Data(contentsOf: imageURL) else {
                    return nil
                }
                return UIImage(data: data)
            }

            DispatchQueue.main.async { [weak self] in
                self?.firstVC?.catImages.append(contentsOf: images)
                self?.firstVC?.tableView.reloadData()
            }
        }
    }
}
