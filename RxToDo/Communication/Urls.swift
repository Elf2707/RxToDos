import Alamofire

enum Urls {
    case postTodo
    case getTodos
    case getTodo
    case deleteTodo
    case deleteAll
    case update
}

extension Urls {
    func httpMethodUrl() -> (HTTPMethod, String) {
        let baseUrl = "http://localhost:8080/"
        switch self {
        case .postTodo:
            return (.post, "\(baseUrl)todos")
        case .getTodos:
            return (.get, "\(baseUrl)todos")
        case .getTodo:
            return (.get, "\(baseUrl)todo")
        case .deleteTodo:
            return (.delete, "\(baseUrl)deleteTodo")
        case .deleteAll:
            return (.delete, "\(baseUrl)deleteAll")
        case .update:
            return (.post, "\(baseUrl)updateTodo")
        }
    }
}
