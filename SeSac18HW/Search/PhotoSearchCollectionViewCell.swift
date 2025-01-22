//
//  PhotoSearchCollectionViewCell.swift
//  SeSac18HW
//
//  Created by 변정훈 on 1/18/25.
//

import UIKit
import SnapKit
import Kingfisher

final class PhotoSearchCollectionViewCell: UICollectionViewCell {
    private let itemImageView: UIImageView = UIImageView()
    private let starLabel: UILabel = UILabel()
    
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
        contentView.addSubview(itemImageView)
        itemImageView.addSubview(starLabel)
    }
    
    private func configureUI() {
        
        starLabel.backgroundColor = .lightGray
        starLabel.textColor = .white
        itemImageView.tintColor = .yellow
        
        itemImageView.layer.cornerRadius = 8
        itemImageView.clipsToBounds = true
        starLabel.layer.cornerRadius = 10
        starLabel.clipsToBounds = true
    }
    
    private func configureLayout() {
        itemImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        starLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    func configureData(_ list: PhotoElement) {
        let url = URL(string: list.urls.thumb)
        itemImageView.kf.setImage(with: url)
        
        UILabel.updateWithPhotoElement(starLabel, list)
        
        let numberFormatter: NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
    
    }
    
}
