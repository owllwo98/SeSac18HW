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
    
    var goldenList: [PhotoElement] = []
    var businessList: [PhotoElement] = []
    var architectureList: [PhotoElement] = []
    
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
    
    lazy var firstHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "골든 아워"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
        return label
    }()
    
    lazy var secondHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "비즈니스 및 업무"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
        return label
    }()
    
    lazy var thirdHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "건축 및 인테리어"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
        return label
    }()
    
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
        secondCollectionView.register(FirstTopicCollectionViewCell.self, forCellWithReuseIdentifier: "FirstTopicCollectionViewCell")
        thirdCollectionView.register(FirstTopicCollectionViewCell.self, forCellWithReuseIdentifier: "FirstTopicCollectionViewCell")
        
        
        if goldenList.count  == 10 && businessList.count == 10 && architectureList.count == 10 {
            
        } else {
            requestData()
        }
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "back"), style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .black
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
        
        [firstHeaderLabel, secondHeaderLabel, thirdHeaderLabel].forEach {
            contentView.addSubview($0)
        }
        
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
        
        firstHeaderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        firstCollectionView.snp.makeConstraints { make in
            make.top.equalTo(firstHeaderLabel.snp.bottom).inset(-8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width / 1.5)
        }
        
        secondHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(firstCollectionView.snp.bottom).inset(-16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        secondCollectionView.snp.makeConstraints { make in
            make.top.equalTo(secondHeaderLabel.snp.bottom).inset(-8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width / 1.5)
        }
        
        thirdHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(secondCollectionView.snp.bottom).inset(-16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        thirdCollectionView.snp.makeConstraints { make in
            make.top.equalTo(thirdHeaderLabel.snp.bottom).inset(-8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width / 1.5)
            make.bottom.equalToSuperview()
        }
    }
}

extension TopicPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == firstCollectionView {
            return goldenList.count
        } else if collectionView == secondCollectionView {
            return businessList.count
        } else if collectionView == thirdCollectionView {
            return architectureList.count
        }
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstTopicCollectionViewCell", for: indexPath) as! FirstTopicCollectionViewCell
        
        if collectionView == firstCollectionView {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstTopicCollectionViewCell", for: indexPath) as! FirstTopicCollectionViewCell
            cell.configureData(goldenList[indexPath.item])
            DispatchQueue.main.async {
                cell.topicImageView.layer.cornerRadius = 8
                cell.topicImageView.clipsToBounds = true
                cell.starLabel.layer.cornerRadius = 10
                cell.starLabel.clipsToBounds = true
            }
            
            return cell
        } else if collectionView == secondCollectionView {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondTopicCollectionViewCell", for: indexPath) as! SecondTopicCollectionViewCell
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstTopicCollectionViewCell", for: indexPath) as! FirstTopicCollectionViewCell
            cell.configureData(businessList[indexPath.item])
            DispatchQueue.main.async {
                cell.topicImageView.layer.cornerRadius = 8
                cell.topicImageView.clipsToBounds = true
                cell.starLabel.layer.cornerRadius = 10
                cell.starLabel.clipsToBounds = true
            }
            
            return cell
        } else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThirdTopicCollectionViewCell", for: indexPath) as! ThirdTopicCollectionViewCell
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstTopicCollectionViewCell", for: indexPath) as! FirstTopicCollectionViewCell
            cell.configureData(architectureList[indexPath.item])
            DispatchQueue.main.async {
                cell.topicImageView.layer.cornerRadius = 8
                cell.topicImageView.clipsToBounds = true
                cell.starLabel.layer.cornerRadius = 10
                cell.starLabel.clipsToBounds = true
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        let vc = PhotoDetailViewController()
        
        if collectionView == firstCollectionView {
            vc.list = goldenList[indexPath.item]
            self.navigationController?.pushViewController(vc, animated: true)
        } else if collectionView == secondCollectionView {
            vc.list = businessList[indexPath.item]
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            vc.list = architectureList[indexPath.item]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension TopicPhotoViewController {
    func requestData() {
        
        let group = DispatchGroup()
        
        group.enter()
        NetworkManager.shared.request(url: "https://api.unsplash.com/topics/golden-hour/photos?page=1&per_page=10&client_id=\(APIKey.clientID)", T: [PhotoElement].self) { [weak self] (photo: [PhotoElement]) in
            guard let self = self else {return}
            goldenList = photo
            group.leave()
        }
        
        group.enter()
        NetworkManager.shared.request(url: "https://api.unsplash.com/topics/business-work/photos?page=1&per_page=10&client_id=\(APIKey.clientID)", T: [PhotoElement].self) { [weak self] (photo: [PhotoElement]) in
            guard let self = self else {return}
            businessList = photo
            group.leave()
        }
        
        group.enter()
        NetworkManager.shared.request(url:"https://api.unsplash.com/topics/architecture-interior/photos?page=1&per_page=10&client_id=\(APIKey.clientID)", T: [PhotoElement].self) { [weak self] (photo: [PhotoElement]) in
            guard let self = self else {return}
            architectureList = photo
            group.leave()
        }
        
        group.notify(queue: .main) {
            [self.firstCollectionView, self.secondCollectionView, self.thirdCollectionView].forEach {
                $0.reloadData()
            }
        }
    }
}

