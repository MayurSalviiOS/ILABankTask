//
//  HomeModel.swift
//  MayurILATask
//
//  Created by Neosoft on 16/05/22.
//

import Foundation


struct HomeData: Codable {
    let data: [BannerData]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct BannerData: Codable {
    let data: [ListData]
    let bannerImage: String
    
    enum CodingKeys: String, CodingKey {
        case bannerImage
        case data = "contentData"
    }
}

struct ListData: Codable {
    let thumbnailImage,title: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case thumbnailImage
    }
}
