# Rstudio

running on port 80

username: ubuntu
password: bioc

# Shiny Server

Running on port 3838

User directories not yet in place, but the following will set them up:

Add in config block in `/etc/shiny-server/shiny-server.conf`:

```
  .......
  location /users {
    run_as :HOME_USER:;
    user_dirs;
  }
}
```

The files in `~/ShinyApps` will be found at http://..../users/USERNAME/...

