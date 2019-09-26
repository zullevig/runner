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

extension Job: MySQLModel {}
extension Job: Content {}
extension Job: Migration {}
extension Job: Parameter {}
//extension Job {
//    var items: Children<Job, Object> {
//        return children(\.jobID)
//    }
//}
