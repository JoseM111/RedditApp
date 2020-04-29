import Foundation

enum PostError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    // Give the user whatever information you think they should know. Feel free to write your own descriptions.
    var errorDescription: String? {
        // Self knows its the error
        switch self {
            case .invalidURL:
                return "The server failed to reach the given url."
            case .thrownError(let error):
                return "Oops.. there was an error. \(error.localizedDescription)"
            case .noData:
                return "The server responded with no data."
            case .unableToDecode:
                return "Error trying to decode the data."
        }
    }
}

