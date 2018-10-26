# README

Rails RSS Reader
================

An RSS reader implemented in Rails.

What is this thing?
-------------------

This repository is my first crack at implementing a Rails application. I figured that if I was going to build something that it might as well be something that I would actually use. As a result, here is an RSS reader that I made. 

Features
--------

There is still a lot of work to be done but so far you can:

* Add an RSS or Atom feed

* Sync feeds

* View all aggregated articles

* Save/delete articles for quick reference

* Do this all with your own account

I built this with a PostgeSQL database in mind.

Future Additions
----------------

Things I'd like to add:

* Automatic syncing of feeds in the system

* An API (and GraphQL)

* Secure this thing

* Add unit testing with rspec

* Properly deal with mailer functionality

* An admin panel to see trends (need to make sure this is all anonymized)

* Add more attributes to feeds and entries e.g.
    * Read/unread
    * Tags

* A way of organizing feeds and entries

* Exporting feed list as OPML for ingestion into Feedly etc.

* General functionality improvements

* a Dockerfile for deployment

