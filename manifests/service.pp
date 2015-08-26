# == Class: network::service
#
# Full description of class network here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'network':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Matthew Ceroni <matthew.ceroni@8x8.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class network::service ( $enabled ) inherits network::params {

  $ensure = $enabled ? {
    true    => 'running',
    default => 'stoppped',
  }

  # only run on supported platforms
  if $network::params::supported {

    service { $network::params::service:
      ensure     => $ensure,
      enable     => $enabled,
      hasrestart => true,
      hasstatus  => true,
    }

  }

}
