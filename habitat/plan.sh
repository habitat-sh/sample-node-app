pkg_name=sample-node-app
pkg_origin=ryankeairns
pkg_scaffolding="core/scaffolding-node"
pkg_version="0.2.0"

declare -A scaffolding_env

# Define path to config file
scaffolding_env[APP_CONFIG]="{{pkg.svc_config_path}}/config.json"

