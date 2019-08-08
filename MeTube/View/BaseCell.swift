//
//  BaseCell.swift
//  MeTube
//
//  Created by Abdulaziz AlObaili on 08/08/2019.
//  Copyright © 2019 Abdulaziz Alobaili. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
}
