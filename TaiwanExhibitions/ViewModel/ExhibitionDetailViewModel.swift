//
//  ExhibitionDetailViewModel.swift
//  TaiwanExhibitions
//
//  Created by Chuan-Jie Jhuang on 2022/3/16.
//

import Foundation

class ExhibitionDetailViewModel: NSObject {
    
    let navigationTitle = "詳細資訊"
    var exhibition: ExhibitionModel?
    
    init(exhibition: ExhibitionModel) {
        super.init()
        self.exhibition = exhibition
    }
    
}
