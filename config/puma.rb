#!/usr/bin/env puma

# Puma configuration file

environment 'development'
daemonize false
port ENV['PORT']

on_worker_boot do
  # per worker configuration here
end

on_restart do
  # do cleanup here
end
