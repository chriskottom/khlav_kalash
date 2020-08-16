# SOLUTION

## Solving the requirements 👍

The requirements as stated were pretty straightforward, and I tried to implement
them as best I understood them without a lot of additional fluff.

**1. Add an email format validation**
I opted for a basic Rails validation with a RegExp for email format -
essentially, two segments separated by an "at" sign.  This I did instead of
using a really complex pattern that would be hard for most developers to
decipher or adding a separate dependency which would effectively do the same
thing.

**2. Set at least the following fields as mandatory: first name, country, postal_code, email**
Again, I solved these with basic validations.  Nothing fancy.

**3. Charge cards using Stripe Elements**
**4. As we are also charging EU customers it might be interesting to support Strong Customer Authentication (SCA)**
I followed the workflow described in the linked video fairly closely:

![Payments workflow](https://stripe.com/img/docs/payments/accept-a-payment-web.png)

To keep things as simple as possible, I'm just storing the identifier of the
created `Stripe::PaymentIntent` against the Order in the database and using the
Stripe gem to fetch and create it when needed.

I put a little extra effort into proving out the main checkout workflows
(without SCA, affirmative and negative SCA auth) using Rails system tests since
these are critical to the application.

## Challenges 🤔

Because Stripe has only just recently started support in my home country (CZ),
I'm less familiar with their product offerings than I should be, so there were a
few struggles getting set up and working with Elements.  I've gotta say, though,
that after working with it, it's pretty slick, and the workflow for SCA really
Just Works.  I was glad to have the chance to get acquainted with it.

Writing system tests to incorporate credit card entry and managing SCA scenarios
was a little bit of a pain as well, mostly because of Stripe's extensive use of
`iframe` components all over the place.  Fortunately, a lot of other developers
seem to have had similar problems, so a good amount has been written about how
to solve it.

## Future improvements 🔮

There were plenty of additional improvements that I could have made but chose
not to in the interest of delivering the required updates.  Shipped > perfect.
Also, since I'm working on this from our family holiday at the beach, I needed
to balance this exercise with tossing my kids into the water. 🏖️

- I consciously avoided any extensive styling of the user interface, though clearly there's a lot that could be done there.
- The Order model is dead simple right now.  If the system grows in the future, it might make sense to extract customer and/or delivery information to separate models or concerns and add the ability to order in quantities larger than 1.
- In a real life e-commerce system, customer payment information will probably need to be tracked as its own thing that includes payment status, taxes, and so on.  Based on the requirements for this exercise, though, the additional complexity didn't seem warranted, so for the moment, I'm assuming YAGNI.
- The system creates a new `Stripe::PaymentIntent` each time the new order page is loaded which doesn't seem to be harming anything but also doesn't seem particularly efficient or to fit with intended use.  With more time (and probably as part of the Payment model extraction described in the previous bullet), it might make sense to refactor the checkout workflow so that the payment is only initiated after the user clicks the "Pay" button.  This would probably require an API endpoint that would generate a new Payment in the application DB and respond with the PaymentIntent identifier to include it in further interactions with Stripe.

---

Looking forward to speaking with you further, and wishing you all the best of
luck in your search!
