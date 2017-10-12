//
//  MainViewController.swift
//  NLP
//
//  Created by Alper KARATAŞ on 12/10/2017.
//  Copyright © 2017 Coda. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    public override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
        switch indexPath.row {
        case 0:
            vc.viewModel = TestViewModel(type: .languageIdentification)
        case 1:
            vc.viewModel = TestViewModel(type: .tokenization)
        case 2:
            vc.viewModel = TestViewModel(type: .lemmatization)
        default:
            vc.viewModel = TestViewModel(type: .languageIdentification)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
