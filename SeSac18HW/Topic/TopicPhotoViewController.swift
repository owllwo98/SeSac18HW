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

class TopicPhotoViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "OUR TOPIC"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    let verticalScrollView: UIScrollView = UIScrollView()
    
    
    let firstTopicScrollView: UIScrollView = UIScrollView()
    let secondTopicScrollView: UIScrollView = UIScrollView()
    let thirdTopicScrollView: UIScrollView = UIScrollView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {
        view.addSubview(verticalScrollView)
        [firstTopicScrollView, secondTopicScrollView, thirdTopicScrollView].forEach {
            verticalScrollView.addSubview($0)
        }
        
    }
    func configureLayout() {
        
    }
    
    
    func configureView() {
        
    }
    
    
}
