import UIKit

class LoadingViewController: UIViewController {
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.hidesWhenStopped = true
        
        return activityIndicator
    }()
    
    private var hideView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.isHidden = true
        view.addSubview(activityIndicator)
    }
    
    func showActivityIndicator(for view: UIView) {
        view.isHidden = true
        hideView = view
        activityIndicator.frame = view.frame
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        hideView?.isHidden = false
        activityIndicator.stopAnimating()
    }
}
