# Image Storage

Images are stored on Flickr. Flickr images will be included in sets, and 
associated with an image variant. Images have variants, and each variant can
have one or more styles available on Flickr.

# Accessing Images

When links are generated for image variants, a Flickr URL will be generated for
a particular style. However, images can also be referenced via URLs on the 
marekjulian.com domain. These will simply redirect to the appropriate Flickr URL.

## marekjulain.com URLs

Images and image variants can be referenced via the marekjulian.com domain.

### images

`
  /media-archives/<archive id>/images/<image id>[.<extension>][?<image params>]

    <extension> ::= <image mime type extension> || json

    <image params> :== <image param>+

      <image param> ::= <variant param> || <style param>

        <variant param> ::= variant=<variant selector>

          <variant value> ::= master || web  || web_default || thumb || thumb_default

            Notes:
              Values of master, web_default and thumb_default will return one and only one image.
              Values of web and thumb can return a list of images when the <extension> is json.

        <style param> ::= style=<style selector>

          <style selector> ::= original || web || thumb

  IE: /media-archives/1/images/1.jpg?variant=web
`

### image variants

  /media-archives/<archive id>/images/<image id>/image_variants/<image variant id>.<extension>[?<style param>]

    <extension> ::= <image mime type extension> || json

    <style param>: See images above.

# Authentication, Authorization and Roles

## Roles via cancan:

We use the cancan plugin to assign roles to users. The roles imply there are the following types of users: visitors, friends, archive_members, archive_owners, and admins. The roles are defined as follows:

  * visitor:
    * view portfolios
  * 'friend' : Everything 'visitor' can do + see things shared with them by 'owner' or 'archive_member'.
  * archive_member
    * view anything in an archive
    * share with friends
  * archive_owner
    * do anything to an archive
  * admin
    * do anything

The above roles imply impose the following constraints on things:

  * archive:
    * view: 'archive_owner', 'archive_members'
    * edit: 'archive_owner'
    * delete: 'archive_owner'
  * collections, images and image_variants:
    * view: 'archive_owner', 'archive_members', and 'friends' shared with.
    * edit: 'archive_owner'
    * delete: 'archive_owner'
  * portfolios:
    * view: everyone
    * edit: 'archive_owner'
    * delete: 'archive_owner'

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
