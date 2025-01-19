//
//  Extension.swift
//  SeSac18HW
//
//  Created by 변정훈 on 1/19/25.
//

import UIKit

extension UILabel {
    static func updateWithPhotoElement(_ label: UILabel, _ list: PhotoElement) {
        let like: String = list.likes.formatted()
        let space: String = " "
        
        let attributedString = NSMutableAttributedString(string: "")
        
        let imageAttachment = NSTextAttachment()
        let originalImage = UIImage(systemName: "star.fill")
        let tintedImage = originalImage?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        imageAttachment.image = tintedImage
        
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        attributedString.append(NSAttributedString(string: like))
        attributedString.append(NSAttributedString(string: space))
        
        label.attributedText = attributedString
    }
}
