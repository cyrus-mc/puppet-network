# == Class: network::params
#
# Network parameters class
#
# === Parameters
#
# Document parameters here.
#
# none
#
# === Variables
#
# none
#
# === Examples
#
#  class network inherits network::params { }{
#
# === Authors
#
# Matthew Ceroni <matthew.ceroni@8x8.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class network::params {

  case $::operatingsystem {
    CentOS, RedHat: {
      $supported = true
    }
    default: {
      $supported = false

      notify { "${module_name}_unsupported":
        message => "The ${module_name} module is not supported on ${::operatingsystem}",
      }
    }
  }

  if $supported {
    $service          = hiera('network::params::service', 'network')
    $global_c_file    = hiera('network::params::global_c_file', '/etc/sysconfig/network')
    $interface_c_path = hiera('network::params::interface_c_path', '/etc/sysconfig/network-scripts')
  }

}
