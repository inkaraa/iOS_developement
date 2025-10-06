import Foundation

// Part 1. Models: Product, CartItem

enum ValidationError: Error {
    case nonPositivePrice
    case nonPositiveQuantity
}

struct Product: Hashable {
    let id: String
    let name: String
    let price: Double
    let category: Category
    let description: String

    enum Category: String {
        case electronics, clothing, food, books
    }

    var displayPrice: String {
        Self.currencyFormatter.string(from: NSNumber(value: price)) ?? String(format: "$%.2f", price)
    }

    init?(id: String = UUID().uuidString,
          name: String,
          price: Double,
          category: Category,
          description: String) {
        guard price > 0 else { return nil }
        self.id = id
        self.name = name
        self.price = price
        self.category = category
        self.description = description
    }

    private static let currencyFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .currency
        f.maximumFractionDigits = 2
        return f
    }()
}

struct CartItem {
    let product: Product
    private(set) var quantity: Int

    var subtotal: Double { product.price * Double(quantity) }

    mutating func updateQuantity(_ newQuantity: Int) throws {
        guard newQuantity > 0 else { throw ValidationError.nonPositiveQuantity }
        quantity = newQuantity
    }

    mutating func increaseQuantity(by amount: Int) throws {
        guard amount > 0 else { throw ValidationError.nonPositiveQuantity }
        quantity += amount
    }

    init(product: Product, quantity: Int) throws {
        guard quantity > 0 else { throw ValidationError.nonPositiveQuantity }
        self.product = product
        self.quantity = quantity
    }
}

// Part 2. ShoppingCart

final class ShoppingCart {
    private(set) var items: [CartItem] = []
    var discountCode: String?

    init() {}

    func addItem(product: Product, quantity: Int = 1) {
        guard quantity > 0 else { return }
        if let idx = items.firstIndex(where: { $0.product.id == product.id }) {
            var existing = items[idx]
            try? existing.increaseQuantity(by: quantity)
            items[idx] = existing
        } else if let newItem = try? CartItem(product: product, quantity: quantity) {
            items.append(newItem)
        }
    }

    func removeItem(productId: String) {
        items.removeAll { $0.product.id == productId }
    }

    func updateItemQuantity(productId: String, quantity: Int) {
        guard let idx = items.firstIndex(where: { $0.product.id == productId }) else { return }
        if quantity <= 0 {
            items.remove(at: idx)
        } else {
            var item = items[idx]
            try? item.updateQuantity(quantity)
            items[idx] = item
        }
    }

    func clearCart() {
        items.removeAll()
    }

    var subtotal: Double {
        items.reduce(0) { $0 + $1.subtotal }
    }

    var discountAmount: Double {
        guard let code = discountCode?.uppercased(), subtotal > 0 else { return 0 }
        switch code {
        case "SAVE10": return subtotal * 0.10
        case "SAVE20": return subtotal * 0.20
        default: return 0
        }
    }

    var total: Double { max(subtotal - discountAmount, 0) }

    var itemCount: Int {
        items.reduce(0) { $0 + $1.quantity }
    }

    var isEmpty: Bool { items.isEmpty }
}

// Part 3. Address & Order

struct Address {
    var street: String
    var city: String
    var zipCode: String
    var country: String

    var formattedAddress: String {
        """
        \(street)
        \(city), \(zipCode)
        \(country)
        """
    }
}

struct Order {
    let orderId: String
    let items: [CartItem]
    let subtotal: Double
    let discountAmount: Double
    let total: Double
    let timestamp: Date
    let shippingAddress: Address

    init(from cart: ShoppingCart, shippingAddress: Address) {
        self.orderId = UUID().uuidString
        self.items = cart.items
        self.subtotal = cart.subtotal
        self.discountAmount = cart.discountAmount
        self.total = cart.total
        self.timestamp = Date()
        self.shippingAddress = shippingAddress
    }

    var itemCount: Int {
        items.reduce(0) { $0 + $1.quantity }
    }
}

// Part 4. Tests & Demonstrations

func line(_ title: String) {
    print("\n==== \(title) ====")
}

line("Create sample products")
let laptop = Product(name: "MacBook Air", price: 1299.99, category: .electronics, description: "13-inch laptop")!
let book = Product(name: "Swift Book", price: 39.90, category: .books, description: "Learn Swift")!
let headphones = Product(name: "Headphones", price: 79.00, category: .electronics, description: "Over-ear")!

print("\(laptop.name): \(laptop.displayPrice)")
print("\(book.name): \(book.displayPrice)")
print("\(headphones.name): \(headphones.displayPrice)")

line("Add items to cart")
let cart = ShoppingCart()
cart.addItem(product: laptop, quantity: 1)
cart.addItem(product: book, quantity: 2)
print("Subtotal:", cart.subtotal, "| itemCount:", cart.itemCount)

line("Add same product again (quantity should update)")
cart.addItem(product: laptop, quantity: 1)
if let lapItem = cart.items.first(where: { $0.product.id == laptop.id }) {
    print("Laptop quantity:", lapItem.quantity)
}

line("Cart calculations")
print(String(format: "Subtotal: %.2f", cart.subtotal))
print("Item count:", cart.itemCount)

line("Apply discount")
cart.discountCode = "SAVE10"
print(String(format: "Discount: %.2f", cart.discountAmount))
print(String(format: "Total: %.2f", cart.total))

line("Remove item (book)")
cart.removeItem(productId: book.id)
print("Item count after remove:", cart.itemCount)

line("Reference type behavior (class)")
func modifyCart(_ c: ShoppingCart) {
    c.addItem(product: headphones, quantity: 1)
}
modifyCart(cart)
print("Item count after external modify:", cart.itemCount)

line("Value type behavior (struct)")
let item1 = try! CartItem(product: laptop, quantity: 1)
var item2 = item1
try! item2.updateQuantity(5)
print("item1.quantity:", item1.quantity, "| item2.quantity:", item2.quantity)

line("Create order from cart")
let address = Address(street: "Kabanbay Batyr 12", city: "Almaty", zipCode: "050000", country: "Kazakhstan")
let order = Order(from: cart, shippingAddress: address)
print("Order ID:", order.orderId)
print("Order subtotal:", order.subtotal, "| total:", order.total)
print("Order itemCount:", order.itemCount)
print("Ship to:\n\(order.shippingAddress.formattedAddress)")

line("Modify cart after order (order is immutable snapshot)")
cart.clearCart()
print("Order itemCount still:", order.itemCount)
print("Cart itemCount now:", cart.itemCount)
