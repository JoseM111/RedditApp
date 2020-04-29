import Foundation

// MARK: _TopLevelObj
struct PostTopLvLObj: Codable {
    let data: PostSecondLvLObj
}
// MARK: _TopLevelObj

/**©-----------------------------©*/
struct PostSecondLvLObj: Codable {
    let children: [PostThirdLvLObj]
}
/**©-----------------------------©*/

/**©-----------------------------©*/
struct PostThirdLvLObj: Codable {
    let data: Post
}
/**©-----------------------------©*/

/**©-----------------------------©*/

struct Post: Codable {
    let title: String
    let ups: Int
    let thumbnail: String
}
/**©-----------------------------©*/
