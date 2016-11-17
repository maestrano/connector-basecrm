# connector-basecrm
-------------------------------------
[![Code Climate](https://codeclimate.com/github/maestrano/connector-basecrm/badges/gpa.svg)](https://codeclimate.com/github/maestrano/connector-basecrm)
-------------------------------------
The aim of this connector is to implement data sharing between Connec! and BaseCRM

### Configuration

Configure your BaseCRM application. To create a new BaseCRM application:
https://app.futuresimple.com

### Access Maestrano Developer Platform and create a sandbox application

:soon: :construction:


Edit the configuration file `config/application-sample.yml` with the correct credentials (both BaseCRM's and Maestrano's Developer Platform ones).
```
encryption_key1: ''
encryption_key2: ''

base_client_id: 'your_base_id'
base_client_secret: 'your_base_secret'

REDIS_URL: redis://localhost:6379/0/connector-base

MNO_DEVPL_HOST: https://dev-platform.maestrano.io
MNO_DEVPL_API_PATH: /api/config/v1/marketplaces
MNO_DEVPL_ENV_NAME: base-uat
MNO_DEVPL_ENV_KEY: 'your_local_env_key'
MNO_DEVPL_ENV_SECRET: 'your_local_env_secret'

```

### Run the connector locally against the Maestrano UAT environment

### Run the connector
#### First time setup
```
# Install bundler and update your gemset
gem install ruby-2.3.1
gem install bundler
bundle
```

#### Start the application
```
bin/rails s puma -p 3001
```
