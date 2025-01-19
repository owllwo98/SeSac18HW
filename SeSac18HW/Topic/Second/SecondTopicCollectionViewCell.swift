//
//  SecondTopicCollectionViewCell.swift
//  SeSac18HW
//
//  Created by 변정훈 on 1/19/25.
//

import UIKit
import SnapKit
import Kingfisher

class SecondTopicCollectionViewCell: UICollectionViewCell {
    let topicImageView: UIImageView = UIImageView()
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
        contentView.addSubview(topicImageView)
        topicImageView.addSubview(starLabel)
    }
    
    func configureLayout() {
        topicImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        starLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    func configureUI() {
        starLabel.backgroundColor = .lightGray
        starLabel.textColor = .white
    }
    
    func configureData(_ list: PhotoElement) {
        let url = URL(string: list.urls.raw)
        topicImageView.kf.setImage(with: url)
        
        UILabel.updateWithPhotoElement(starLabel, list)
    }
}
