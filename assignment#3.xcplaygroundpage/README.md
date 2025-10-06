Shopping Cart System

iOS Development Course — Classes & Structs Assignment

⸻

Why did you choose class for ShoppingCart?

I decided to use a class for the ShoppingCart because the cart should have a single shared identity across the app.
When a user adds or removes items, it should update the same cart everywhere, not make a copy.
If I used a struct, every time I passed the cart to another function or variable, Swift would create a new copy.
That would mean that one function could add items, but another part of the program wouldn’t see the change.

So the cart is a reference type, meaning multiple variables can refer to the same instance.
This makes sense because a shopping cart acts like a shared container that the user edits continuously.

⸻

Why did you choose struct for Product and Order?

I used structs for Product and Order because they are simple data models that don’t need to have identity.
Two identical products with the same name, price, and ID are basically the same thing — there’s no need to track them as separate objects.

Structs also make these types safe to copy. For example, if I copy a product, I get an independent copy of its data, and changing one won’t affect the other.
The same logic applies to Order. Once an order is created, it should be a fixed snapshot of what was in the cart at checkout.
Making it a struct ensures it’s immutable and stays the same even if the cart changes later.

⸻

Explain one example where reference semantics matter in your code

Reference semantics matter in the ShoppingCart example.
I created a function modifyCart(_ cart: ShoppingCart) that adds a new item to the cart.
Because ShoppingCart is a class, the function doesn’t work with a copy — it modifies the same cart in memory.
When I check the original cart after the function call, the new item is still there.
This shows how reference semantics let multiple parts of the program work with the same shared object.

⸻

Explain one example where value semantics matter in your code

Value semantics are shown with the CartItem struct.
In the tests, I made two variables: item1 and item2, where item2 is a copy of item1.
Then I changed the quantity of item2, but item1 stayed the same.
This happens because structs in Swift are copied when assigned or passed.
It’s useful when you want independent pieces of data that don’t affect each other.

⸻

What challenges did you face and how did you solve them?

The hardest part was deciding which parts should be classes and which should be structs.
At first, I tried to make everything a struct, but then I realized the shopping cart wasn’t updating correctly when passed into a function.
That helped me understand the difference between value and reference types more clearly.

Another challenge was writing computed properties like subtotal, discountAmount, and total.
I solved that by using loops and the reduce function to sum all item subtotals.

Finally, I had some trouble with immutability in the Order struct.
I fixed it by making all properties let constants so that the order cannot change after creation.

Overall, I learned a lot about how Swift handles memory and data copying.
Now I understand when to use structs for simple data and when to use classes for shared objects.
