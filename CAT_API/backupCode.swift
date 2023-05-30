////
////  ViewController.swift
////  CAT_API
////
////  Created by 김은지 on 2023/05/23.
////
//
//import SnapKit
//import UIKit
//
//
//
//class ViewController: UIViewController, UITableViewDelegate {
//
//
//
//
//
//    var tableView = UITableView()
//    var catImages: [UIImage] = [] // 고양이 사진 담는 배열
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        presentURLVC()
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        view.addSubview(tableView)
//        tableView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        
//        tableView.separatorStyle = .singleLine
//
//
//    }
//    func updateImage(_ image: UIImage) {
//        DispatchQueue.main.async { [weak self] in
//            self?.tableView.visibleCells.forEach { cell in
//                cell.imageView?.image = image
//                cell.setNeedsLayout()
//            }
//        }
//    }
//
//    func presentURLVC() {
//        let urlVC = URLViewController(firstVC: self)
//        present(urlVC, animated: true, completion: nil)
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let cellWidth = tableView.bounds.width / 3 // 한 열에 표시할 셀 가로 길이
//        return cellWidth // 셀의 세로 크기를 가로 길이와 같게 설정하여 정사각형 셀로 만듦
//    }
//}
//
//extension ViewController: UITableViewDataSource {
//    
//
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//         return 3 // 전체 열 수
//     }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//          return 4 // 한 행에 표시할 셀 개수
//      }
//    
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.selectionStyle = .none // 선택 시 배경색 변경 제거
//        
//        let cellWidth = tableView.bounds.width / 3 // 한 열에 표시할 셀 가로 길이
//        let cellHeight = cellWidth // 셀의 세로 길이
//        
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cellWidth, height: cellHeight))
//        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
//        
//        let imageIndex = indexPath.section * 3 + indexPath.row // 사진의 인덱스 계산
//        
//        if imageIndex < catImages.count {
//            imageView.image = catImages[imageIndex]
//        }
//        
//        cell.contentView.addSubview(imageView)
//        
//        return cell
//    }
//    }
//
//
