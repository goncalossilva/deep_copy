# Deep copy

Deep copy allows you to clone Active Record objects including its associations.

## Installation

Just require the "deep_copy" gem on your project. On Rails 2.3, that is:
    config.gem "deep_copy"
on your environment.rb

## Usage

Pick any Active Record object and call _deep\_copy_ on it. You can also include associations and except fields, like this:
    new_user = user.clone :include => :car, :exclude => [:name, {:car => [:number_of_wheels, :number_of_accidents]}]
In this example we're cloning a user, including its car. However, we're not cloning the user's name nor are we cloning his car's _number\_of\_wheels_ and _number\_of\_accidents_.

You can also go deeper (pun intended). In this example, we'll clone a lot of people (excluding their names):
    new_son = son.clone :include => [{:parent => grand_parent}, :siblings], :exclude => [:name, {:parent => [:name, :grand_parent => :name]}, {:siblings => :name}]
    
### Acknowledgements

This gem was inspired in Jan De Poorter's [deep_cloning](http://github.com/DefV/deep_cloning) plugin. All of this work is his, except for the gem part and the field exceptions in associations.

Copyright (c) 2010 Gonçalo Silva
