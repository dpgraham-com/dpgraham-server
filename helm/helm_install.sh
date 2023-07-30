#!/bin/bash
helm install "$RELEASE" --set db_password="$DB_PASSWORD" --set db_user="$DB_USER" .
