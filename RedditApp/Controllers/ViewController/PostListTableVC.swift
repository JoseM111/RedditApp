import UIKit

class PostListTableVC: UITableViewController {
    
    // MARK: @Properties
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PostModelController.fetchPosts { (result) in
            DispatchQueue.main.sync {
                
                switch result {
                    case .success(let posts):
                        self.posts = posts// Rewritten to post we were getting results from
                        // Reload our table view
                        self.tableView.reloadData()
                    case .failure(let error):
                        print(error.errorDescription!)
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    /**©------------------------------------------------------------------------------©*/
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
            as? PostTableViewCell else { return UITableViewCell() }
        
        let post = self.posts[indexPath.row]
        cell.postTitleLabel.text = post.title
        cell.postsUpLabel.text = "UPS: \(post.ups)"
        cell.postImgView.image = nil
        
        PostModelController.fetchThumbnail(post: post) { (result) in
            
            DispatchQueue.main.sync {
                switch result {
                    case .success(let thumbnail):
                        cell.postImgView.image = thumbnail
                    case .failure(_):
                        print("No thumbnail found...")
                }
            }
        }
        
        return cell
    }
    /**©------------------------------------------------------------------------------©*/
    
}// END OF CLASS
