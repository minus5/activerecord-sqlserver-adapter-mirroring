# activerecord-sqlserver-adapter-mirroring

A simple plugin which adds database mirroring support for [Rails MS Sql
Server Adapter](https://github.com/rails-sqlserver/activerecord-sqlserver-adapter).

Targets Rails 3.2.x and activerecord-sqlserver-adapter 3.2.3.

## Usage

Add to the Gemfile:

    gem 'tiny_tds'
    gem 'activerecord-sqlserver-adapter-mirroring'

Add mirroring section to the database.yml:

    development:
      adapter:  sqlserver
      host:     primary
      database: ...
      username: ...
      password: ...
      mirror: 
        host: mirror

When the connection to the *primary* host fails, adapter will
reconnect to the *mirror* host.


## Running tests

 * Create database named *activerecord\_unittest\_mirroring*.
 * Configure mirroring for that database. 
 * Create user *rails* without password, with sysadmin role on both
   servers. Sysadmin rights are needed because rails user will initiate
   mirroring failover.
 * Ensure that one server responds to the *primary* hostname, and another
   to the *mirror* hostname.
 * Run tests
 
     rake test
     
You can an edit test/database.yml to define better suited parameters
for your system.
