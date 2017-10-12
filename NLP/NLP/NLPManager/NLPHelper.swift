//
//  NLPHelper.swift
//  NLP
//
//  Created by Alper KARATAŞ on 12/10/2017.
//  Copyright © 2017 Coda. All rights reserved.
//

import Foundation

func getLanguage(text: String) -> String {
    let tagger = NSLinguisticTagger(tagSchemes: [.language], options: 0)
    tagger.string = text
    return "Your text language is : \(tagger.dominantLanguage ?? "")"
}

func tokenize(text: String) -> String {
    let tagger = NSLinguisticTagger(tagSchemes: [.tokenType], options: 0)
    tagger.string = text
    let range = NSRange(location: 0, length: text.utf16.count)
    let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace]
    var str = "Tokens: "
    tagger.enumerateTags(in: range, unit: .word, scheme: .tokenType, options: options) { tag, tokenRange, _ in
        let token = (text as NSString).substring(with: tokenRange)
        str += token + ","
    }
    return str
}

func lemmatize(text: String) -> String {
    let tagger = NSLinguisticTagger(tagSchemes:[.lemma], options: 0)
    tagger.string = text
    let range = NSRange(location:0, length: text.utf16.count)
    let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace]
     var str = "Lemmas: "
    tagger.enumerateTags(in: range, unit: .word, scheme: .lemma, options: options) { tag, tokenRange, stop in
        if let lemma = tag?.rawValue {
            str += lemma + ","
        }
    }
    return str
}

