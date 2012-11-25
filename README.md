Commands:

    * Static Pages:

        rails generate controller StaticPages home --no-test-framework.txt

    * Authentication:

        Add gem 'devise' to GemFile
        bundle install
        rails generate devise:install
        rails generate devise User

        * Note if postgres is not running: 

            sudo -u postgres /Library/PostgreSQL/9.1/bin/pg_ctl -D /Library/PostgreSQL/9.1/data start

        bundle exec rake db:migrate

        * Add user properties, we're gonna use a username to log in:

            rails generate migration AddBasicDetailsToUsers username:string firstname:string lastname:string about:string
            bundle exec rake db:migrate

        * Get our own copies of the views to customize:

            rails generate devise:views

        * Create roles:

            rails generate model Role name:string
            rails generate migration users_roles user_id:integer role_id:integer
            rake db:migrate

        * Update DB with seed users and roles:

          bundle exec rake db:seed

Notes:

    * Authorization:
        * Roles via cancan:
            * admin
                * do anything
            * archive_owner
                * do anything to an archive
            * archive_member
                * view anything in an archive
            * visitor:
                * view public portfolio
                * view public user pages
