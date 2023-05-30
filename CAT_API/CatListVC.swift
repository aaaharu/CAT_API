//
//  CatListVC.swift
//  CAT_API
//
//  Created by 김은지 on 2023/05/30.
//

import UIKit
import Foundation
import SDWebImage

class CatListVC: UIViewController {
    
    // 검색 작업 아이템
    var searchDispatchWorkItem : DispatchWorkItem? = nil
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    //https://api.unsplash.com/search/photos?client_id=G1Vlnn-OGktHeRJszyMjAHZDHUKRSU_YhIwOKpDmYpE&query=
    
    var photoList: [PhotoItem] = [] {
        didSet{
            print(#fileID, #function, #line, "- \(photoList.count)")
        }
    }
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#fileID, #function, #line, "-  주석 ")
        
        myCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        tableView.dataSource = self
        
        var nib = UINib(nibName: "CatTableViewCell", bundle: .main)
        
        var colNib = UINib(nibName: "CatCollectionViewCell", bundle: .main)
        
        myCollectionView.register(colNib, forCellWithReuseIdentifier: "CatCollectionViewCell")
        
        tableView.register(nib, forCellReuseIdentifier: "CatTableViewCell")
        searchBar.searchTextField.addTarget(self, action: #selector(searchBarInput(_:)), for: .editingChanged)
        searchPhoto("cat")
    }
    
    @objc func searchBarInput(_ searchTextField: UITextField) {
        print(#fileID, #function, #line, "- \(searchTextField.text)")
        
        if let query = searchTextField.text {
            
            // 검색어가 입력되면 기존 작업 취소
            searchDispatchWorkItem?.cancel()
            
            let dispatchWorkItem = DispatchWorkItem(block: {
                // 백그라운드 - 사용자 입력 userInteractive
                DispatchQueue.global(qos: .userInteractive).async {
                    print(#fileID, #function, #line, "- 검색 API 호출하기 userInput: (searchInput)")
                    self.searchPhoto(query)
                }
            })
            
            // 기존작업을 나중에 취소하기 위해 메모리 주소 일치 시켜줌
            self.searchDispatchWorkItem = dispatchWorkItem
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: dispatchWorkItem)
            
            
            //        searchPhoto(searchInput)
        }
        
        
    }
    
    func searchPhoto(_ query: String) {
        print(#fileID, #function, #line, "- a")
        let urlString: String = "https://api.unsplash.com/search/photos?client_id=G1Vlnn-OGktHeRJszyMjAHZDHUKRSU_YhIwOKpDmYpE&query=\(query)"
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            
            guard let data = data else { return }
            
            do {
                print(#fileID, #function, #line, "- <# 주석 #>")
                let dataTry: SearchPhotoResponse = try JSONDecoder().decode(SearchPhotoResponse.self, from: data)
                
                let resultList: [Result] = dataTry.results ?? []
                let photos: [PhotoItem] = resultList.map { resultItem -> PhotoItem in
                    return PhotoItem(resultItem)
                }
                
                self?.photoList = photos
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
                
                
            } catch {
                print(#fileID, #function, #line, "- \(error)")
            }
            
            
            
            
        }.resume()
        
        
        
    }
    
    
    
}

extension CatListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CatTableViewCell", for: indexPath) as? CatTableViewCell {
            
            let cellData: PhotoItem = photoList[indexPath.row]
            
            cell.label?.text = cellData.name
            cell.catImageView?.sd_setImage(with: URL(string: cellData.urlString))
            
            return cell
        }
        return UITableViewCell()
    }
    
    
    
}

extension CatListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatCollectionViewCell", for: indexPath) as? CatCollectionViewCell {
            
            let cellData: PhotoItem = photoList[indexPath.item]
            
            cell.label?.text = cellData.name
            cell.catImageView?.sd_setImage(with: URL(string: cellData.urlString))
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}

extension CatListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.bounds.width / 2) - 20
        let height = collectionView.bounds.height
        
        return CGSize(width: width, height: height)
    }
}
