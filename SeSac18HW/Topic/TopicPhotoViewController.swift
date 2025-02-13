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

final class TopicPhotoViewController: UIViewController {
    
    private var firstList: [PhotoElement] = []
    private var secondList: [PhotoElement] = []
    private var thirdList: [PhotoElement] = []
    
    private let categories = [
        "architecture-interior","golden-hour","wallpapers","nature","3d-renders","travel","textures-patterns","street-photography","film","archival","experimental","animals","fashion-beauty","people","business-work","food-drink"
    ].shuffled()
    
    lazy var randomCategories: [String] = [categories[0], categories[1], categories[2]]
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "OUR TOPIC"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let verticalScrollView: UIScrollView = UIScrollView()
    private let contentView = UIView()
    
    lazy var firstCollectionView: UICollectionView = createHorizontalCollectionView()
    lazy var secondCollectionView: UICollectionView = createHorizontalCollectionView()
    lazy var thirdCollectionView: UICollectionView = createHorizontalCollectionView()
    
    lazy var firstHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = randomCategories[0]
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
        return label
    }()
    
    lazy var secondHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = randomCategories[1]
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
        return label
    }()
    
    lazy var thirdHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = randomCategories[2]
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
        
        
        if firstList.count  == 10 && secondList.count == 10 && thirdList.count == 10 {
            
        } else {
            requestData()
        }
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "back"), style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func createHorizontalCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 2, height: UIScreen.main.bounds.width / 1.5)
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        return collectionView
    }
    
    private func configureHierarchy() {
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
    
    private func configureLayout() {
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
            return firstList.count
        } else if collectionView == secondCollectionView {
            return secondList.count
        } else if collectionView == thirdCollectionView {
            return thirdList.count
        }
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstTopicCollectionViewCell", for: indexPath) as! FirstTopicCollectionViewCell
        
        if collectionView == firstCollectionView {
            cell.configureData(firstList[indexPath.item])
            return cell
        } else if collectionView == secondCollectionView {
            cell.configureData(secondList[indexPath.item])
            return cell
        } else {
            cell.configureData(thirdList[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        let vc = PhotoDetailViewController()
        
        if collectionView == firstCollectionView {
//            vc.list = firstList[indexPath.item]
            vc.viewModel.input.photoData.value = firstList[indexPath.item]
            self.navigationController?.pushViewController(vc, animated: true)
        } else if collectionView == secondCollectionView {
//            vc.list = secondList[indexPath.item]
            vc.viewModel.input.photoData.value = secondList[indexPath.item]
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
//            vc.list = thirdList[indexPath.item]
            vc.viewModel.input.photoData.value = thirdList[indexPath.item]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension TopicPhotoViewController {
    private func requestData() {
        
        let group = DispatchGroup()
        
        group.enter()
        NetworkManager.shared.fetchData(api: PhotoRouter.getTopic(topicID: randomCategories[0]), T: [PhotoElement].self) { [weak self] T in
            guard let self = self else {return}
            firstList = T
            group.leave()
        } errorCompletion: { error in
            self.present(UIViewController.customAlert(errorMessage: NetWorkError(rawValue: error)?.message ?? ""), animated: true)
        }
        
        group.enter()
        NetworkManager.shared.fetchData(api: PhotoRouter.getTopic(topicID: randomCategories[1]), T: [PhotoElement].self) { [weak self] T in
            guard let self = self else {return}
            secondList = T
            group.leave()
        } errorCompletion: { error in
            self.present(UIViewController.customAlert(errorMessage: NetWorkError(rawValue: error)?.message ?? ""), animated: true)
        }
        
        group.enter()
        NetworkManager.shared.fetchData(api: PhotoRouter.getTopic(topicID: randomCategories[2]), T: [PhotoElement].self) { [weak self] T in
            guard let self = self else {return}
            thirdList = T
            group.leave()
        } errorCompletion: { error in
            self.present(UIViewController.customAlert(errorMessage: NetWorkError(rawValue: error)?.message ?? ""), animated: true)
        }
        
        group.notify(queue: .main) {
            [self.firstCollectionView, self.secondCollectionView, self.thirdCollectionView].forEach {
                $0.reloadData()
            } 
        }
    }
}

