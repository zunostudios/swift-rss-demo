import UIKit

class DetailViewController: UIViewController {
                            
    @IBOutlet weak var detailWebView: UIWebView!

    var detailItem: AnyObject? {
        didSet {
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.detailItem as? RSSParserDelegate.BlogPost {
            if let webView = self.detailWebView {
                let post = (detail as RSSParserDelegate.BlogPost);
                var body : String = post.summary;
                var head : String = "<html><head><style>@import url(http://zunostudios.com/plugins/system/jch_optimize/assets/nz/30/7f922f8486a99acab8d3525437eab12a.css); body, html, * {padding: 0 1rem; max-width: 510px; font-size:17pt;} div { margin-top: 1rem; padding:1rem; background: rgba(255,255,255,.3); box-shadow:rgba(0,0,0,.2) 0px 0px 2px; margin: 0 .1rem; }  body { padding-bottom:130px;} .feedflare { display:none; } a { margin:0; padding:0; }</style></head><body>"
                
                head += "<h1>\( post.title )</h1>";
                    head += "<p class=\"author\">\(post.author)</p>"
                    head += "<div>";
                var foot : String = "</div></body>"
                
                webView.loadHTMLString(head+body+foot, baseURL: nil)
            }

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

