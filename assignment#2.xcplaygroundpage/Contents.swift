// Problem 1: FizzBuzz

for i in 1...100 {
    
    if i % 15 == 0 {
        print("FizzBuzz")
    } else if i % 3 == 0 {
        print("Fizz")
    } else if i % 5 == 0 {
        print("Buzz")
    } else {
        print(i)
    }
}


// -----------------------

// Problem 2: Prime Numbers
import Foundation

func isPrime(_ number: Int) -> Bool {
    if number < 2 { return false }
    if number % 2 == 0 { return number == 2 }
    let limit = Int(Double(number).squareRoot())
    var d = 3
    while d <= limit {
        if number % d == 0 { return false }
        d += 2
    }
    return true
}

let primes = (1...100).filter { isPrime($0) }
print(primes.map(String.init).joined(separator: " "))

// -----------------------

// Problem 3: Temperature Converter

import Foundation

func celsius(from value: Double, unit: String) -> Double? {
    switch unit.uppercased() {
    case "C": return value
    case "F": return (value - 32) * 5/9
    case "K": return value - 273.15
    default: return nil
    }
}

func toFahrenheit(_ c: Double) -> Double { c * 9/5 + 32 }
func toKelvin(_ c: Double) -> Double { c + 273.15 }

print("Введите температуру (число): ", terminator: "")
guard let rawValue = readLine(), let value = Double(rawValue) else {
    print("Некорректное число."); exit(0)
}
print("Укажите единицу измерения (C/F/K): ", terminator: "")
guard let unit = readLine(), let c = celsius(from: value, unit: unit) else {
    print("Некорректная единица. Используйте C, F или K."); exit(0)
}

let f = toFahrenheit(c)
let k = toKelvin(c)
print(String(format: "C: %.2f, F: %.2f, K: %.2f", c, f, k))

// -----------------------

// Problem 4: Shopping List Manager
import Foundation

func runShoppingList_CLI() {
    var list: [String] = []

    func showMenu() {
        print("""
        === Shopping List ===
        1) Добавить товар
        2) Удалить товар (по индексу)
        3) Показать список
        4) Выход
        Выберите пункт:
        """, terminator: " ")
    }

    func showList() {
        if list.isEmpty { print("Список пуст.") }
        else { for (i, item) in list.enumerated() { print("[\(i)] \(item)") } }
    }

    while true {
        showMenu()
        guard let choice = readLine() else { break }
        switch choice {
        case "1":
            print("Введите название товара: ", terminator: "")
            if let item = readLine(), !item.trimmingCharacters(in: .whitespaces).isEmpty {
                list.append(item); print("Добавлено.")
            } else { print("Пустое значение не добавлено.") }
        case "2":
            showList()
            print("Введите индекс для удаления: ", terminator: "")
            if let s = readLine(), let i = Int(s), list.indices.contains(i) {
                let removed = list.remove(at: i); print("Удалено: \(removed)")
            } else { print("Некорректный индекс.") }
        case "3":
            showList()
        case "4":
            print("До встречи."); return
        default:
            print("Неизвестная команда.")
        }
        print("")
    }
}

// -----------------------

// Problem 5: Word Frequency Counter

import Foundation

func wordFrequency(_ text: String) -> [String: Int] {
    let cleaned = text
        .lowercased()
        .components(separatedBy: CharacterSet.punctuationCharacters.union(.symbols))
        .joined()
    let words = cleaned.split { $0.isWhitespace || $0.isNewline }.map(String.init)
    var freq: [String: Int] = [:]
    for w in words { freq[w, default: 0] += 1 }
    return freq
}

let sentence = "Hello, hello! Swift is great; SWIFT is fast."
let freq = wordFrequency(sentence)
for (w, c) in freq.sorted(by: { $0.value == $1.value ? $0.key < $1.key : $0.value > $1.value }) {
    print("\(w): \(c)")
}

// -----------------------

// Problem 6: Fibonacci Sequence

func fibonacci(_ n: Int) -> [Int] {
    if n <= 0 { return [] }
    if n == 1 { return [0] }
    var a = 0, b = 1, res = [0, 1]
    while res.count < n { (a, b) = (b, a + b); res.append(b) }
    return res
}

print(fibonacci(10).map(String.init).joined(separator: " "))

// -----------------------

// Problem 7: Grade Calculator

struct Student { let name: String; let score: Double }

func gradeReport(_ students: [Student]) {
    guard !students.isEmpty else { print("No students"); return }
    let scores = students.map { $0.score }
    let avg = scores.reduce(0, +) / Double(scores.count)
    let maxScore = scores.max() ?? 0
    let minScore = scores.min() ?? 0
    print(String(format: "Average: %.2f | Max: %.2f | Min: %.2f", avg, maxScore, minScore))
    for s in students {
        let tag = s.score >= avg ? "above average" : "below average"
        print(String(format: "%@ — %.2f (%@)", s.name, s.score, tag))
    }
}

let students = [
    Student(name: "Inkara", score: 92),
    Student(name: "Aman", score: 81),
    Student(name: "Dana", score: 76),
    Student(name: "Alik", score: 95)
]
gradeReport(students)

// -----------------------

// Problem 8: Palindrome Checker

func isPalindrome(_ text: String) -> Bool {
    let filtered = text.lowercased().filter { $0.isLetter || $0.isNumber }
        return filtered == String(filtered.reversed())
}

print(isPalindrome("A man, a plan, a canal: Panama"))
print(isPalindrome("Swift 5"))

// -----------------------

// Problem 9: Simple Calculator

func add(_ a: Double, _ b: Double) -> Double { a + b }
func sub(_ a: Double, _ b: Double) -> Double { a - b }
func mul(_ a: Double, _ b: Double) -> Double { a * b }
func div(_ a: Double, _ b: Double) -> Double? { b == 0 ? nil : a / b }

print(add(12, 3))
print(sub(12, 3))
print(mul(12, 3))
print(div(12, 0) ?? Double.nan)

// -----------------------

// Problem 10: Unique Characters

func hasUniqueCharacters(_ text: String) -> Bool {
    var seen = Set<Character>()
    for ch in text {
        if seen.contains(ch) { return false }
        seen.insert(ch)
    }
    return true
}

print(hasUniqueCharacters("Swift"))   // true
print(hasUniqueCharacters("Hello"))   // false
