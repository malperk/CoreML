//
//  TestViewModel.swift
//  NLP
//
//  Created by Alper KARATAŞ on 11/10/2017.
//  Copyright © 2017 Coda. All rights reserved.
//

import Foundation

enum NLPType {
    case languageIdentification
    case tokenization
    case lemmatization
}
class TestViewModel {
    let type: NLPType

    init(type: NLPType) {
        self.type = type
    }

    func processText(text: String) -> String {
        switch type {
        case .languageIdentification:
            return getLanguage(text: text)
        case .tokenization:
            return tokenize(text: text)
        case .lemmatization:
            return lemmatize(text: text)
        }
    }
}
