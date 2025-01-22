//
//  VideoCollectionViewCell.swift
//  SeSac18HW
//
//  Created by 변정훈 on 1/21/25.
//

import UIKit
import SnapKit
import Kingfisher

final class VideoCollectionViewCell: UICollectionViewCell {
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
    
    
    private func configureHierarchy() {
        contentView.addSubview(topicImageView)
        topicImageView.addSubview(starLabel)
    }
    
    private func configureLayout() {
        topicImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        starLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    private func configureUI() {
        starLabel.backgroundColor = .lightGray
        starLabel.textColor = .white
        
        topicImageView.layer.cornerRadius = 8
        topicImageView.clipsToBounds = true
        starLabel.layer.cornerRadius = 10
        starLabel.clipsToBounds = true
    }
    
    func configureData(_ list: PhotoElement) {
        let url = URL(string: list.urls.thumb)
        topicImageView.kf.setImage(with: url)
        
        UILabel.updateWithPhotoElement(starLabel, list)
    }
}
