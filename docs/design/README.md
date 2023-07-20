# Design

this section documents any design patterns or decisions made in the development of the http server (hosted in this
repo). The design of the front end is documented in the [dpgraham-client](https://github.com/dpgraham/dpgraham-client).

## Table of Contents

- [Intro](#intro)
- [Organization](#organization)
- [Tools and Frameworks](#tools-and-frameworks)
    - [Go](#go)
    - [Gin](#Gin)
- [Design Decisions](#design-decisions)
    - [Dependency Injection](#database-2)
    - [Database access](#database-2)

## Intro

The dpgraham-server repo contains the source code for the dpgraham.com http server. The server is primarily responsible
for serving the front end to hydrate the client side application. The server also provides API endpoints to track client
usage (coming soon).

### *This project is intentionally overkill*

There no way around it, this project is overkill. I'm using this project as a way to learn skill up. It's an excuse to
learn new tools (kubernetes, terraform, go, gin, GCP, React.js to name a few) and learn how to architect a project from
the ground up.

## Organization

A high level overview of the source files, how their organized into packages, and what they do.

```
├── configs     # configuration files
├── db          # go package for interacting with the database
│ ├── ...
│ ├── fixtures  # test fixtures for the database
│ │ └── ...
│ └── migrations # database migrations
│   └── ...
├── main.go     # entry point for the application
├── models      # go package that defines the entities/structs for the application
│ └── ...
├── routes      # go package that define the routes for the application
│ └── ...
└── run.sh      # shell script to help with development and deployment
```
