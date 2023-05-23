# ruby-rspec-test
Welcome to the Ruby Rspec test

# Requirements
- Write the unit tests for the Order class and make sure the test code coverage is 100% for all of the classes: Order, OrderItem, User

  <img width="1442" alt="Screenshot 2023-05-23 at 21 40 46" src="https://github.com/moneyforwardvietnam/ruby-internal-challenge/assets/48194234/3a7aca2a-eac5-4460-88c5-f6aa51da84a2">


# How to join the test?
- Clone the repository
- Create a new folder with your nickname in the `/day-1` and copy all files & folders in `/day-1/demo` to your folder

  Example: (assump that you are staying in the repository)
    ```
      cd day-1
      mkdir bill
      cp -rf demo/* bill
    ```
- Run bundle:
  ```
    cd bill
    bundle config set --local path '.bundle'
    bundle install
  ```
  It will install the gems in to the .bundle folder
- Write the unit tests for the Order class in file `spec/order_spec.rb`
- Run rspec
  ```
    rspec spec
  ```
- Check the coverage report in `tmp/coverage/index.html` (you can open it in the browser)
- When you've done the test, you can push your code into new branch (with named `day-1/your-name`) and create the pull request to main branch.
