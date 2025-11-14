//
//  ViewController.swift
//  myFavorites
//
//  Created by Инкара on 14.11.2025.
//

import UIKit

struct FavoriteItem{
    let title: String
    let subtitle: String
    let review: String
    let image: UIImage
}
class FavoriteTableViewCell: UITableViewCell{
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    
    
    func configure(item: FavoriteItem){
        itemImageView.image = item.image
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        reviewLabel.text = item.review
    }
}

class ViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    let movies:[FavoriteItem] = [
        FavoriteItem(title: "The Great Gatsby", subtitle: "Drama·2013", review: "The film follows the life and times of millionaire Jay Gatsby (DiCaprio) and his neighbor Nick Carraway (Maguire) who recounts his interactions with Gatsby amid the riotous parties of the Jazz Age on Long Island in New York.", image: UIImage(named:"movie1")!),
        FavoriteItem(title: "Revolutionary Road", subtitle: "Drama·2008", review: "An unhappy couple dreams of moving to Paris. A star-studded duo in a sobering drama about lost illusions.", image: UIImage(named:"movie2")!),
        FavoriteItem(title: "La La Land", subtitle: "Melodrama·2016", review: "Mia and Sebastian choose between personal happiness and ambition. A tragicomic musical about compromise in the life of an artist.", image: UIImage(named:"movie3")!),
        FavoriteItem(title: "The Wolf of Wall Street", subtitle: "Drama·2013", review: "The rise of a hedonistic cynic to the top of 1980s business. The brilliant tandem of Leonardo DiCaprio and Martin Scorsese", image: UIImage(named:"movie4")!),
        FavoriteItem(title: "Molly's Game", subtitle: "Criminal·2017", review: "The true story of Molly Bloom, an Olympic-class skier who ran the world's most exclusive high-stakes poker game and became an FBI target.", image: UIImage(named:"movie5")!)
        ]
    
    let music:[FavoriteItem] = [
        FavoriteItem(title: "Sao Paulo", subtitle: "The Weeknd", review: "São Paulo is a 2024 song by The Weeknd and Anitta, released as the second single from The Weeknd's album Hurry Up Tomorrow.", image: UIImage(named:"music1")!),
        FavoriteItem(title: "Shape", subtitle: "Sugababes", review: " Shape is a song by English girl group Sugababes, released as the fourth and final single from their second studio album, Angels with Dirty Faces (2002).", image: UIImage(named:"music2")!),
        FavoriteItem(title: "Hot", subtitle: "Inna", review: "Hot is a single by Romanian singer Inna from her debut album, Hot. It was released on November 12, 2008, by Roton as the album's lead single.", image: UIImage(named:"music3")!),
        FavoriteItem(title: "I Never Felt so Right", subtitle: "Ben Delay", review: "The song I Never Felt So Right was written and released by DJ and producer Ben Delay in 2016.", image: UIImage(named:"music4")!),
        FavoriteItem(title: "Amazing", subtitle: "Inna ", review: "Amazing is a song recorded by Romanian singer Inna for her 2009 debut studio album, Hot. It was released as the fourth single from the record on 6 August", image: UIImage(named:"music5")!)
    ]
    let books:[FavoriteItem] = [
        FavoriteItem(title: "The Little Prince", subtitle: "by Antoine de Saint-Exupéry·1942", review: "The story follows a young prince who visits various planets, including Earth, and addresses themes of loneliness, friendship, love, and loss.", image: UIImage(named:"book1")!),
        FavoriteItem(title: "One Hundred Years of Solitude", subtitle: "by Gabriel Garcia Marquez·1967", review: "The rise and fall, birth and death of the mythical town of Macondo through the history of the Buendia family.", image: UIImage(named:"book2")!),
        FavoriteItem(title: "Alchemised", subtitle: "by SenLinYu", review: "All hope seems lost for Helena, a prisoner of war grappling with a dreary world of death and dark magic — and an inexplicable case of amnesia. Epic and engrossing, Alchemised is the gritty and Gothic read we’ve all been waiting for.", image: UIImage(named:"book3")!),
        FavoriteItem(title: "The Night Circus", subtitle: "by Erin Morgenstern", review: "The circus arrives without warning. No announcements precede it. It is simply there, when yesterday it was not. Within the black-and-white striped canvas tents is an utterly unique experience full of breathtaking amazements. It is called Le Cirque des Rêves, and it is only open at night.", image: UIImage(named:"book4")!),
        FavoriteItem(title: "The Goldfinch", subtitle: "by Donna Tartt·2014", review: "Donna Tartt is an American author who has achieved critical and public acclaim for her novels, which have been published in forty languages. In 2003 she received the WH Smith Literary Award for her novel, The Little Friend, which was also nominated for the Orange Prize for Fiction. She won the Pulitzer Prize and the Andrew Carnegie Medal for Fiction for her most recent novel, The Goldfinch.", image: UIImage(named:"book5")!)
    ]
    let courses:[FavoriteItem] = [
        FavoriteItem(title: "IOS", subtitle: "course", review: "The course covers everything you need to know about iOS development—from the basics of the Swift programming language to advanced app design and development.", image: UIImage(named:"course1")!),
        FavoriteItem(title: "Introduction to Information Systems", subtitle: "How Computers Talk to Each Other", review: "Basics of how IT systems work, from software to hardware, in a way that’s easy to understand.", image: UIImage(named:"course2")!),
        FavoriteItem(title: "Fundamentals of Programming", subtitle: " Writing Your First Lines of Code", review: "Learn simple coding concepts and create small programs using beginner-friendly languages.", image: UIImage(named:"course3")!),
        FavoriteItem(title: "Database Basics", subtitle: "Storing and Finding Your Data", review: "Understand how databases work, how to store data, and retrieve it using easy SQL queries.", image: UIImage(named:"course4")!),
        FavoriteItem(title: "Computer Networks", subtitle: "Connecting Devices in the Digital World", review: "Learn how computers and devices communicate, from LANs to the internet, in a simple, practical way.", image: UIImage(named:"course5")!)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
}
extension ViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0: return movies.count
        case 1: return music.count
        case 2: return books.count
        case 3: return courses.count
        default: return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
                as? FavoriteTableViewCell else{
            return UITableViewCell()
        }
        let item: FavoriteItem
        switch indexPath.section{
        case 0:
            item = movies[indexPath.row]
        case 1:
            item = music[indexPath.row]
        case 2:
            item = books[indexPath.row]
        case 3:
            item = courses[indexPath.row]
        default:
            fatalError("unknownSection")
        }
        cell.configure(item: item)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Fav Movies 🎬"
        case 1: return "Fav Music 🎧"
        case 2: return "Fav Books 📚"
        case 3: return "Fav Courses 🎓"
        default: return nil
        }
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Нажата секция: \(indexPath.section), строка: \(indexPath.row)")
    }
}

