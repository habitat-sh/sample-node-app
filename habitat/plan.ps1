# This file is the heart of your application's habitat.
# See full docs at https://www.habitat.sh/docs/reference/plan-syntax/

# Required.
# Sets the name of the package. This will be used along with `$pkg_origin`,
# and `$pkg_version` to define the fully-qualified package name, which determines
# where the package is installed to on disk, how it is referred to in package
# metadata, and so on.
$pkg_name="sample-node-app"

# Required unless overridden by the `HAB_ORIGIN` environment variable.
# The origin is used to denote a particular upstream of a package.
$pkg_origin="origin0"

# Required.
# Sets the version of the package
$pkg_version="0.1.0"

# Optional.
# The name and email address of the package maintainer.
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"

# Optional.
# An array of valid software licenses that relate to this package.
# Please choose a license from http://spdx.org/licenses/
$pkg_license=@("Apache-2.0")

# Optional.
# The scaffolding base for this plan.
# $pkg_scaffolding="some/scaffolding"

# Optional.
# A URL that specifies where to download the source from. Any valid wget url
# will work. Typically, the relative path for the URL is partially constructed
# from the pkg_name and pkg_version values; however, this convention is not
# required.
# $pkg_source="http://some_source_url/releases/$pkg_name-$pkg_version.zip"

# Optional.
# The resulting filename for the download, typically constructed from the
# pkg_name and pkg_version values.
# $pkg_filename="$pkg_name-$pkg_version.zip"

# Required if a valid URL is provided for pkg_source or unless Invoke-Verify is overridden.
# The value for pkg_shasum is a sha-256 sum of the downloaded pkg_source. If you
# do not have the checksum, you can easily generate it by downloading the source
# and using Get-FileHash. Also, if you do not have
# Invoke-Verify overridden, and you do not have the correct sha-256 sum, then the
# expected value will be shown in the build output of your package.
$pkg_shasum="TODO"

# Optional.
# An array of package dependencies needed at runtime. You can refer to packages
# at three levels of specificity: `origin/package`, `origin/package/version`, or
# `origin/package/version/release`.
$pkg_deps=@()

# Optional.
# An array of the package dependencies needed only at build time.
$pkg_build_deps=@()

# Optional.
# An array of paths, relative to the final install of the software, where
# libraries can be found for native builds.
# $pkg_lib_dirs=@("lib")

# Optional.
# An array of paths, relative to the final install of the software, where
# headers can be found.
# $pkg_include_dirs=@("include")

# Optional.
# An array of paths, relative to the final install of the software, where
# binaries can be found. Used to populate $ENV:PATH for software that depends on
# your package.
# $pkg_bin_dirs=@("bin")

# Optional.
# The command for the Supervisor to execute when starting a service. You can
# omit this setting if your package is not intended to be run directly by a
# Supervisor of if your plan contains a run hook in hooks/run.
# $pkg_svc_run="MyBinary.exe"

# Optional.
# A hashtable representing configuration data which should be gossiped to peers. The keys
# in this hashtable represent the name the value will be assigned and the values represent the toml path
# to read the value.
# $pkg_exports=@{
#   host="srv.address"
#   port="srv.port"
#   ssl-port="srv.ssl.port"
# }

# Optional.
# An array of `$pkg_exports` keys containing default values for which ports that this package
# exposes. These values are used as sensible defaults for other tools. For example, when exporting
# a package to a container format.
# $pkg_exposes=@("port," "ssl-port")

# Optional.
# A hashtable representing services which you depend on and the configuration keys that
# you expect the service to export (by their `$pkg_exports`). These binds *must* be set for the
# Supervisor to load the service. The loaded service will wait to run until it's bind becomes
# available. If the bind does not contain the expected keys, the service will not start
# successfully.
# $pkg_binds=@{
#   database="port host"
# }

