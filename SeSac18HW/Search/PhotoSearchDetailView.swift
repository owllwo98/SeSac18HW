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
        button.tintColor = .black
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
   
    let blackButton = PhotoSearchDetailView.createButton(title: " 블랙  ", tag: 0, color: .black)
    let whiteButton = PhotoSearchDetailView.createButton(title: "  화이트  ", tag: 1, color: .white)
    let yellowButton = PhotoSearchDetailView.createButton(title: "  옐로우  ", tag: 2, color: .yellow)
    let redButton = PhotoSearchDetailView.createButton(title: "  레드  ", tag: 3, color: .red)
    let purpleButton = PhotoSearchDetailView.createButton(title: "  퍼플  ", tag: 4, color: .purple)
    let greenButton = PhotoSearchDetailView.createButton(title: "  그린  ", tag: 5, color: .green)
    let blueButton = PhotoSearchDetailView.createButton(title: "  블루  ", tag: 6, color: .blue)
    
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
      
       
        
        [blackButton, whiteButton, yellowButton, redButton, purpleButton, greenButton, blueButton].forEach {
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
        
        blackButton.backgroundColor = .blue
        blackButton.setTitleColor(.white, for: .normal)
        
        
        colorScrollView.backgroundColor = .white
        
        
        shoppingSearchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "키워드 검색", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 0.51, green: 0.51, blue: 0.537, alpha: 1)])
        
        mainLabel.text = "사진을 검색해보세요"
        mainLabel.textColor = .black
        mainLabel.font = .systemFont(ofSize: 24, weight: .bold)
    }
    
    private static func createButton(title: String, tag: Int, color: UIColor) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.945, alpha: 1)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        button.tintColor = color
        button.tag = tag
        
        return button
    }
}
