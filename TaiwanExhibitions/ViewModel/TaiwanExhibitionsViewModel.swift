//
//  TaiwanExhibitionsViewModel.swift
//  TaiwanExhibitions
//
//  Created by Chuan-Jie Jhuang on 2022/3/16.
//

import Foundation

protocol TaiwanExhibitionsViewModelDelegate {
    func allExhibitionsAPIFetching()
    func allExhibitionsAPIFetchSuccess()
    func allExhibitionsAPIFetchFailure(error: Error)
}

class TaiwanExhibitionsViewModel: NSObject {
    
    private struct ViewConstants {
        static let navigationTitle = "展覽資訊"
    }
    
    let navigationTitle = ViewConstants.navigationTitle
    var allExhibitions: [ExhibitionModel]?
    
    var delegate: TaiwanExhibitionsViewModelDelegate?
    
    func fetchAllExhibitions() {
        delegate?.allExhibitionsAPIFetching()
        API().fetchAllExhibitions { [weak self](data: Data) in
            do {
                self?.allExhibitions = try JSONDecoder().decode([ExhibitionModel].self, from: data)
//                print("self.allExhibitions: \(String(describing: self?.allExhibitions))")
                self?.delegate?.allExhibitionsAPIFetchSuccess()
            } catch {
                print("json decode error: \(error)")
                self?.delegate?.allExhibitionsAPIFetchFailure(error: error)
            }
        } fail: { [weak self](error: Error) in
            print("API error: \(error)")
            self?.delegate?.allExhibitionsAPIFetchFailure(error: error)
        }
    }
}
