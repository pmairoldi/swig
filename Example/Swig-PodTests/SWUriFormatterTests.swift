//
//  SWUriFormatterTests.swift
//  Swig
//
//  Created by Pierre-Marc Airoldi on 2015-01-29.
//  Copyright (c) 2015 Pierre-Marc Airoldi. All rights reserved.
//

import UIKit
import XCTest

class SWUriFormatterTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testNilString() {
   
        let testReturn = SWUriFormatter.contactFromURI(nil)
        
        XCTAssert((testReturn.name == "" && testReturn.address == ""), "epected: {name = \"\", address = \"\"} actual: {name = \(testReturn.name), address = \(testReturn.address)}")
    }
    
    func testEmptyString() {
        
        let testReturn = SWUriFormatter.contactFromURI("")
        
        XCTAssert((testReturn.name == "" && testReturn.address == ""), "epected: {name = \"\", address = \"\"} actual: {name = \(testReturn.name), address = \(testReturn.address)}")
    }
    
    func testProperAddress() {
     
        let testReturn = SWUriFormatter.contactFromURI("test@sip.com")
        
        XCTAssert((testReturn.name == "" && testReturn.address == "test@sip.com"), "epected: {name = \"\", address = \"test@sip.com\"} actual: {name = \(testReturn.name), address = \(testReturn.address)}")
    }
    
    func testProperAddressWithPrefix() {
        
        let testReturn = SWUriFormatter.contactFromURI("<sip:test@sip.com>")
        
        XCTAssert((testReturn.name == "" && testReturn.address == "test@sip.com"), "epected: {name = \"\", address = \"test@sip.com\"} actual: {name = \(testReturn.name), address = \(testReturn.address)}")
    }

    func testProperAddressWithPrefixWithoutBraces() {
        
        let testReturn = SWUriFormatter.contactFromURI("sip:test@sip.com")
        
        XCTAssert((testReturn.name == "" && testReturn.address == "test@sip.com"), "epected: {name = \"\", address = \"test@sip.com\"} actual: {name = \(testReturn.name), address = \(testReturn.address)}")
    }
    
    func testProperNameAndAddress() {
        
        let testReturn = SWUriFormatter.contactFromURI("\"test\" <sip:test@sip.com>")
        
        XCTAssert((testReturn.name == "test" && testReturn.address == "test@sip.com"), "epected: {name = \"test\", address = \"test@sip.com\"} actual: {name = \(testReturn.name), address = \(testReturn.address)}")
    }
    
    func testProperNameAndAddressWithoutSpaces() {
        
        let testReturn = SWUriFormatter.contactFromURI("\"test\"<sip:test@sip.com>")
        
        XCTAssert((testReturn.name == "test" && testReturn.address == "test@sip.com"), "epected: {name = \"test\", address = \"test@sip.com\"} actual: {name = \(testReturn.name), address = \(testReturn.address)}")
    }
    
    func testProperNameAndAddressWithoutQuotes() {
        
        let testReturn = SWUriFormatter.contactFromURI("test<sip:test@sip.com>")
        
        XCTAssert((testReturn.name == "test" && testReturn.address == "test@sip.com"), "epected: {name = \"test\", address = \"test@sip.com\"} actual: {name = \(testReturn.name), address = \(testReturn.address)}")
    }
    
    func testProperNameAndAddressWithNoSpacesWithoutQuotes() {
        
        let testReturn = SWUriFormatter.contactFromURI("test<sip:test@sip.com>")
        
        XCTAssert((testReturn.name == "test" && testReturn.address == "test@sip.com"), "epected: {name = \"test\", address = \"test@sip.com\"} actual: {name = \(testReturn.name), address = \(testReturn.address)}")
    }
    
    func testEmptyNameAndAddress() {
        
        let testReturn = SWUriFormatter.contactFromURI("\"\" <sip:test@sip.com>")
        
        XCTAssert((testReturn.name == "" && testReturn.address == "test@sip.com"), "epected: {name = \"\", address = \"test@sip.com\"} actual: {name = \(testReturn.name), address = \(testReturn.address)}")
    }
    
    func testEmptyNameAndAddressWithoutSpaces() {
        
        let testReturn = SWUriFormatter.contactFromURI("\"\"<sip:test@sip.com>")
        
        XCTAssert((testReturn.name == "" && testReturn.address == "test@sip.com"), "epected: {name = \"\", address = \"test@sip.com\"} actual: {name = \(testReturn.name), address = \(testReturn.address)}")
    }
    
    func testBraceInName() {
        
        let testReturn = SWUriFormatter.contactFromURI("\"<\"<sip:test@sip.com>")
        
        XCTAssert((testReturn.name == "<" && testReturn.address == "test@sip.com"), "epected: {name = \"<\", address = \"test@sip.com\"} actual: {name = \(testReturn.name), address = \(testReturn.address)}")
    }
    
    func testAddressWithBraces() {
        
        let testReturn = SWUriFormatter.contactFromURI("<test@sip.com>")
        
        XCTAssert((testReturn.name == "" && testReturn.address == "test@sip.com"), "epected: {name = \"\", address = \"test@sip.com\"} actual: {name = \(testReturn.name), address = \(testReturn.address)}")
    }
    
    func testNameWithBraces() {
        
        let testReturn = SWUriFormatter.contactFromURI("<name>test@sip.com")
        
        XCTAssert((testReturn.name == "" && testReturn.address == "name"), "epected: {name = \"\", address = \"name\"} actual: {name = \(testReturn.name), address = \(testReturn.address)}")
    }
    
    func testNameAndAddressWithBraces() {
        
        let testReturn = SWUriFormatter.contactFromURI("<name><test@sip.com>")
        
        XCTAssert((testReturn.name == "" && testReturn.address == "name"), "epected: {name = \"\", address = \"name\"} actual: {name = \(testReturn.name), address = \(testReturn.address)}")
    }
    
    func testNameWithBracesInQuotes() {
        
        let testReturn = SWUriFormatter.contactFromURI("\"<name>\"test@sip.com")
        
        XCTAssert((testReturn.name == "" && testReturn.address == "nametest@sip.com"), "epected: {name = \"\", address = \"nametest@sip.com\"} actual: {name = \(testReturn.name), address = \(testReturn.address)}")
    }
    
    func testNameWithBracesInQuotesAndAddressInBracesWithPrefix() {
        
        let testReturn = SWUriFormatter.contactFromURI("\"<name>\"<sip:test@sip.com>")
        
        XCTAssert((testReturn.name == "name" && testReturn.address == "test@sip.com"), "epected: {name = \"\", address = \"name\"} actual: {name = \(testReturn.name), address = \(testReturn.address)}")
    }
    
    func testNameWithBracesInQuotesAndAddressInBracesWithoutPrefix() {
        
        let testReturn = SWUriFormatter.contactFromURI("\"<name>\"<test@sip.com>")
        
        XCTAssert((testReturn.name == "name" && testReturn.address == "test@sip.com"), "epected: {name = \"\", address = \"name\"} actual: {name = \(testReturn.name), address = \(testReturn.address)}")
    }
    
    func testSipStringInAddress() {
        
        let testReturn = SWUriFormatter.contactFromURI("sip:00498009377546@sip.easybell.de")
        
        XCTAssert((testReturn.name == "" && testReturn.address == "00498009377546@sip.easybell.de"), "epected: {name = \"\", address = \"00498009377546@sip.easybell.de\"} actual: {name = \(testReturn.name), address = \(testReturn.address)}")
    }
}
