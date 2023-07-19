# Connecting to Google Cloud SQL from Cloud Run

This is a scratch note for future documentation (and future me) that discusses how to set up database 
access from Cloud Run to Cloud SQL.

## Google documentation links
- [Connect from Cloud Run](https://cloud.google.com/sql/docs/postgres/connect-run#private-ip)
    - This is the high level starting point
- [cloud sql auth proxy](https://cloud.google.com/sql/docs/postgres/connect-auth-proxy)
    - This is the tool that allows you to connect to the database from your local machine. requires a public IP address(?) 
- [Serverless VPC connectors](https://cloud.google.com/run/docs/configuring/connecting-vpc#terraform_1)
- [Digital Ocean tutorial on IP addressed, Subnets, CIDR notation](https://www.digitalocean.com/community/tutorials/understanding-ip-addresses-subnets-and-cidr-notation-for-networking)


## Notes
- I have a postgres instance set up with both a public and private IP address. Ideally the public address will be removed
in the future for added security. With public access turned on, I can connect to the database from my local machine
using the cloud sql auth proxy 
- Serverless entities (Cloud Run, Cloud Function, App Engine) cannot access resources on a Google VPC without a VPC connector.
Right now, we're using a crazy simple VPC connector with hard coded CIDR blocks. Needs to be fixed.
- I need to learn more about using subnets, routers, connectors and networking in general (masks, CIDR blocks, etc.)
- Currently, we also pass all parts of the database connection string as environment variables to the Cloud Run instance.
which is a security risk. This also needs to be fixed (but this is mostly for POC purposes at the moment anyway).