//
//  ViewController.swift
//  CAT_API
//
//  Created by 김은지 on 2023/05/23.
//

import SDWebImage
import SnapKit
import UIKit



class ViewController: UIViewController, UITableViewDelegate  {
    
    
    
    
    
    
    var tableView = UITableView()
    var catImages: [UIImage] = [] // 고양이 사진 담는 배열
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentURLVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.separatorStyle = .singleLine
        tableView.isPagingEnabled = true // 페이지 단위로 스크롤되도록 설정
        
    }
    func updateImage(_ image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.visibleCells.forEach { cell in
                cell.imageView?.image = image
                cell.setNeedsLayout()
            }
        }
    }
    
    func presentURLVC() {
        let urlVC = URLViewController(firstVC: self)
        present(urlVC, animated: true, completion: nil)
    }
}
    
    
    extension ViewController: UITableViewDataSource {
        
        
        
        func numberOfSections(in tableView: UITableView) -> Int {
     
            return catImages.count
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 4 // 한 섹션에 4개의 행
        }
        
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let sectionIndex = indexPath.section
            let rowIndex = indexPath.row
            let imageIndex = sectionIndex * 4 + rowIndex // 해당 셀의 이미지 인덱스 계산
            
            if imageIndex < catImages.count {
                let image = catImages[imageIndex]
                cell.imageView?.image = image // 이미지를 셀의 이미지뷰에 설정
            }
            
        
            return cell
        }
    }
    
    

