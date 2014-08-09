import Foundation

class RSSParserDelegate : NSObject, NSXMLParserDelegate {
    var posts: [BlogPost] = [];
    internal class BlogPost : NSObject {
        var title: String = "";
        var author: String = "";
        var summary: String = "";
        var date: String = "";
    }
    
    enum Mode {
        case TITLE
        case AUTHOR
        case SUMMARY
        case DATE
        case INACTIVE
    };
    
    var mode:Mode = .INACTIVE;
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: NSDictionary!) {
        if(elementName == "item") {
            posts.append(BlogPost());
        }
        
        if(elementName == "author") {
            mode = .AUTHOR;
        }
        
        if(elementName == "description") {
            mode = .SUMMARY;
        }
        
        if(elementName == "title") {
            mode = .TITLE;
        }
        
        if(elementName == "pubDate") {
            mode = .DATE
        }
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        if let current = posts.last {
            var current:BlogPost? = posts.last;
            
            switch (mode) {
                case   .TITLE: current?.title += string;
                case .SUMMARY: current?.summary += string;
                case  .AUTHOR: current?.author += string;
                case    .DATE: current?.date += string;
                default: break;
            }
        }
    }
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        self.mode = .INACTIVE;
    }
};