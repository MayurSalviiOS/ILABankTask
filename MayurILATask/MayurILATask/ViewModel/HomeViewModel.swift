//
//  HomeViewModel.swift
//  MayurILATask
//
//  Created by Neosoft on 16/05/22.
//
import Foundation

protocol HomeViewModelType {
    
    func getCarouselData() -> [BannerData]
    func getNumberOfRows(index:Int) -> Int
    func searchData(str:String,index:Int)
    func updateSearch(isSearch:Bool)
}

class HomeViewModel : HomeViewModelType {
    
    private var contentData : [BannerData]?
    private var isSearchActive = false
    private var searchData  : [ListData]?
    
    //MARK: - Initializer
    init(){
        fetchCarouselData()
    }
    
    //MARK: - Helper Function to get Data -
    func getCarouselData() -> [BannerData] {
        if let data = contentData {
            return data
        }
        return [BannerData]()
    }
    
    func getBannerData(index: Int) -> BannerData? {
        if getCarouselData().count > index {
            return getCarouselData()[index]
        }
        return nil
    }
    
    func getListingData(index:Int) -> [ListData]? {
        if isSearchActive, let data = searchData {
            return data
        }
        if let bannerData = getBannerData(index: index) {
            return bannerData.data
        }
        return nil
    }
    
    func getNumberOfRows(index : Int) -> Int {
        if isSearchActive, let data = searchData {
            return data.count
        }
        if let contentData = getListingData(index: index) {
            return contentData.count
        }
        return 0
    }
}

//MARK: - Fetch Data
extension HomeViewModel {
    func fetchCarouselData(){
        do {
            if let bundlePath = Bundle.main.path(forResource: "ImageData",ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let homeData = try JSONDecoder().decode(HomeData.self,from: jsonData)
                contentData = homeData.data
            }
        } catch {
            print(error)
        }
    }
}

//MARK: - Search
extension HomeViewModel {
    
    func searchData(str:String,index:Int) {
        let data = getCarouselData()[index].data
        isSearchActive = true
        searchData = data.filter({ content in
            return content.title.range(of: str, options: .caseInsensitive) != nil
        })
    }
    
    func updateSearch(isSearch:Bool) {
        isSearchActive = isSearch
    }
}
