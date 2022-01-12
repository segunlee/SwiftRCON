//
//  SwiftSocket+Rust+Model.swift
//  SwiftRCON
//
//  Created by LeeSeGun on 2022/01/10.
//

import Foundation

struct RustServerInfo: Codable {
    let hostname: String
    let maxPlayers: Int
    let players: Int
    let queued: Int
    let joining: Int
    let entityCount: Int
    let gameTime: String
    let uptime: Int
    let map: String
    let framerate: Double
    let memory: Int
    let collections: Int
    let networkIn: Int
    let networkOut: Int
    let restarting: Bool
    let saveCreatedTime: String

    enum CodingKeys: String, CodingKey {
        case hostname = "Hostname"
        case maxPlayers = "MaxPlayers"
        case players = "Players"
        case queued = "Queued"
        case joining = "Joining"
        case entityCount = "EntityCount"
        case gameTime = "GameTime"
        case uptime = "Uptime"
        case map = "Map"
        case framerate = "Framerate"
        case memory = "Memory"
        case collections = "Collections"
        case networkIn = "NetworkIn"
        case networkOut = "NetworkOut"
        case restarting = "Restarting"
        case saveCreatedTime = "SaveCreatedTime"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hostname = try values.decodeIfPresent(String.self, forKey: .hostname) ?? ""
        maxPlayers = try values.decodeIfPresent(Int.self, forKey: .maxPlayers) ?? 0
        players = try values.decodeIfPresent(Int.self, forKey: .players) ?? 0
        queued = try values.decodeIfPresent(Int.self, forKey: .queued) ?? 0
        joining = try values.decodeIfPresent(Int.self, forKey: .joining) ?? 0
        entityCount = try values.decodeIfPresent(Int.self, forKey: .entityCount) ?? 0
        gameTime = try values.decodeIfPresent(String.self, forKey: .gameTime) ?? ""
        uptime = try values.decodeIfPresent(Int.self, forKey: .uptime) ?? 0
        map = try values.decodeIfPresent(String.self, forKey: .map) ?? ""
        framerate = try values.decodeIfPresent(Double.self, forKey: .framerate) ?? 0
        memory = try values.decodeIfPresent(Int.self, forKey: .memory) ?? 0
        collections = try values.decodeIfPresent(Int.self, forKey: .collections) ?? 0
        networkIn = try values.decodeIfPresent(Int.self, forKey: .networkIn) ?? 0
        networkOut = try values.decodeIfPresent(Int.self, forKey: .networkOut) ?? 0
        restarting = try values.decodeIfPresent(Bool.self, forKey: .restarting) ?? false
        saveCreatedTime = try values.decodeIfPresent(String.self, forKey: .saveCreatedTime) ?? ""
    }
}


struct RustPlayer: Codable {
    let steamID: String
    let ownerSteamID: String
    let displayName: String
    let ping: Int
    let address: String
    let connectedSeconds: Int
    let voiationLevel: Float
    let currentLevel: Float
    let unspentXP: Float
    let health: Float
    
    enum CodingKeys: String, CodingKey {
        case steamID = "SteamID"
        case ownerSteamID = "OwnerSteamID"
        case displayName = "DisplayName"
        case ping = "Ping"
        case address = "Address"
        case connectedSeconds = "ConnectedSeconds"
        case voiationLevel = "VoiationLevel"
        case currentLevel = "CurrentLevel"
        case unspentXP = "UnspentXP"
        case health = "Health"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        steamID = try values.decodeIfPresent(String.self, forKey: .steamID) ?? ""
        ownerSteamID = try values.decodeIfPresent(String.self, forKey: .ownerSteamID) ?? ""
        displayName = try values.decodeIfPresent(String.self, forKey: .displayName) ?? ""
        ping = try values.decodeIfPresent(Int.self, forKey: .ping) ?? 0
        address = try values.decodeIfPresent(String.self, forKey: .address) ?? ""
        connectedSeconds = try values.decodeIfPresent(Int.self, forKey: .connectedSeconds) ?? 0
        voiationLevel = try values.decodeIfPresent(Float.self, forKey: .voiationLevel) ?? 0
        currentLevel = try values.decodeIfPresent(Float.self, forKey: .currentLevel) ?? 0
        unspentXP = try values.decodeIfPresent(Float.self, forKey: .unspentXP) ?? 0
        health = try values.decodeIfPresent(Float.self, forKey: .health) ?? 0
    }
}

extension RustPlayer {
    var connectedTime: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .brief
        return formatter.string(from: TimeInterval(connectedSeconds)) ?? "-"
    }
}


struct RustConsole: Codable {
    let message: String
    let stacktrace: String
    let type: String
    let time: Int
    
    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case stacktrace = "Stacktrace"
        case type = "Type"
        case time = "Time"
    }
    
    init(packet: RCONPacket) {
        message = packet.Message
        stacktrace = ""
        type = packet.`Type`
        time = Int(Date().timeIntervalSinceNow)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
        stacktrace = try values.decodeIfPresent(String.self, forKey: .stacktrace) ?? ""
        type = try values.decodeIfPresent(String.self, forKey: .type) ?? ""
        time = try values.decodeIfPresent(Int.self, forKey: .time) ?? 0
    }
}


struct RustChat: Codable {
    let channel: Int
    let message: String
    let userId: String
    let username: String
    let color: String
    let time: Int

    enum CodingKeys: String, CodingKey {
        case channel = "Channel"
        case message = "Message"
        case userId = "UserId"
        case username = "Username"
        case color = "Color"
        case time = "Time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        channel = try values.decodeIfPresent(Int.self, forKey: .channel) ?? 0
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
        userId = try values.decodeIfPresent(String.self, forKey: .userId) ?? "unknown"
        username = try values.decodeIfPresent(String.self, forKey: .username) ?? "unknown"
        color = try values.decodeIfPresent(String.self, forKey: .color) ?? ""
        time = try values.decodeIfPresent(Int.self, forKey: .time) ?? 0
    }

    func getDate() -> Date {
        return Date(timeIntervalSince1970: Double(time))
    }
}
