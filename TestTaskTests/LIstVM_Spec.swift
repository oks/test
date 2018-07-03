//
//  TestTaskTests.swift
//  TestTaskTests
//
//  Created by Oksana Kovalchuk on 7/3/18.
//  Copyright © 2018 Oksana Kovalchuk. All rights reserved.
//

import Quick
import Nimble
@testable import TestTask

class ListVM_Spec: QuickSpec {
    
    override func spec() {
        
        describe("username") {
            
            it("username will match item username if its not nil", closure: {
                let testUsername = "test"
                let item = Contributor(username: testUsername, photoURLString: "")
                let model = ListCellVM(item: item)
                
                expect(model.username()).to(equal(testUsername))
            })
            
            it("username will match anonymous if its nil", closure: {
                let item = Contributor(username: nil, photoURLString: "")
                let model = ListCellVM(item: item)
                
                //have hardcoded values in const file much better, this makes test fragile
                expect(model.username()).to(equal("Anonymous"))
            })
        }
        
    }
}


