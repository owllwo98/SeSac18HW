//
//  PhotoDetailViewModel.swift
//  SeSac18HW
//
//  Created by 변정훈 on 2/10/25.
//

import Foundation
import Alamofire

class PhotoDetailViewModel: BaseViewModel {
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let photoData: Observable<PhotoElement?> = Observable(nil)
    }
    
    struct Output {
        let profileImage = Observable("")
        let userName = Observable("")
        let date = Observable("")
        let sizeNum = Observable("")
        let viewsNum = Observable(0)
        let downloadNum = Observable(0)
        let detailImage = Observable("")
        
    }
    
    init() {
        input = Input()
        output = Output()
        
        transform()
    }
    
    func transform() {
        input.photoData.bind { value in
            guard let value else {
                return
            }
            
            self.requestData(list: value)
            self.setPhotoDetail(list: value)
        }
    }
    
    private func setPhotoDetail(list: PhotoElement) {
        self.output.profileImage.value = list.user.profile_image.small
        
        self.output.userName.value = list.user.name
        
        self.output.date.value = list.created_at
        
        self.output.sizeNum.value = list.width.formatted() + " X " + list.height.formatted()
        
        self.output.detailImage.value = list.urls.small
        
        
    }
    
    private func requestData(list: PhotoElement) {
        NetworkManager.shared.fetchData(api: PhotoRouter.getStatistics(imageID: list.id), T: DetailPhoto.self) { [weak self] (detailPhoto: DetailPhoto) in
            guard let self = self else {return}
            
            self.output.viewsNum.value = detailPhoto.views.total
            
            self.output.downloadNum.value = detailPhoto.downloads.total
           
            
        } errorCompletion: { error in
           
        }
    }
    
}
