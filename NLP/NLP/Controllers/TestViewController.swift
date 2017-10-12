//
//  TestViewController.swift
//  NLP
//
//  Created by Alper KARATAŞ on 11/10/2017.
//  Copyright © 2017 Coda. All rights reserved.
//

import UIKit

class TestViewController: UIViewController,UITextViewDelegate {
    @IBOutlet weak var inputText: UITextView!
    @IBOutlet weak var outputText: UITextView!
    
    var viewModel:TestViewModel!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputText.delegate = self
    }
    public func textViewDidChange(_ textView: UITextView){
        outputText.text = viewModel.processText(text: textView.text)
    }
}
