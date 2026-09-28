//
//  TestViewModelTests.swift
//  NLPTests
//

import XCTest
@testable import NLP

class TestViewModelTests: XCTestCase {
    let sampleText = "The children were running to their houses."

    func testLanguageIdentificationUsesGetLanguage() {
        let viewModel = TestViewModel(type: .languageIdentification)
        XCTAssertEqual(viewModel.processText(text: sampleText), getLanguage(text: sampleText))
    }

    func testTokenizationUsesTokenize() {
        let viewModel = TestViewModel(type: .tokenization)
        XCTAssertEqual(viewModel.processText(text: sampleText), tokenize(text: sampleText))
    }

    func testLemmatizationUsesLemmatize() {
        let viewModel = TestViewModel(type: .lemmatization)
        XCTAssertEqual(viewModel.processText(text: sampleText), lemmatize(text: sampleText))
    }
}
