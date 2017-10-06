pkg_name=sample-node-app
pkg_origin=your_origin
pkg_scaffolding="core/scaffolding-node"
pkg_version="1.0.1"
pkg_exports=(
    [port]="app.port"
)
declare -A scaffolding_env

# Define path to config file
scaffolding_env[APP_CONFIG]="{{pkg.svc_config_path}}/config.json"
