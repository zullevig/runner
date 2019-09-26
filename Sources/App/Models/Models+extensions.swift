import Vapor
import FluentMySQL

extension Object: MySQLModel {}
extension Object: Content {}
extension Object: Migration {}
extension Object: Parameter {}

extension CueItem: MySQLModel {}
extension CueItem: Content {}
extension CueItem: Migration {}
extension CueItem: Parameter {}

extension WorkItem: MySQLModel {}
extension WorkItem: Content {}
extension WorkItem: Migration {}
extension WorkItem: Parameter {}
extension WorkItem {
    var dependencies: Children<WorkItem, WorkItem> {
        return children(\.workItemID)
    }
    var ingredients: Children<WorkItem, Object> {
        return children(\.workItemIngredientID)
    }
    var outputs: Children<WorkItem, Object> {
        return children(\.workItemOutputID)
    }
    var cueItems: Children<WorkItem, CueItem> {
        return children(\.workItemID)
    }
}

extension Job: MySQLModel {}
extension Job: Content {}
extension Job: Migration {}
extension Job: Parameter {}
extension Job {
    var workItems: Children<Job, WorkItem> {
        return children(\.jobID)
    }
}

// -------------

extension SimpleWorkItem: MySQLModel {}
extension SimpleWorkItem: Content {}
extension SimpleWorkItem: Migration {}
extension SimpleWorkItem: Parameter {}

extension SimpleWorkItem {
    var outputs: Children<SimpleWorkItem, Object> {
        return children(\.workItemOutputID)
    }
    var cueItems: Children<SimpleWorkItem, CueItem> {
        return children(\.workItemID)
    }
}
