//
//  AppDetailController.swift
//  AppStoreCopy
//
//  Created by Vadim on 27.07.16.
//  Copyright © 2016 Vadim Prosviryakov. All rights reserved.
//

import UIKit

class AppDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var app: App? {
        didSet {
            
            if app?.screenshots != nil {
                return
            }
            
            if let id = app?.id {
                let urlString = "http://www.statsallday.com/appstore/appdetail?id=\(id)"
                
                NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: urlString)!, completionHandler: { (data, responce, error) in
                    if error != nil {
                        return
                    }
                    
                    do {
                        
                let json = try(NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers))
                        
                        let appDetail = App()
                        appDetail.setValuesForKeysWithDictionary(json as! [String: AnyObject])
                        self.app = appDetail
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.collectionView?.reloadData()
                        })
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }).resume()
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.registerClass(AppDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellId)
        collectionView?.registerClass(ScreenshotsCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    private var headerCellId = "headerCellId"
    private var cellId = "cellid"
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerCellId, forIndexPath: indexPath) as! AppDetailHeader
        header.app = app
        return header
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! ScreenshotsCell
        cell.app = app
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(view.frame.width, 170)
    }
}

class AppDetailHeader: BaseCell {
    
    var app: App? {
        didSet {
            if let image = app?.imageName {
                imageView.image = UIImage(named: image)
            }
            nameLabel.text = app?.name
            
            if let price = app?.price?.stringValue {
                button.setTitle("$\(price)", forState: .Normal)
            }
        }
    }
    
    var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .ScaleAspectFill
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()
    
    var nameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.systemFontOfSize(16)
        return name
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .System)
        button.layer.borderColor = UIColor(red: 0, green: 129/255, blue: 250/255, alpha: 1).CGColor
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(14)
        return button
    }()
    
    let segment: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Details", "Reviews", "Related"])
        segment.tintColor = UIColor.darkGrayColor()
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    let separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return separator
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(button)
        addSubview(segment)
        addSubview(separator)
        
        constraintsWithVisualFormatApp("V:|-14-[v0(100)]", views: imageView)
        constraintsWithVisualFormatApp("H:|-14-[v0(100)]-8-[v1]", views: imageView, nameLabel)
        constraintsWithVisualFormatApp("V:|-14-[v0(20)]", views: nameLabel)
        
        constraintsWithVisualFormatApp("V:[v0(32)]-56-|", views: button)
        constraintsWithVisualFormatApp("H:[v0(60)]-14-|", views: button)
        
        constraintsWithVisualFormatApp("H:|-40-[v0]-40-|", views: segment)
        constraintsWithVisualFormatApp("V:[v0(34)]-8-|", views: segment)
        
        constraintsWithVisualFormatApp("H:|[v0]|", views: separator)
        constraintsWithVisualFormatApp("V:[v0(0.5)]|", views: separator)
        
        
    }
}

