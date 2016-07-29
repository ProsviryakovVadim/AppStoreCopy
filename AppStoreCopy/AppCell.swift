//
//  AppCell.swift
//  AppStoreCopy
//
//  Created by Vadim on 24.07.16.
//  Copyright © 2016 Vadim Prosviryakov. All rights reserved.
//

import UIKit

class AppCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    var app: App? {
        didSet {
            if let image = app?.imageName {
                imageView.image = UIImage(named: image)
            }
            if let name = app?.name {
                nameLabel.text = name
                
                let rect = NSString(string: name).boundingRectWithSize(CGSizeMake(frame.width, 1000), options: NSStringDrawingOptions.UsesFontLeading.union(NSStringDrawingOptions.UsesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14)], context: nil)
                
                if rect.height > 20 {
                    categoryName.frame = CGRectMake(0, frame.width + 38, frame.width, 20)
                    priceLabel.frame = CGRectMake(0, frame.width + 56, frame.width, 20)
                } else {
                    categoryName.frame = CGRectMake(0, frame.width + 22, frame.width, 20)
                    priceLabel.frame = CGRectMake(0, frame.width + 40, frame.width, 20)
                }
                
                nameLabel.frame = CGRectMake(0, frame.width + 5, frame.width, 40)
                nameLabel.sizeToFit()
            }
            if let category = app?.category {
                categoryName.text = category
            }
            if let price = app?.price?.stringValue {
                priceLabel.text = "$\(price)"
            } else {
                priceLabel.text = ""
            }
        }
    }
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "frozen")
        image.layer.cornerRadius = 16
        image.layer.masksToBounds = true
        image.contentMode = .ScaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let nameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.systemFontOfSize(14)
        name.text = "Disney Build It: Frozen"
        name.numberOfLines = 2
        return name
    }()
    
    let categoryName: UILabel = {
        let category = UILabel()
        category.translatesAutoresizingMaskIntoConstraints = false
        category.text = "Entertainment"
        category.font = UIFont.systemFontOfSize(13)
        category.textColor = UIColor.darkGrayColor()
        return category
    }()
    
    let priceLabel: UILabel = {
        let price = UILabel()
        price.translatesAutoresizingMaskIntoConstraints = false
        price.text = "$3.99"
        price.font = UIFont.systemFontOfSize(13)
        price.textColor = UIColor.darkGrayColor()
        return price
    }()
    
    func setupViews() {
        backgroundColor = UIColor.whiteColor()
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(categoryName)
        addSubview(priceLabel)
    
        imageView.frame = CGRectMake(0, 0, frame.width, frame.width)
        nameLabel.frame = CGRectMake(0, frame.width + 2, frame.width, 40)
        categoryName.frame = CGRectMake(0, frame.width + 38, frame.width, 20)
        priceLabel.frame = CGRectMake(0, frame.width + 56, frame.width, 20)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

