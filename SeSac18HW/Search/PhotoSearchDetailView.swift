//
//  PhotoSearchDetailView.swift
//  SeSac18HW
//
//  Created by 변정훈 on 1/18/25.
//

import UIKit
import SnapKit

class PhotoSearchDetailView: BaseView {
    
    let colorScrollView: UIScrollView = UIScrollView()
    let stackView = UIStackView()
    let titleView: UIView = UIView()
    lazy var orderButton: UIButton = {
        let button = UIButton()
        button.setTitle(" 관련순", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(systemName: "book"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        
        return button
    }()
    
    lazy var shoppingSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.textColor = .black
        searchBar.barTintColor = .white
        
        return searchBar
    }()
    
    let standardButton = PhotoSearchDetailView.createButton(title: "  정확도  ", tag: 0)
    let dateSortButton = PhotoSearchDetailView.createButton(title: "  날짜순  ", tag: 1)
    let highPriceSortButton = PhotoSearchDetailView.createButton(title: "  가격높은순  ", tag: 2)
    let lowPriceSortButton = PhotoSearchDetailView.createButton(title: "  가격낮은순  agagagagagagagagagagaggagagagagagagagagaga", tag: 3)
    
    let mainLabel: UILabel = UILabel()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 2, height: UIScreen.main.bounds.width / 1.5)
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override func configureHierarchy() {
        addSubview(shoppingSearchBar)
        addSubview(colorScrollView)
        addSubview(orderButton)
        
        colorScrollView.addSubview(stackView)
        
        addSubview(titleView)
        titleView.addSubview(collectionView)
        titleView.addSubview(mainLabel)
      
       
        
        [standardButton, dateSortButton, highPriceSortButton, lowPriceSortButton].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    override func configureLayout() {
        shoppingSearchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        orderButton.snp.makeConstraints { make in
            make.top.equalTo(shoppingSearchBar.snp.bottom).inset(-8)
            make.trailing.equalToSuperview()
            make.height.equalTo(28)
        }
        
        colorScrollView.snp.makeConstraints { make in
            make.top.equalTo(shoppingSearchBar.snp.bottom).inset(-8)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.height.equalTo(28)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(colorScrollView)
            make.height.equalTo(28)
        }
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(colorScrollView.snp.bottom
            ).inset(-4)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        mainLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        stackView.spacing = 8
        
        standardButton.backgroundColor = .blue
        standardButton.setTitleColor(.white, for: .normal)
        
        
        colorScrollView.backgroundColor = .white
        
        
        shoppingSearchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "키워드 검색", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 0.51, green: 0.51, blue: 0.537, alpha: 1)])
        
        mainLabel.text = "사진을 검색해보세요"
        mainLabel.textColor = .black
        mainLabel.font = .systemFont(ofSize: 24, weight: .bold)
    }
    
    private static func createButton(title: String, tag: Int) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.945, alpha: 1)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.tag = tag
        
        return button
    }
}
