This README would normally document whatever steps are necessary to get the
application up and running.

* Ruby version: `(ruby 3.1.2)`

* Ruby Gems required: `rspec`

* Run rspec tests: `rspec test/all.rb`

* Run T&C Generator: `ruby TC_generator.rb`

![alt text](https://github.com/uday-kumar950/TC_generator/blob/master/output.png)

* T&C document creation contains three classes:

-***Section*** (Create group of clause objects for a section)

-***Clause*** (Section is the parent class for Clause, here creating Clause objects)

-***TC_generator*** (Create new transformed T&C document as showing in the above image)

Created separate parent class (Section) and clild class (Clause), so that group of clauses can be assigned to a section. And these classes can be used later as ActiveRecord models with has_many association. 
Also using TC_generator class, so that document transformation code can be kept separate from both Section and Clause classes. Using three different test files for these classes, so that it will be easy to add test functionality in the future.
`template.txt` file is being used to read template data. For static data currently using TemplateData module, this is not needed if dynamic data is present. 

This assignment took about 4 hours. In future, UI and ActiveRecord models can be integrated. And can also handle HTML tags for better readability in browser. Can also store errors in a separate log table, so that in future it will be easy to track different errors related to document transformation.
