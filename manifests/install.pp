# holland::install
#
# Installs the holland packages.
#
# @summary Install holland packages and module packages.
#
# @example
#   include holland::install
#
class holland::install {

  $modules = $holland::merge_modules ? {
    false   => $holland::modules,
    default => lookup('holland::modules', Optional[Hash], 'deep', undef)
  }

  $package_ensure = $holland::package_ensure
  $package_name   = $holland::package_name
  $package_prefix = $holland::package_prefix
  $package_repo   = $holland::package_repo

  Package {
    ensure  => $package_ensure,
    require => $package_repo,
  }

  package { 'holland': name => $package_name, }

  package { "${package_prefix}common": }

  if $modules {
    $modules.each |$mod,$opts| {
      $mod_name = "${package_prefix}${mod}"
      debug { "holland::install::mod_name = $mod_name": }
      package { $mod_name: * => $opts }
    }
  }

}
