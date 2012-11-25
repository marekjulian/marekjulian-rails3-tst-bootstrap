# Authentication and Roles

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

# Image Storage

  Images will be stored on Flickr. Flickr images will be included in sets, and associated with an image variant.

  Images have variants, and each variant can have one or more styles.

# Accessing Images

  When images are linked, a Flickr URL will be generated for an image variant and a particular style. However, images can
  also be referenced via URLs on the marekjulian.com domain. These will simply redirect to the appropriate Flickr URL.

## marekjulain.com URLs

Images can be referenced via the marekjulian.com domain.

### images

  /media-archives/<archive id>/images/<image id>[.<extension>][?<image params>]

    <extension> ::= <image mime type extension> || json

    <image params> :== <image param>+

      <image param> ::= <variant param> || <style param>

        <variant param> ::= variant=<variant selector>

          <variant value> ::= master || web  || web_default || thumb || thum_default

            Notes:
              Values of master, web_default and thumbnail_default will return one and only one image.
              Values of web and thumbnail can return a list of images when the <extension> is json.

        <style param> ::= style=<style selector>

          <style selector> ::= original || web || thumb

  IE: /media-archives/1/images/1.jpg?variant=web

### image variants

  /media-archives/<archive id>/images/<image id>/image_variants/<image variant id>.<extension>[?<style param>]

    <extension> ::= <image mime type extension> || json

    <style param>: See images above.

# Commands Used During Development

  * Static Pages Controller:

      rails generate controller StaticPages home --no-test-framework.txt

  * Authentication:
`
        Add gem 'devise' to GemFile
        bundle install
        rails generate devise:install
        rails generate devise User
`

  * DB Admin:

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
