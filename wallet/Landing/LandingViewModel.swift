//
//  LandingViewModel.swift
//  wallet
//
//  Created by Kevin Campuzano on 5/2/22.
//

import Foundation
protocol LandingViewModelProtocol {
    var rules:[Item] { get }
    var pad: [Int] { get }
    var valueToDisplay: String { get }
    var valueArray: [Int] { get }
    
    var idealAmountToClose: Double { get }
    
    func viewDidLoad()
    func didSelectItemAt(_ indexPath: IndexPath)
    func eraseButtonTapped()
}

class LandingViewModel: LandingViewModelProtocol {
    weak var view: LandingViewProtocol?
    
    private var fetchPreviousItemsRequest: FetchPreviusItemsRequest

    var rules: [Item] = []
    var pad: [Int] = [1...9].flatMap({ $0 })
    var valueToDisplay: String = "0"
    var valueArray: [Int] = [] {
        didSet {
            view?.eraseButton(isHidden: valueArray.count == 0)
        }
    }
    
    var idealAmountToClose: Double = 0
    
    init(fetchPreviousItemsRequest: FetchPreviusItemsRequest = FetchPreviusItemsRequest()){
        self.fetchPreviousItemsRequest = fetchPreviousItemsRequest
        pad.append(0)
    }
    
    func viewDidLoad() {
        view?.shouldShowLoader(true)
        fetchPreviousItemsRequest.start { [weak self] result in
            self?.view?.shouldShowLoader(false)
            switch result {
            case .success(let rules):
                self?.rules = rules
                break
            case .failure(let error):
                self?.view?.presentError(error: error)
                break
            }
        }
    }
    
    func didSelectItemAt(_ indexPath: IndexPath) {
        let element = pad[indexPath.row]
        setAmountInLabel(element)
    }
    
    fileprivate func setAmountInLabel(_ value:Int){
        if valueArray.count == 0 && value == 0 {
            return
        }
        
        valueArray.append(value)
        renderOnDisplay()
    }
    
    func eraseButtonTapped() {
        if valueArray.count == 0 {
            return
        }
        
        let maxIndex = valueArray.count - 1
        valueArray.remove(at: maxIndex)
        renderOnDisplay()
    }
    
    func renderOnDisplay() {
        var valueToDisplay = "0"
        
        if valueArray.count == 0 {
            view?.renderDisplay("$ \(DecimalMasker().mask(valueToDisplay))")
            return
        }
        
        if valueArray.count == 1 {
            valueToDisplay = "0,0" + "\(valueArray[0])"
            idealAmountToClose = valueToDisplay.convertToDouble()
            view?.renderDisplay("$ \(DecimalMasker().mask(valueToDisplay))")
            return
        }
        
        if valueArray.count == 2 {
            valueToDisplay = "0," + "\(valueArray[0])\(valueArray[1])"
            idealAmountToClose = valueToDisplay.convertToDouble()
            view?.renderDisplay("$ \(DecimalMasker().mask(valueToDisplay))")
            return
        }
        
        valueToDisplay = ""
        for index in 0...(valueArray.count - 1) {
            if index == (valueArray.count - 2)  {
                valueToDisplay += ","
            }
            valueToDisplay += "\(valueArray[index])"
        }
        
        idealAmountToClose = valueToDisplay.convertToDouble()
        view?.renderDisplay("$ \(DecimalMasker().mask(valueToDisplay))")
    }
    
}
