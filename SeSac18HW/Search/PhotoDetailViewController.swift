//
//  PhotoDetailViewController.swift
//  SeSac18HW
//
//  Created by 변정훈 on 1/19/25.
//

import UIKit
import SnapKit
import Kingfisher

class PhotoDetailViewController: UIViewController {
    
    let viewModel = PhotoDetailViewModel()
    
    private let imageScrollView: UIScrollView = UIScrollView()
    
    lazy var profileImage: UIImageView = {
        let image = UIImageView()
        DispatchQueue.main.async {
            image.layer.cornerRadius = image.frame.width / 2
            image.clipsToBounds = true
        }
        
        return image
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    lazy var detailImageView: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    lazy var informationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.text = "정보"
        
        return label
    }()
    
    private let labelStackView = UIStackView()
    private let numberStackView = UIStackView()
    
    private let sizeLabel = PhotoDetailViewController.createLabel(title: "크기")
    private let viewsLabel = PhotoDetailViewController.createLabel(title: "조회수")
    private let downloadLabel = PhotoDetailViewController.createLabel(title: "다운로드")
    
    private var sizeNumLabel = PhotoDetailViewController.createLabel(title: "" )
    private var viewsNumLabel = PhotoDetailViewController.createLabel(title: "" )
    private var downloadNumLabel = PhotoDetailViewController.createLabel(title: "" )
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        view.backgroundColor = .white
        
        configureHierarchy()
        configureLayout()
        configureUI()
        
        navigationController?.navigationBar.isHidden = false
        
        bindData()
        
    }
    
    func bindData() {
        viewModel.output.profileImage.bind { value in
            let profileUrl = URL(string: value)
            
            self.profileImage.kf.setImage(with: profileUrl)
        }
        
        viewModel.output.userName.bind { value in
            self.userNameLabel.text = value
        }
        
        viewModel.output.date.bind { value in
            self.dateLabel.text = value
        }
        
        viewModel.output.detailImage.bind { value in
            let imageUrl = URL(string: value)
            self.detailImageView.kf.setImage(with: imageUrl)
        }
        
        viewModel.output.sizeNum.bind { value in
            self.sizeNumLabel.text = value
        }
        
        viewModel.output.viewsNum.bind { value in
            self.viewsNumLabel.text = value.formatted()
        }
        
        viewModel.output.downloadNum.bind { value in
            self.downloadNumLabel.text = value.formatted()
        }
    }
    
    private func configureHierarchy() {
        view.addSubview(profileImage)
        view.addSubview(userNameLabel)
        view.addSubview(dateLabel)
        view.addSubview(informationLabel)
        
        view.addSubview(imageScrollView)
        imageScrollView.addSubview(detailImageView)
        
        
        view.addSubview(labelStackView)
        [sizeLabel, viewsLabel, downloadLabel].forEach {
            labelStackView.addArrangedSubview($0)
        }
        
        view.addSubview(numberStackView)
        [sizeNumLabel, viewsNumLabel, downloadNumLabel].forEach {
            numberStackView.addArrangedSubview($0)
            $0.textAlignment = .right
        }
    }
    
    private func configureLayout() {
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.leading.equalToSuperview().inset(8)
            make.size.equalTo(32)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(profileImage.snp.trailing).inset(-8)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).inset(4)
            make.leading.equalTo(profileImage.snp.trailing).inset(-8)
        }
        
        imageScrollView.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).inset(-8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(240)
        }
        
        detailImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        informationLabel.snp.makeConstraints { make in
            make.top.equalTo(imageScrollView.snp.bottom).inset(-16)
            make.leading.equalToSuperview().inset(16)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(imageScrollView.snp.bottom).inset(-18)
            make.leading.equalTo(informationLabel.snp.trailing).inset(-48)
        }
        
        numberStackView.snp.makeConstraints { make in
            make.top.equalTo(imageScrollView.snp.bottom).inset(-18)
            make.trailing.equalToSuperview().inset(16)
        }
        
        labelStackView.spacing = 8
        labelStackView.axis = .vertical
        
        numberStackView.spacing = 8
        numberStackView.axis = .vertical
 
    }
    
    private func configureUI() {
      
    }
    
    
    private static func createLabel(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
      
        return label
    }
}
