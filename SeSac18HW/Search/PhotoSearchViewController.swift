//
//  PhotoSearchViewController.swift
//  SeSac18HW
//
//  Created by 변정훈 on 1/18/25.
//

import UIKit
import Alamofire
import SnapKit
import Kingfisher

class PhotoSearchViewController: UIViewController {
    
    var photoSearchDetailView = PhotoSearchDetailView()
    
    var list: [PhotoElement] = []
    
    var page: Int = 1
    var isEnd: Bool = false
    var order: String = "relevant"
    
    var query: String = ""
    
    override func loadView() {
        self.view = photoSearchDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoSearchDetailView.mainLabel.isHidden = false
        
        configureView()
        
        configureActions()
        
    }
    
    func configureView() {
        photoSearchDetailView.shoppingSearchBar.delegate = self
        
        view.backgroundColor = .white
        self.navigationItem.title = "SEARCH PHOTO"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "back"), style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .black
        
        photoSearchDetailView.collectionView.delegate = self
        photoSearchDetailView.collectionView.dataSource = self
        photoSearchDetailView.collectionView.register(PhotoSearchCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoSearchCollectionViewCell")
        photoSearchDetailView.collectionView.prefetchDataSource = self
    }
    
    func configureActions() {
        [photoSearchDetailView.standardButton,
         photoSearchDetailView.dateSortButton,
         photoSearchDetailView.highPriceSortButton,
         photoSearchDetailView.lowPriceSortButton].forEach {
            $0.addTarget(self, action: #selector(radioButton(_:)), for: .touchUpInside)
        }
        photoSearchDetailView.standardButton.addTarget(self, action: #selector(similar), for: .touchUpInside)
        photoSearchDetailView.dateSortButton.addTarget(self, action: #selector(dateSort), for: .touchUpInside)
        photoSearchDetailView.highPriceSortButton.addTarget(self, action: #selector(descending), for: .touchUpInside)
        photoSearchDetailView.lowPriceSortButton.addTarget(self, action: #selector(Ascending), for: .touchUpInside)
        
        photoSearchDetailView.orderButton.addTarget(self, action: #selector(orderList), for: .touchUpInside)
        
        photoSearchDetailView.collectionView.keyboardDismissMode = .onDrag
    }
}

extension PhotoSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoSearchCollectionViewCell", for: indexPath) as! PhotoSearchCollectionViewCell
        
        cell.configureData(list[indexPath.item])
            
        DispatchQueue.main.async {
            cell.itemImageView.layer.cornerRadius = 8
            cell.itemImageView.clipsToBounds = true
            cell.starLabel.layer.cornerRadius = 10
            cell.starLabel.clipsToBounds = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoDetailViewController()
        
        vc.contents = (indexPath.item).formatted()
        vc.list = list[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension PhotoSearchViewController: UISearchBarDelegate {
    private func dissmissKeyboard() {
        photoSearchDetailView.shoppingSearchBar.resignFirstResponder()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        
        dissmissKeyboard()
        
        guard let text = photoSearchDetailView.shoppingSearchBar.text else {
            return
        }
        
        query = text
        
        NetworkManager.shared.request(url: "https://api.unsplash.com/search/photos?&page=1&per_page=20&client_id=\(APIKey.clientID)&order_by=relevant" + "&query=\(query)" + "&order_by=\(order)", T: Photo.self) { [weak self] (photo: Photo) in
            guard let self = self else {return}
            
            list = photo.results
            
            if list.isEmpty {
                photoSearchDetailView.mainLabel.isHidden = false
                photoSearchDetailView.mainLabel.text = "검색 결과가 없어요."
                photoSearchDetailView.collectionView.reloadData()
            } else {
                photoSearchDetailView.mainLabel.isHidden = true
            }
            
            photoSearchDetailView.collectionView.reloadData()
        }
    }
}

extension PhotoSearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            if list.count - 2 == item.item && !isEnd {
                page += 1
                requestPhotoData()
            }
        }
    }
}

extension PhotoSearchViewController {
    @objc
    func radioButton(_ sender: UIButton) {
        [photoSearchDetailView.standardButton,
         photoSearchDetailView.dateSortButton,
         photoSearchDetailView.highPriceSortButton,
         photoSearchDetailView.lowPriceSortButton].forEach {
            if $0.tag == sender.tag {
                $0.backgroundColor = .blue
                $0.setTitleColor(.white, for: .normal)
            } else {
                $0.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.945, alpha: 1)
                $0.setTitleColor(.black, for: .normal)
            }
        }
    }
    
    @objc
    func descending() {
        sort(by: "dsc")
    }
    
    @objc
    func Ascending() {
        sort(by: "asc")
    }
    
    @objc
    func dateSort() {
        sort(by: "date")
    }
    
    @objc
    func similar() {
        sort(by: "sim")
    }
    
    func sort(by order: String) {
        self.order = order
        page = 1
    }
    
    
    @objc
    func orderList() {
        print(#function)
        
        page = 1
        
        photoSearchDetailView.orderButton.isSelected.toggle()
        
        let title = photoSearchDetailView.orderButton.isSelected ? "최신순" : "정확도"
        
        photoSearchDetailView.orderButton.setTitle(title, for: .normal)
        
        order = photoSearchDetailView.orderButton.isSelected ? "latest" : "relevant"
        
        print(order)
        
        requestPhotoData()
    }
    
    
}

extension PhotoSearchViewController {
    func requestPhotoData() {
        NetworkManager.shared.request(url: "https://api.unsplash.com/search/photos?&page=\(page)&per_page=20&client_id=\(APIKey.clientID)" + "&query=\(query)" + "&order_by=\(order)", T: Photo.self) { [weak self] (photo: Photo) in
            guard let self = self else {return}
            
            if photo.total_pages == page {
                isEnd.toggle()
            } else {
                isEnd = false
            }
            
            if list.isEmpty {
                photoSearchDetailView.mainLabel.isHidden = false
                photoSearchDetailView.mainLabel.text = "검색 결과가 없어요."
                photoSearchDetailView.collectionView.reloadData()
            } else {
                if page == 1 {
                    list = photo.results
                } else {
                    list.append(contentsOf: photo.results)
                }
                photoSearchDetailView.mainLabel.isHidden = true
            }
            
            if page == 1 {
                photoSearchDetailView.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
            
            photoSearchDetailView.collectionView.reloadData()
        }
    }
}
