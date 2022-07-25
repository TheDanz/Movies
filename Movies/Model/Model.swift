class Model {
    var testArray: [Item] = [
        Item(id: 0, testPicture: "image1", testTitle: "Фильм1", testYear: 2001, testRating: 1.1, isLiked: true),
        Item(id: 1, testPicture: "image2", testTitle: "Фильм2", testYear: 2002, testRating: 2.2, isLiked: true),
        Item(id: 2, testPicture: "image3", testTitle: "Фильм3", testYear: 2003, testRating: 3.3, isLiked: false),
        Item(id: 3, testPicture: "image4", testTitle: "Фильм4", testYear: 2004, testRating: 4.4, isLiked: true),
        Item(id: 4, testPicture: "image5", testTitle: "Фильм5", testYear: 2005, testRating: 5.5, isLiked: false)
    ]
    var newTestArray: [Item] = []
    var likedMoviesArray: [Item] = []
    var sortAscending: Bool = false
    
    func ratingSort() {
        self.testArray.sort() {
            sortAscending ? ($0.testRating ?? 0) < ($1.testRating ?? 0) : ($0.testRating ?? 0) > ($1.testRating ?? 0)
        }
        newTestArray = testArray
    }
    
    func showLikedItems() {
        for item in testArray {
            if item.isLiked == true {
                likedMoviesArray.append(item)
            }
        }
    }
    
    func search(searchTextValue: String) {
        newTestArray = []
        if searchTextValue == "" {
            newTestArray = testArray
        } else {
            for item in testArray {
                guard let unwrItem = item.testTitle else { return }
                if unwrItem.contains(searchTextValue) {
                    newTestArray.append(item)
                }
            }
        }
        newTestArray = testArray.filter({
            $0.testTitle?.range(of: searchTextValue, options: .caseInsensitive) != nil
        })
    }
}

class Item {
    var id: Int?
    var testPicture: String?
    var testTitle: String?
    var testYear: Int?
    var testRating: Double?
    var isLiked: Bool
    
    init(id: Int?, testPicture: String?, testTitle: String?, testYear: Int?, testRating: Double?, isLiked: Bool) {
        self.id = id
        self.testPicture = testPicture
        self.testTitle = testTitle
        self.testYear = testYear
        self.testRating = testRating
        self.isLiked = isLiked
    }
}
