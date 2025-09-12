import UIKit

var firstName: String = "Inkara"
var lastName: String = "Aman"
var age: Int = 19
var birthYear: Int = 2006
var isStudent: Bool = true
var height: Double = 1.58
let currentYear = 2025
var myCurrentAge = currentYear - birthYear

var hobby: String = "figure skating"
var numberOfHobbies: Int = 2
var favoriteNumber: Int = 7
var isHobbyCreative: Bool = false

var myLifeStory = "My name is \(firstName) \(lastName) . I am \(age) years old, born in \(birthYear). I am currently \(isStudent ? "" : "not") a student. I enjoy \(hobby), which is a \(isHobbyCreative ? "" : "not") creative hobby. I have \(numberOfHobbies) hobbies in total, and my favorite number is \(favoriteNumber). "

var 📌FutureGoals: String = "In the future, I want to become a successful iOS developer 👩‍💻 and make useful apps for people."

var completeStory = myLifeStory + " " + 📌FutureGoals

print(completeStory)
