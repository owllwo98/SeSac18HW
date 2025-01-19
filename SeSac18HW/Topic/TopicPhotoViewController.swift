//
//  TopicPhotoViewController.swift
//  SeSac18HW
//
//  Created by 변정훈 on 1/19/25.
//

import UIKit
import Alamofire
import SnapKit
import Kingfisher

class TopicPhotoViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "OUR TOPIC"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let verticalScrollView: UIScrollView = UIScrollView()
    let contentView = UIView()
    
    lazy var firstCollectionView: UICollectionView = createHorizontalCollectionView()
    lazy var secondCollectionView: UICollectionView = createHorizontalCollectionView()
    lazy var thirdCollectionView: UICollectionView = createHorizontalCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureHierarchy()
        configureLayout()
        
        firstCollectionView.delegate = self
        firstCollectionView.dataSource = self
        secondCollectionView.delegate = self
        secondCollectionView.dataSource = self
        thirdCollectionView.delegate = self
        thirdCollectionView.dataSource = self
        
        firstCollectionView.register(FirstTopicCollectionViewCell.self, forCellWithReuseIdentifier: "FirstTopicCollectionViewCell")
        secondCollectionView.register(SecondTopicCollectionViewCell.self, forCellWithReuseIdentifier: "SecondTopicCollectionViewCell")
        thirdCollectionView.register(ThirdTopicCollectionViewCell.self, forCellWithReuseIdentifier: "ThirdTopicCollectionViewCell")
    }
    
    func createHorizontalCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 2, height: UIScreen.main.bounds.width / 1.5)
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }
    
    func configureHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(verticalScrollView)
        verticalScrollView.addSubview(contentView)
        
        contentView.addSubview(firstCollectionView)
        contentView.addSubview(secondCollectionView)
        contentView.addSubview(thirdCollectionView)
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.leading.equalToSuperview().inset(16)
        }
        
        verticalScrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(verticalScrollView)
            make.width.equalTo(verticalScrollView)
        }
        
        firstCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width / 1.5)
        }
        
        secondCollectionView.snp.makeConstraints { make in
            make.top.equalTo(firstCollectionView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width / 1.5)
        }
        
        thirdCollectionView.snp.makeConstraints { make in
            make.top.equalTo(secondCollectionView.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width / 1.5)
        }
    }
}

extension TopicPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == firstCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstTopicCollectionViewCell", for: indexPath) as! FirstTopicCollectionViewCell
            cell.backgroundColor = .lightGray
            return cell
        } else if collectionView == secondCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondTopicCollectionViewCell", for: indexPath) as! SecondTopicCollectionViewCell
            cell.backgroundColor = .blue
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThirdTopicCollectionViewCell", for: indexPath) as! ThirdTopicCollectionViewCell
            cell.backgroundColor = .green
            return cell
        }
    }
}

