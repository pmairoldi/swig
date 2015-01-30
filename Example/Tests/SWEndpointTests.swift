//
//  SWEndpointTests.swift
//  Swig
//
//  Created by Pierre-Marc Airoldi on 2014-09-03.
//  Copyright (c) 2014 Pierre-Marc Airoldi. All rights reserved.
//

import UIKit
import Foundation
import XCTest

class SWEndpointTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testEndpointReset() {
        // This is an example of a functional test case.
        
        let endpoint = SWEndpoint.sharedEndpoint();
        
        let expectation = expectationWithDescription("reset endpoint");
        
        endpoint.reset { (error) -> Void in
            expectation.fulfill()
            XCTAssertNil(error, "error should be nil")
            
            let accounts = endpoint.accounts;
            
        }
        
        waitForExpectationsWithTimeout(2.0, handler: { (error) -> Void in
            
        })
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock() {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
