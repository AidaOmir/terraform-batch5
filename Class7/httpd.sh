#!/bin/bash

sudo yum install httpd -y
sudo systemctl start http
sudo systemctl enable httpd