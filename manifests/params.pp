# holland::params
#
# Default parameters for the holland class.
#
# @summary Default parameters for the holland class.
#
class holland::params {

  $modules        = undef
  $package_ensure = 'present'

  case $facts['os']['family'] {
    'RedHat': {
      $config_d       = '/etc/holland'
      $config_file    = "${config_d}/holland.conf"
      $package_name   = 'holland'
      $package_prefix = 'holland-'
      $package_repo   = Yumrepo['epel']
    }
    default: {
      fail("Unsupported osfamily: ${facts['os']['family']}")
    }
  }

}
