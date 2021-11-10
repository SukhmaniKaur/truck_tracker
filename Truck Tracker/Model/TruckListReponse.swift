//
//  TruckListReponse.swift
//  Truck Tracker
//
//  Created by MACBOOK on 06/11/21.
//

import Foundation

// MARK: - TruckListResponse
struct TruckListResponse: Codable {
    let data: [TruckListInfo]
    let responseCode: ResponseCode
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([TruckListInfo].self, forKey: .data) ?? []
        responseCode = try values.decodeIfPresent(ResponseCode.self, forKey: .responseCode) ?? ResponseCode()
    }
}

// MARK: - TruckListInfo
struct TruckListInfo: Codable {
    let id: Int
    var lastRunningState: LastRunningState
    let truckNumber: String
    let lastWaypoint: LastWaypoint

    enum CodingKeys: String, CodingKey {
        case id
        case lastRunningState
        case truckNumber
        case lastWaypoint
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? DocumentDefaultValues.Empty.int
        truckNumber = try values.decodeIfPresent(String.self, forKey: .truckNumber) ?? DocumentDefaultValues.Empty.string
        lastRunningState = try values.decodeIfPresent(LastRunningState.self, forKey: .lastRunningState) ?? LastRunningState()
        lastWaypoint = try values.decodeIfPresent(LastWaypoint.self, forKey: .lastWaypoint) ?? LastWaypoint()
    }
    
    init() {
        self.id = DocumentDefaultValues.Empty.int
        self.lastRunningState = LastRunningState()
        self.truckNumber = DocumentDefaultValues.Empty.string
        self.lastWaypoint = LastWaypoint()
    }
}

// MARK: - LastRunningState
struct LastRunningState: Codable {
    var truckRunningState: TRUCK_RUNNING_STATE = .running
    var stopStartTime: Int
    var lastRunningTime: String

    enum CodingKeys: String, CodingKey {
        case truckRunningState, stopStartTime, lastRunningTime
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let state = try values.decodeIfPresent(Int.self, forKey: .truckRunningState) {
            truckRunningState = TRUCK_RUNNING_STATE(rawValue: state) ?? .running
        }
        stopStartTime = try values.decodeIfPresent(Int.self, forKey: .stopStartTime) ?? DocumentDefaultValues.Empty.int
        lastRunningTime = try values.decodeIfPresent(String.self, forKey: .lastRunningTime) ?? DocumentDefaultValues.Empty.string
    }
    
    internal init() {
        self.truckRunningState = .running
        self.stopStartTime = DocumentDefaultValues.Empty.int
        self.lastRunningTime = DocumentDefaultValues.Empty.string
    }
}

// MARK: - LastWaypoint
struct LastWaypoint: Codable {
    let id: Int
    let speed: Double
    let lat: Double
    let createTime: Int
    let ignitionOn: Bool
    let lng: Double

    enum CodingKeys: String, CodingKey {
        case id, speed, lat, createTime, ignitionOn
        case lng
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createTime = try values.decodeIfPresent(Int.self, forKey: .createTime) ?? DocumentDefaultValues.Empty.int
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? DocumentDefaultValues.Empty.int
        lat = try values.decodeIfPresent(Double.self, forKey: .lat) ?? DocumentDefaultValues.Empty.double
        lng = try values.decodeIfPresent(Double.self, forKey: .lng) ?? DocumentDefaultValues.Empty.double
        speed = try values.decodeIfPresent(Double.self, forKey: .speed) ?? DocumentDefaultValues.Empty.double
        ignitionOn = try values.decodeIfPresent(Bool.self, forKey: .ignitionOn) ?? DocumentDefaultValues.Empty.bool
    }
    
    internal init() {
        self.id = DocumentDefaultValues.Empty.int
        self.speed = DocumentDefaultValues.Empty.double
        self.lat = DocumentDefaultValues.Empty.double
        self.createTime = DocumentDefaultValues.Empty.int
        self.ignitionOn = DocumentDefaultValues.Empty.bool
        self.lng = DocumentDefaultValues.Empty.double
    }
}

// MARK: - ResponseCode
struct ResponseCode: Codable {
    let message: String
    let responseCode: Int
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        responseCode = try values.decodeIfPresent(Int.self, forKey: .responseCode) ?? DocumentDefaultValues.Empty.int
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? DocumentDefaultValues.Empty.string
    }
    
    internal init() {
        self.message = DocumentDefaultValues.Empty.string
        self.responseCode = DocumentDefaultValues.Empty.int
    }
}