# Optional.
# Same as `$pkg_binds` but these represent optional services to connect to.
# $pkg_binds_optional=@{
#   storage="port host"
# }

# Optional.
# The number of seconds to wait for a service to shutdown. After this interval
# the service will forcibly be killed. The default is 8.
# $pkg_shutdown_timeout_sec=8

# Required for core plans, optional otherwise.
# A short description of the package. It can be a simple string, or you can
# create a multi-line description using markdown to provide a rich description
# of your package.
# $pkg_description="Some description."

# Required for core plans, optional otherwise.
# The project home page for the package.
# $pkg_upstream_url="http://example.com/project-name"

# Callback Functions
#
# When defining your plan, you have the flexibility to override the default
# behavior of Habitat in each part of the package building stage through a
# series of callbacks. To define a callback, simply create a shell function
# of the same name in your plan.sh file and then write your script. If you do
# not want to use the default callback behavior, you must override the callback
# with an empty implementation in the function definition.
#
# Callbacks are defined here with either their "Invoke-DefaultX", if they have a
# default implementation, or empty if they have no default implementation. If callbacks do
# nothing or do the same as the default implementation, they can be removed from
# this template.
#
# The default implementations (the Invoke-Default* functions) are defined in the
# plan build script:
# https://github.com/habitat-sh/habitat/tree/master/components/plan-build-ps1/bin/hab-plan-build.ps1

# The default implmentation does nothing. You can use it to execute any
# arbitrary commands before anything else happens.
function Invoke-Begin {
  Invoke-DefaultBegin
}

# The default implementation is that the software specified in $pkg_source is
# downloaded, checksum-verified, and placed in $HAB_CACHE_SRC_PATH/$pkgfilename,
# which resolves to a path like /hab/cache/src/filename.zip. You should
# override this behavior if you need to change how your binary source is
# downloaded, if you are not downloading any source code at all, or if your are
# cloning from git. If you do clone a repo from git, you must override
# Invoke-Verify with an empty implementation.
function Invoke-Download {
  Invoke-DefaultDownload
}

# The default implementation tries to verify the checksum specified in the plan
# against the computed checksum after downloading the source zip to disk.
# If the specified checksum doesn't match the computed checksum, then an error
# and a message specifying the mismatch will be printed to stderr. You should
# not need to override this behavior unless your package does not download
# any files.
function Invoke-Verify {
  Invoke-DefaultVerify
}

# The default implementation removes the $HAB_CACHE_SRC_PATH/$pkg_dirname folder
# in case there was a previously-built version of your package installed on
# disk. This ensures you start with a clean build environment.
function Invoke-Clean {
  Invoke-DefaultClean
}

# The default implementation extracts your zipped source file into
# $HAB_CACHE_SRC_PATH.
function Invoke-Unpack {
  Invoke-DefaultUnpack
}

# The default implementation does nothing. At this point in the build process,
# the zipped source has been downloaded, unpacked, and the build environment
# variables have been set, so you can use this callback to perform any actions
# before the package starts building.
function Invoke-Prepare {
  Invoke-DefaultPrepare
}

# There is no default implementation of this callback. You should override this
# callback with the commands necessary to build your application.
function Invoke-Build {
  Invoke-DefaultBuild
}

# The default implementation runs nothing during post-compile. To use this callback, two
# conditions must be true. A) Invoke-Check function has been declared, B) DO_CHECK
# environment variable exists and set to true, $ENV:DO_CHECK=$true.
function Invoke-Check {}

# There is no default implementation of this callback. Typically you will override
# this callback to copy the compiled binaries or libraries in
# $HAB_CACHE_SRC_PATH/$pkg_dirname to $pkg_prefix.
function Invoke-Install {
  Invoke-DefaultInstall
}

# The default implmentation does nothing. This is called after the package has
# been built and installed. You can use this callback to remove any temporary
# files or perform other post-install clean-up actions.
function Invoke-End {
  Invoke-DefaultEnd
}
