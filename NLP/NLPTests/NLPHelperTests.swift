//
//  NLPHelperTests.swift
//  NLPTests
//

import XCTest
@testable import NLP

class NLPHelperTests: XCTestCase {

    func testGetLanguageIdentifiesEnglish() {
        XCTAssertEqual(getLanguage(text: "Hello, how are you today?"), "Your text language is : en")
    }

    func testGetLanguageIdentifiesTurkish() {
        XCTAssertEqual(getLanguage(text: "Merhaba, bugün nasılsın?"), "Your text language is : tr")
    }

    func testGetLanguageReturnsEmptyLanguageForEmptyText() {
        XCTAssertEqual(getLanguage(text: ""), "Your text language is : ")
    }

    func testTokenizeOmitsPunctuationAndWhitespace() {
        XCTAssertEqual(tokenize(text: "Hello world, again!"), "Tokens: Hello,world,again,")
    }

    func testTokenizeReturnsOnlyPrefixForEmptyText() {
        XCTAssertEqual(tokenize(text: ""), "Tokens: ")
    }

    func testLemmatizeReducesWordsToDictionaryForm() throws {
        // The iOS Simulator ships without the lemma tagging assets, so lemmatize returns no lemmas there.
        try XCTSkipUnless(NSLinguisticTagger.availableTagSchemes(for: .word, language: "en").contains(.lemma),
                          "Lemma tagging is not available on this device")
        XCTAssertEqual(lemmatize(text: "The children were running to their houses."),
                       "Lemmas: the,child,be,run,to,their,house,")
    }
}
