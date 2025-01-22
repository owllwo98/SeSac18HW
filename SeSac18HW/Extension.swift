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

extension Date {
    func toDateHourString() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "HH:mm a"
        let dateString = formatter.string(from: self)
        return dateString
    }
    
    func toDateDayString() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "yyyy년 MM월 dd일 게시됨"
        let dateString = formatter.string(from: self)
        return dateString
    }
    
    func toDayString() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "dd"
        let dateString = formatter.string(from: self)
        return dateString
    }
}

extension String {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        formatter.timeZone = TimeZone(identifier: "KST")
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
    
    func toDate() -> Date? {
        let dateFormatter = Self.dateFormatter
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        return date
    }
}

extension UIViewController {
    static func customAlert(errorMessage: String) -> UIAlertController {
        let saveAlert = UIAlertController(title: "네트워크 오류 발생!", message: errorMessage , preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) { action in
            
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { action in
            
        }
        
        saveAlert.addAction(okAction)
        saveAlert.addAction(cancelAction)

        return saveAlert
    }
}
