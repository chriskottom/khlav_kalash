# README

## We sell khlav kalash, only [khlav kalash](https://www.youtube.com/watch?v=4NFv5IGP2uA), $2.99 per unit

For decades we've been selling khlav kalash on the street but now, we are preparing our biggest leap ever… Selling khlav kalash online!

* The app has a single model, "Order" which represents orders made by customers
* Customers can enter their billing details and pay using a bank card (in the "new" action).
* After finishing the payment process, a page with the ticket is show to the customer (the "permalink" action).
* There are two separated areas,
    - Customers are only authorized to execute "new", "create" and "permalink" actions
    - The rest of the CRUD actions are restricted to the admin user (seller) only. Those pages are protected by basic http authentication (user: `admin`, password: `password`)

We need to:

* Add an email format validation
* Set at least the following fields as mandatory: `first name, country, postal_code, email`
* Charge cards using Stripe Elements (https://stripe.com/docs/js/elements_object/create). As we are also charging EU customers it might be interesting to support Strong Customer Authentication (SCA). Stripe has a nice tutorial on how implement it: https://www.youtube.com/watch?v=95qSebQrm5E

You can add any other resource you need to finish the task (new dependencies, columns, models …)

## Specifications

Built with rails 5.2.4.1 over ruby 2.5.3

Install the dependencies
```
bundle install
```

Start the puma server with
```
rails s
```

Run database migrations with
```
rails db:migrate
```

Finally, you'll need to set up secure credentials for your own instance of the
app by deleting the file at `config/credentials.yml.enc`, running
`rails credentials:edit` and editing the file to include the following added
entries.

```
admin:
  username: admin
  password: password

stripe:
  publishable_key: YOUR_STRIPE_PUBLISHABLE_KEY
  secret_key: YOUR_STRIPE_SECRET_KEY

# Used as the base secret for all MessageVerifiers in Rails, including the one protecting cookies.
secret_key_base: ...
```
