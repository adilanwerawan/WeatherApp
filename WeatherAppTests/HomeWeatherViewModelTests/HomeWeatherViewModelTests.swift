//
//  HomeWeatherViewModelTests.swift
//  weatherappTests
//
//  Created by MacBook on 22/05/2022.
//

import XCTest
import Combine
@testable import WeatherApp

class HomeWeatherViewModelTests: XCTestCase {
    private var subject:HomeWeatherViewModel!
    private var cancellables:Set<AnyCancellable> = []
    private var mockWeatherApiService:MockWeatherApiService!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        mockWeatherApiService = MockWeatherApiService()
        subject = HomeWeatherViewModel(weatherApi: mockWeatherApiService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        cancellables.forEach{$0.cancel()}
        cancellables.removeAll()
        mockWeatherApiService = nil
        subject = nil
        
        super.tearDown()
    }
    
    func test_homeWethaerViewModelL_shouldCallService(){
        // when
        subject.fetchTodayWeatherDetails()
        
        //then
        // It should be 2 calls because one for today and one for week
        XCTAssertEqual(mockWeatherApiService.callsCount, 2)
    }
    
    func test_todaysWeather_givenServiceCallSucceeds_shouldUpdateResponceModel(){
        //given
        mockWeatherApiService.todayWeatherResult = .success(MockWeatherApiService.Constants.todaysWeatherData)
        
        // when
        subject.fetchTodayWeatherDetails()
        
        //then
        XCTAssertEqual(mockWeatherApiService.callsCount, 2)
        XCTAssertEqual(subject.todayWeatherModel, MockWeatherApiService.Constants.todaysWeatherData)
        
        subject.$state
            .sink(receiveValue: {XCTAssertEqual($0, .finishLoading)})
            .store(in: &cancellables)
    }
    
    func test_todaysWeather_givenServiceCallFails_shouldUpdateStateWithError(){
        // given
        mockWeatherApiService.todayWeatherResult = .failure(MockError.error)
        
        // when
        subject.fetchTodayWeatherDetails()
        
        // then
        // In error case it will be failed after todays weather call
        // So api call count should 1
        XCTAssertEqual(mockWeatherApiService.callsCount, 1)
        XCTAssertTrue(subject.todayWeatherModel == nil)
        
        subject.$state
            .sink(receiveValue: {XCTAssertEqual($0, .error("Failed to fetch the weather data"))})
            .store(in: &cancellables)
    }
}
