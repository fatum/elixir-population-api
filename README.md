# Population API

Elixir implementation of Population API

* Framework-less
* GraphQL API
* PostgreSQL

## Setup environment

```
  brew install elixir
  mix deps.get
```

## Setup project (database and import)

```
  mix do ecto.create, ecto.migrate, import
```

## Run server

```
  mix run --no-halt
```
