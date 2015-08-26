# == Class: network::global
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
class network::global (
  $hostname          = hiera('network::global::hostname'),
  $gateway           = hiera('network::global::gateway'),
  $gateway_dev       = hiera('network::global::gatewaydev'),
  $ipv6_networking   = hiera('network::global::ipv6_networking'),
  $ipv6_gateway      = hiera('network::global::ipv6_gateway'),
  $ipv6_gateway_dev  = hiera('network::global::ipv6_gateway_dev'),
  $nis_domain        = hiera('network::global::nis_domain'),
  $nozeroconf        = hiera('network::global::nozeroconf') ) inherits network::params {

  # validate type of data, not actual value as that is done within the template
  validate_string($hostname, $gateway, $gateway_dev, $ipv6_gateway, $ipv6_gateway_dev, $nis_domain)
  validate_bool($ipv6_networking, $nozeroconf)

  # only run on supported platforms
  if $network::params::supported {

    # generate /etc/sysconfig/network file
    file {
      'sysconfig.network':
      ensure  => 'present',
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
      path    => '/etc/sysconfig/network',
      content => template('network/network.erb');
    }

  }

}
