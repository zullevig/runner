//
//  Models.swift
//  Tasker
//
//  Created by Steve Sparks on 9/25/19.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import Foundation

enum TaskError: Error {
    case illegalState
}

// state machine for an item of work.
enum WorkState: Int, Codable {
    case notReady // dependencies not met
    case ready
    case inProgress
    case completed
    case failed
}

class WorkStateMachine {
    private(set) var state: WorkState
    private(set) var error: Error?

    init(_ state: WorkState) {
        self.state = state
    }

    func begin() throws {
        guard state == .ready else {
            throw TaskError.illegalState
        }
        state = .inProgress
    }

    func complete(_ error: Error? = nil) throws {
        if state == .inProgress && error == nil {
            state = .completed
        } else if let error = error {
            self.error = error
            state = .failed
        } else {
            throw TaskError.illegalState
        }
    }
}

indirect enum WorkItemDuration: Codable {
    // "rise for one hour"
    // It's okay to let it rise for 50 minutes or even zero if you want lousy bread.
    case softMinimumTime(TimeInterval)

    // "let cure 24 hours"
    // this time must be made to expire.
    case hardMinimumTime(TimeInterval)

    // "let ferment 30-60 days"
    // one minimum, one maximum
    case window(WorkItemDuration, WorkItemDuration)

    // "pizza dough is good for 3 days"
    case softMaximumTime(TimeInterval)

    // "cat must be fed every day"
    case hardMaximumTime(TimeInterval)

    // No time limit. "Once plate is in place, tighten the bolt."
    case completionConditionMet

    enum CodingKeys: String, CodingKey {
        case type, value, otherValue
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .softMinimumTime(let val):
            try container.encode("softMinimumTime", forKey: .type)
            try container.encode(val, forKey: .value)
        case .hardMinimumTime(let val):
            try container.encode("hardMinimumTime", forKey: .type)
            try container.encode(val, forKey: .value)
        case .window(let val1, let val2):
            try container.encode("window", forKey: .type)
            try container.encode(val1, forKey: .value)
            try container.encode(val2, forKey: .otherValue)
        case .softMaximumTime(let val):
            try container.encode("softMaximumTime", forKey: .type)
            try container.encode(val, forKey: .value)
        case .hardMaximumTime(let val):
            try container.encode("hardMaximumTime", forKey: .type)
            try container.encode(val, forKey: .value)
        case .completionConditionMet:
            try container.encode("completionConditionMet", forKey: .type)
            try container.encode(0, forKey: .value)
        @unknown default:
            preconditionFailure("NOPE")
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let typ = try container.decode(String.self, forKey: .type)
        switch typ {
            case "softMinimumTime":
                let val = try container.decode(TimeInterval.self, forKey: .value)
                self = .softMinimumTime(val)
            case "hardMinimumTime":
                let val = try container.decode(TimeInterval.self, forKey: .value)
                self = .hardMinimumTime(val)
            case "softMaximumTime":
                let val = try container.decode(TimeInterval.self, forKey: .value)
                self = .softMaximumTime(val)
            case "hardMaximumTime":
                let val = try container.decode(TimeInterval.self, forKey: .value)
                self = .hardMaximumTime(val)
            case "completionConditionMet":
                self = .completionConditionMet
            case "window":
            let val1 = try container.decode(WorkItemDuration.self, forKey: .value)
            let val2 = try container.decode(WorkItemDuration.self, forKey: .value)
            self = .window(val1, val2)
        default:
            preconditionFailure("Never meant a thing to me")
        }
    }
}

final class Object: Codable {
    var id: Int?
    var workItemID: Int?
    var name: String
    var uniqueIdentifier: UUID
    init(_ name: String, _ uuid: UUID = UUID()) {
        self.name = name
        self.uniqueIdentifier = uuid
    }

    enum CodingKeys: String, CodingKey {
        case id, workItemID, name, uniqueIdentifier
    }
}

final class CueItem: Codable {
    var id: Int?
    var workItemID: Int?
    var threeDModel: Data?

    enum CodingKeys: String, CodingKey {
        case id, workItemID, threeDModel
    }
}

final class WorkItem: Codable {
    var id: Int?
    var jobID: Int?
    var workItemID: Int?
    var dependencies: [WorkItem]
    var description: String
    var detailedInstruction: String
    var ingredients: [Object]
    var outputs: [Object]
    var cueItems: [CueItem]
    
    var duration: WorkItemDuration
    var state: WorkState
    
    enum CodingKeys: String, CodingKey {
        case id, jobID, workItemID, dependencies, description, detailedInstruction, ingredients, outputs, cueItems, duration, state
    }
    
    init(description: String, detailedInstruction: String, dependencies: [WorkItem] = []) {
        self.description = description
        self.detailedInstruction = detailedInstruction
        self.dependencies = dependencies
        self.ingredients = []
        self.outputs = []
        self.cueItems = []
        self.duration = .completionConditionMet
        let unmet = dependencies.filter { $0.state != .completed }
        self.state = unmet.isEmpty ? .ready : .notReady
    }
    
    var dependenciesMet: Bool {
        let unmet = dependencies.filter { $0.state != .completed }
        return unmet.isEmpty
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(jobID, forKey: .jobID)
        try container.encode(workItemID, forKey: .workItemID)
        try container.encode(dependencies, forKey: .dependencies)
        try container.encode(description, forKey: .description)
        try container.encode(detailedInstruction, forKey: .detailedInstruction)
        try container.encode(ingredients, forKey: .ingredients)
        try container.encode(outputs, forKey: .outputs)
        try container.encode(cueItems, forKey: .cueItems)
        try container.encode(duration, forKey: .duration)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int?.self, forKey: .id)
        jobID = try container.decode(Int?.self, forKey: .jobID)
        workItemID = try container.decode(Int?.self, forKey: .workItemID)
        dependencies = try container.decode([WorkItem].self, forKey: .dependencies)
        description = try container.decode(String.self, forKey: .description)
        detailedInstruction = try container.decode(String.self, forKey: .detailedInstruction)
        ingredients = try container.decode([Object].self, forKey: .ingredients)
        outputs = try container.decode([Object].self, forKey: .outputs)
        cueItems = try container.decode([CueItem].self, forKey: .ingredients)
        duration = try container.decode(WorkItemDuration.self, forKey: .duration)
        let unmet = dependencies.filter { $0.state != .completed }
        self.state = unmet.isEmpty ? .ready : .notReady
    }
}

struct Job: Codable {
    var id: Int?
    var description: String
    var detailedInstruction: String
    var workItems: [WorkItem]

    enum CodingKeys: String, CodingKey {
        case id, description, detailedInstruction, workItems
    }
}
