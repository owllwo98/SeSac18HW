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
    
    var color: String = "black"
    
    var colorList: [String] = ["black", "white", "yellow", "red", "purple", "green", "blue"]
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
        [photoSearchDetailView.blackButton,
         photoSearchDetailView.whiteButton,
         photoSearchDetailView.yellowButton,
         photoSearchDetailView.redButton, photoSearchDetailView.purpleButton, photoSearchDetailView.greenButton, photoSearchDetailView.blueButton].forEach {
            $0.addTarget(self, action: #selector(radioButton(_:)), for: .touchUpInside)
        }
        photoSearchDetailView.blackButton.addTarget(self, action: #selector(sort), for: .touchUpInside)
        photoSearchDetailView.whiteButton.addTarget(self, action: #selector(sort), for: .touchUpInside)
        photoSearchDetailView.yellowButton.addTarget(self, action: #selector(sort), for: .touchUpInside)
        photoSearchDetailView.redButton.addTarget(self, action: #selector(sort), for: .touchUpInside)
        photoSearchDetailView.purpleButton.addTarget(self, action: #selector(sort), for: .touchUpInside)
        photoSearchDetailView.greenButton.addTarget(self, action: #selector(sort), for: .touchUpInside)
        photoSearchDetailView.blueButton.addTarget(self, action: #selector(sort), for: .touchUpInside)
        
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
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoDetailViewController()
        
//        vc.contents = (indexPath.item).formatted()
        vc.list = list[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension PhotoSearchViewController: UISearchBarDelegate {
    private func dissmissKeyboard() {
        photoSearchDetailView.shoppingSearchBar.resignFirstResponder()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dissmissKeyboard()
        
        guard let text = photoSearchDetailView.shoppingSearchBar.text else {
            return
        }
        
        query = text
        
        NetworkManager.shared.request(url: "https://api.unsplash.com/search/photos?&page=1&per_page=20&client_id=\(APIKey.clientID)&order_by=relevant&color=black" + "&query=\(query)" + "&order_by=\(order)" + "&color=\(color)", T: Photo.self) { [weak self] (photo: Photo) in
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
        [photoSearchDetailView.blackButton,
         photoSearchDetailView.whiteButton,
         photoSearchDetailView.yellowButton,
         photoSearchDetailView.redButton, photoSearchDetailView.purpleButton, photoSearchDetailView.greenButton, photoSearchDetailView.blueButton].forEach {
            if $0.tag == sender.tag {
                $0.backgroundColor = .blue
                $0.setTitleColor(.white, for: .normal)
                color = colorList[$0.tag]
            } else {
                $0.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.945, alpha: 1)
                $0.setTitleColor(.black, for: .normal)
            }
        }
    }
    
    @objc
    func sort() {
        page = 1
        requestPhotoData()
    }
    
    
    @objc
    func orderList() {
        print(#function)
        
        page = 1
        
        photoSearchDetailView.orderButton.isSelected.toggle()
        
        let title = photoSearchDetailView.orderButton.isSelected ? "최신순" : "정확도"
        
        photoSearchDetailView.orderButton.setTitle(title, for: .normal)
        
        order = photoSearchDetailView.orderButton.isSelected ? "latest" : "relevant"
        
        requestPhotoData()
    }
    
    
}

extension PhotoSearchViewController {
    func requestPhotoData() {
        NetworkManager.shared.request(url: "https://api.unsplash.com/search/photos?&page=\(page)&per_page=20&client_id=\(APIKey.clientID)" + "&query=\(query)" + "&order_by=\(order)" + "&color=\(color)", T: Photo.self) { [weak self] (photo: Photo) in
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
