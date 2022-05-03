//
//  ViewController.swift
//  wallet
//
//  Created by Kevin Campuzano on 1/14/22.
//

import UIKit
protocol LandingViewProtocol: BaseViewProtocol {
    func renderDisplay(_ text: String)
    func eraseButton(isHidden: Bool)
    func presentError(error:Error)
}

class LandingViewController: BaseViewController {
    
    @IBOutlet weak var numberPadCollectionView: UICollectionView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var eraseButton: UIButton!
    
    var viewModel: LandingViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LandingViewModel()
        viewModel?.view = self
        viewModel?.viewDidLoad()
        eraseButton.isHidden = true
    }
    
    @IBAction func didTapContinueButton(_ sender: UIButton) {
        performSegue(withIdentifier: "showBudgetVC", sender: self)
    }
    
    @IBAction func didTapEraseButton(_ sender: UIButton) {
        viewModel?.eraseButtonTapped()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cashVC = segue.destination as? CashViewController ,
              let viewModel = self.viewModel else {
            return
            
        }
        let cashViewModel = CashViewModel(idealAmountToClose: viewModel.idealAmountToClose,
                                         rules: viewModel.rules)
        cashViewModel.view = cashVC
        cashVC.viewModel = cashViewModel
    }
}


extension LandingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let pad = viewModel?.pad else {
            fatalError("Missing Pad")
        }
        return pad.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let element = viewModel?.pad[indexPath.row]
        let numberCell = numberPadCollectionView.dequeueReusableCell(withReuseIdentifier: NumberCell.identifier ,
                                                                     for: indexPath) as! NumberCell
        numberCell.number = element
        return numberCell
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        viewModel?.didSelectItemAt(indexPath)
    }
    
}

extension LandingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/3.0
        let yourHeight = yourWidth
        
        guard let pad = viewModel?.pad else {
            fatalError("Missing Pad")
        }
        
        if indexPath.row == (pad.count - 1) {
            let spaceBetweenCell :CGFloat = 0
            let screenWidth = collectionView.bounds.width - CGFloat(2 * spaceBetweenCell)
            let totalSpace = spaceBetweenCell * 1.0
            return CGSize(width: screenWidth , height: (screenWidth-totalSpace)/3) // all Width and  same previous height
        }
        
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension LandingViewController: LandingViewProtocol {
    func renderDisplay(_ text: String) {
        amountLabel.text = text
    }
    
    func eraseButton(isHidden: Bool) {
        eraseButton.isHidden = isHidden
    }
    
    func presentError(error: Error) {
        let alertController = UIAlertController(title: "Aviso",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
               let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
               alertController.addAction(defaultAction)
               self.present(alertController, animated: true, completion: nil)
    }
}
