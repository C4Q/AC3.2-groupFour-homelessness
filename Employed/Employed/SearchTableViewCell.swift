//
//  SearchTableViewCell.swift
//  Employed
//
//  Created by Kadell on 2/18/17.
//  Copyright © 2017 Employed Inc. All rights reserved.
//

import UIKit
import SnapKit

class SearchTableViewCell: UITableViewCell {
    
    var jobLabel = UILabel()
    var subLabel = UILabel()
    var agencyLabel = UILabel()
    var companyIcon = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Labels
        jobLabel.textColor = .black
        jobLabel.font = UIFont.systemFont(ofSize: 15.0, weight: 10.0)
        jobLabel.sizeToFit()
        jobLabel.adjustsFontSizeToFitWidth = false
        jobLabel.numberOfLines = 2
        jobLabel.textAlignment = .center
        
        agencyLabel.textColor = .black
        agencyLabel.font = UIFont.systemFont(ofSize: 14)
        
        subLabel.textColor = UIColor.lightGray
        subLabel.font = UIFont.systemFont(ofSize: 13)
        
        companyIcon.image = UIImage(named: "monster")
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.addSubview(jobLabel)
        self.contentView.addSubview(subLabel)
        self.contentView.addSubview(agencyLabel)
        self.contentView.addSubview(companyIcon)
        
        
        jobLabel.snp.makeConstraints { (view) in
            view.top.equalToSuperview().offset(16.0)
            view.leading.equalToSuperview().offset(12.0)
            //view.centerX.equalToSuperview()
        }
        
        agencyLabel.snp.makeConstraints { (view) in
            view.top.equalTo(jobLabel.snp.bottom).offset(8.0)
            view.leading.equalToSuperview().offset(12.0)
            //view.centerX.equalToSuperview()
        }
        
        subLabel.snp.makeConstraints { (view) in
            view.top.equalTo(agencyLabel.snp.bottom).offset(8.0)
            view.leading.equalToSuperview().offset(12.0)
            //view.centerX.equalToSuperview()
        }
        
        companyIcon.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalTo(subLabel.snp.bottom).offset(10.0)
        }
    }
    
    
    
    

}
