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
├── routes      # go package that define the HTTP handlers application
│ └── ...
└── run.sh      # shell script to help with development and deployment
```

## Tools and Frameworks

This section documents the tools and frameworks used in the development of the dpgraham.com http server.

### Go

The [Go](https://golang.org/) was chosen as the optimal language for the dpgraham.com http server when I originally
deployed dpgraham.com to a resource constrained kubernetes cluster consisting of 5 Rock64 single board computers. The (
relatively) small size of the compiled binary, compared to Java or dynamic languages like python and Node.js, was
practical. I found that I enjoyed working with Go, I appreciated its simplicity, the static typing, its
performance, and the niche it has carved out for itself in web development ecosystem.

### Gin

[Gin](https://github.com/gin-gonic/gin) is a lightweight web framework for Go. Gin was chosen because it is idiomatic,
performant, and un-opinionated (especially compared to [Django](https://www.djangoproject.com/) which I have much more
experience with). I also chose it for its popularity, it's the most popular web framework for Go, and I wanted to
learn the most popular framework for professional opportunities.

