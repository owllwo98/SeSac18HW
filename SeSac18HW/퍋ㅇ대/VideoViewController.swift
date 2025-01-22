//
//  VideoViewController.swift
//  SeSac18HW
//
//  Created by 변정훈 on 1/19/25.
//

import UIKit
import Alamofire
import SnapKit
import Kingfisher


class VideoViewController: UIViewController {

    var firstList: [PhotoElement] = []
    
    lazy var firstCollectionView: UICollectionView = createHorizontalCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        requestData()
        
        configureHierarchy()
        configureLayout()
        
        firstCollectionView.isPagingEnabled = true
        firstCollectionView.delegate = self
        firstCollectionView.dataSource = self
        
        firstCollectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: "VideoCollectionViewCell")
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "back"), style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isHidden = true

       
        firstCollectionView.contentInsetAdjustmentBehavior = .never
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    
    func configureHierarchy() {
        view.addSubview(firstCollectionView)
    }
    
    func configureLayout() {
        firstCollectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view)
        }
    }
    
    func createHorizontalCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 600)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white

        return collectionView
    }
}

extension VideoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return firstList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as! VideoCollectionViewCell
        
        cell.configureData(firstList[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoDetailViewController()
        
        vc.list = firstList[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension VideoViewController {
    func requestData() {
        
        NetworkManager.shared.fetchData(api: PhotoRouter.getTopic(topicID: "golden-hour"), T: [PhotoElement].self) { [weak self] (photo: [PhotoElement]) in
            guard let self = self else {return}
            firstList = photo
            firstCollectionView.reloadData()
        } errorCompletion: { error in
            self.present(UIViewController.customAlert(errorMessage: NetWorkError(rawValue: error)?.message ?? ""), animated: true)
        }
    }
}
