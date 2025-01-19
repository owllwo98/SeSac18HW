//
//  PhotoSearchCollectionViewCell.swift
//  SeSac18HW
//
//  Created by 변정훈 on 1/18/25.
//

import UIKit
import SnapKit
import Kingfisher

class PhotoSearchCollectionViewCell: UICollectionViewCell {
    let itemImageView: UIImageView = UIImageView()
    let starLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureUI()
        configureLayout()
     
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(itemImageView)
        itemImageView.addSubview(starLabel)
    }
    
    func configureUI() {
        
        starLabel.backgroundColor = .lightGray
        starLabel.textColor = .white
        itemImageView.tintColor = .yellow
    }
    
    func configureLayout() {
        itemImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        starLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    func configureData(_ list: PhotoElement) {
        let url = URL(string: list.urls.raw)
        itemImageView.kf.setImage(with: url)
        
        UILabel.updateWithPhotoElement(starLabel, list)
        
        let numberFormatter: NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
    
    }
    
}
