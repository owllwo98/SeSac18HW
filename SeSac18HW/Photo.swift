//
//  Photo.swift
//  SeSac18HW
//
//  Created by 변정훈 on 1/18/25.
//

import Foundation

struct Photo: Decodable {
    let total, total_pages: Int
    let results: [PhotoElement]
}

struct PhotoElement: Decodable {
    let id: String
    let created_at, updated_at: String
    let width, height: Int
    let color: String
    let urls: Urls
    let likes: Int
    let user: User
}

struct Urls: Decodable {
    let raw, small: String
    let thumb: String
}

struct User: Decodable {
    let name: String
    let profile_image: ProfileImage
}

struct ProfileImage: Decodable {
    let small, medium, large: String
}


struct DetailPhoto: Decodable {
    let id, slug: String
    let downloads, views, likes: Downloads
}

struct Downloads: Decodable {
    let total: Int
    let historical: Historical
}

struct Historical: Decodable {
    let change: Int
    let resolution: String
    let quantity: Int
}
