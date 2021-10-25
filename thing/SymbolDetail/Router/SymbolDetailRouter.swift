//
//  SymbolDetailRouter.swift
//  thing
//
//  Created by John Pothier on 10/24/21.
//

import Foundation
import UIKit

class SymbolDetailRouter : SymbolDetailPresenterToRouter {
    func showModal(from view: UIViewController) {
        let title = NSLocalizedString("Oh, no!", comment: "")
        let message = NSLocalizedString("You tapped the button.", comment: "")
        let dialog =
            UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Cancel", style: .cancel) { [weak dialog] _ in
            dialog?.dismiss(animated: true)
        }
        dialog.addAction(action)
        
        view.present(dialog, animated: true)
    }
}
