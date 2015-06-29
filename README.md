# Getting the script
Follow the steps for installing the environment.
```sh
$ git clone git@github.com:meinac/mo_ch.git
$ cd mo_ch
$ bundle
```

# Running the script
In the root directory of the project, run
```sh
$ ruby src/main.rb -p PATH_OF_THE_CSV_FILE
```
You can also run this script with -h option to see available options
```sh
$ ruby src/main.rb -h
```

# Running tests
In the root directory of the project, run
```sh
$ rspec
```

# About the project internals
This project uses Arel for generating SQL output. Arel depends on ActiveRecord gem because it requires database connection to determine syntax of the SQL. For this dependency I've configured ActiveRecord to use SQLite as adapter. You can see supported adapters for Arel [here](https://github.com/rails/arel/blob/master/lib/arel/visitors.rb).
