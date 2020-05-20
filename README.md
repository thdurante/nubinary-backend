# NuBinary - Backend

Tech challenge for the NuBinary recruiting process.

### Installation

All the following commands must be executed from the project's root directory:

```bash
$ bundle # install dependencies
$ cp config/database.yml.sample config/database.yml # database config file (check credentials here)
$ rails db:create db:migrate # database creation and migration
$ rails s # start server (default port 3000)
$ rubocop # static code analyzer
$ rspec # run test suite
```

### Insomnia

The insomnia json with all the requests can be found in: `Insomnia_NuBinary_Backend.json`