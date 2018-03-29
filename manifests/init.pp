# Class: holland
# ===========================
#
# This module will install and configure holland on a system. Holland is a database backup tool for MySQL and PostgreSQL databases. http://hollandbackup.org
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `modules`
# Type: Variant[Array,String,undef]
# Default: undef
# List of backup modules to install.
# e.g. [ 'mysqldump', 'xtrabackup' ]
#
# * `package_prefix`
# Type: String
# Default: 'holland-'
# String to prefix to module names when installing.
#
# * `package_name`
# Type: String
# Default: 'holland'
# The package name to use when installing the main holland package.
#
# Examples
# --------
#
# @example
#    class { 'holland':
#      modules => [ 'mysqldump', 'xtrabackup' ],
#    }
#
# Authors
# -------
#
# Damon Conway <vstraylight@gmail.com>
#
# Copyright
# ---------
#
# Copyright 2018 Damon Conway, unless otherwise noted.
#
class holland (
  Optional[Hash] $backupsets                        = undef,
  Variant[Array,String,Undef] $modules              = $holland::params::modules,
  Enum['absent','present','latest'] $package_ensure = $holland::params::package_ensure,
  String $package_name                              = $holland::params::package_name,
  String $package_prefix                            = $holland::params::package_prefix,
  $package_repo                                     = $holland::params::package_repo,
) inherits holland::params {

  contain holland::install
  contain holland::setup
  contain holland::backupsets

  Class['holland::install']
  ~>Class['holland::setup']
  ~>Class['holland::backupsets']

}
