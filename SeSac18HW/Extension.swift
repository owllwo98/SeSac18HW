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
        
        let attributedString = NSMutableAttributedString(string: "")
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "star")
        
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        attributedString.append(NSAttributedString(string: like))
        
        label.attributedText = attributedString
    }
}
