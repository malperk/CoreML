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

    func testSplitSentencesNumbersEachSentence() {
        XCTAssertEqual(splitSentences(text: "Hello there. How are you? I am fine!"),
                       "Sentences:\n1. Hello there.\n2. How are you?\n3. I am fine!")
    }

    func testSplitSentencesTrimsWhitespaceAndNewlines() {
        XCTAssertEqual(splitSentences(text: "  First line.\n\nSecond line.  "),
                       "Sentences:\n1. First line.\n2. Second line.")
    }

    func testSplitSentencesReturnsOnlyPrefixForEmptyText() {
        XCTAssertEqual(splitSentences(text: ""), "Sentences:")
    }

    func testLanguageHypothesesListsMostLikelyLanguageFirst() {
        let result = languageHypotheses(text: "Hello, how are you today? I hope you are doing well.")
        XCTAssertTrue(result.hasPrefix("Possible languages: en ("), result)
    }

    func testLanguageHypothesesRecognizesTurkish() {
        let result = languageHypotheses(text: "Merhaba, bugün nasılsın? Umarım iyisindir.")
        XCTAssertTrue(result.hasPrefix("Possible languages: tr ("), result)
    }

    func testLanguageHypothesesReturnsAtMostMaximumLanguages() {
        let result = languageHypotheses(text: "Hello, how are you today?", maximum: 2)
        let entries = result.components(separatedBy: "%),").count - 1
        XCTAssertGreaterThan(entries, 0, result)
        XCTAssertLessThanOrEqual(entries, 2, result)
    }

    func testLanguageHypothesesReturnsOnlyPrefixForEmptyText() {
        XCTAssertEqual(languageHypotheses(text: ""), "Possible languages: ")
    }
}
