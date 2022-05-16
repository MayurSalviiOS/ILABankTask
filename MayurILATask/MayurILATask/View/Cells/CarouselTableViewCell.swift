//
//  CarouselTableViewCell.swift
//  MayurILATask
//
//  Created by Neosoft on 16/05/22.
//

import UIKit

class CarouselTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets -
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionViewCarousel: UICollectionView!
    
    let identifier = "HomeCarouselCollectionViewCell"
    var bannerData:[BannerData]?
    
    //MARK: - Callback function
    
    var updateListData: ((Int) -> Void)?
    
    //MARK: - Life Cycle -
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView(){
        collectionViewCarousel.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
}

//MARK: - UICollectionView Data Source
extension CarouselTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = bannerData {
            pageControl.numberOfPages = data.count
            return data.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! HomeCarouselCollectionViewCell
        if let data = bannerData {
            cell.imgContent.image =  UIImage(named: data[indexPath.row].bannerImage)
        }
        return cell
    }
}

//MARK: - UICollectionView Delegate
extension CarouselTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        return size
    }
}

extension CarouselTableViewCell {
    
    //MARK: - ScrollView Delegates
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: collectionViewCarousel.contentOffset, size: collectionViewCarousel.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = collectionViewCarousel.indexPathForItem(at: visiblePoint) {
            let index = visibleIndexPath.row
            if index != pageControl.currentPage {
                pageControl.currentPage = index
                updateListData?(index)
            }
        }
    }
}
