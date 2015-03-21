## AuditRails
[![Gem Version](https://badge.fury.io/rb/audit_rails.png)](http://badge.fury.io/rb/audit_rails)[![Build Status](https://travis-ci.org/gouravtiwari/audit_rails.png?branch=master)](https://travis-ci.org/gouravtiwari/audit_rails)[![Coverage Status](https://coveralls.io/repos/gouravtiwari/audit_rails/badge.png?branch=master)](https://coveralls.io/r/gouravtiwari/audit_rails?branch=master)[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/gouravtiwari/audit_rails/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

An action based auditor, which has internal as well as outgoing link tracking.

It is inspired from many great audit gems in rails community that audits model and I was looking for a gem which can audit based on actions as well as can audit link tracking. This gem just serve this purpose.

Roughly it is doing similar to what Omniture does, but has very minimum features for now.

Now also has analytics(charts) for User counts

### Example

* [Audit Rails example](http://www.audit-rails.info)
* [Audit Rails example code](https://github.com/gouravtiwari/audit_rails_example)

#### User visit & page view count by date range:
![Audits](https://github.com/gouravtiwari/audit_rails/raw/master/docs/audit-rails.png)

### Pre-requisites:
For rails 4.0 & 3.2.6 + and ruby>1.9.2:

    gem install audit_rails

or in application’s Gemfile add:

    gem ‘audit_rails’

### Install

    rails g audit_rails:install
    
### Usage
#### To add audit migration:

    rake audit_rails:install:migrations

#### To add additional attributes to Audit (let's say book_id):

Add attributes to migration generated from above rake task

Inherit from AuditRails::Audit:

    # MyApp/app/models/audit.rb
    class Audit < AuditRails::Audit
      # attr_accessible is only needed for Rails 3.2.6+ not needed for Rails 4+
      attr_accessible :action, :controller, :description, :user_name, 
      :book_id
      # add associations as usual:
      belongs_to :book
    end

#### To log user events
Simply call 'add_to_audit' with desired parameters in any controller (as this is now a helper method included in application_controller.rb of application)

#### To override controller's add_to_audit method (or the helper method)
Simply re-implement in application_controller.rb

#### To track user login (one per day) 
Override current_user method in application controller, e.g.:

    def current_user
      add_to_audit('login', 'sessions', "John Smith")
      super
    end

#### To see Analytics

    Go to <app-url>/audit_rails/audits/analytics

#### To download the audit report as xls file:
Add this to initializers/mime_types.rb

    Mime::Type.register "application/vnd.ms-excel", :xls

Use below link in views:

    link_to audit_rails.audits_path(:format => "xls")

### What's next?
  - Rails 4+ support
  - ReactJS awesomeness
  - geoip integration
  - World Map Integration

### Changelog

    https://github.com/gouravtiwari/audit_rails/blob/master/CHANGELOG.rdoc

### Contribute

You are welcome to contribute and add more feature to this gem. I have added rspec and guard to it to run tests quickly. So running specs shouldn't be a problem.

Please fork it, add specs and send a pull request!

### License
This project rocks and uses MIT-LICENSE.
