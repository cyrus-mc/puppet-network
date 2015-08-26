# == Class: network::resolv
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
class network::resolv (
  $servers       = hiera('network::resolv::nameservers'),
  $domain        = hiera('network::resolv::domainname'),
  $search_prefix = hiera('network::resolv::search'),
  $options       = hiera('network::resolv::options') ) inherits network::params {

  # validation in class just checks whether supplied type is correct
  # template will validate whether the actual data itself is good
  # nameserver(s) must be supplied (required)
  if !is_string($servers) and !is_array($servers) {
    fail('network::resolv::servers must be either a string or an array')
  }

  if !is_string($domain) {
    fail('network::resolv::domain must be a string')
  }

  if !is_string($search_prefix) and !is_array($search_prefix) {
    fail('network::resolv::search must be a string or an array')
  }

  if !is_hash($options) {
    fail('network::resolv::options must be a hash if supplied')
  }

  # only run on supported platforms
  if $network::params::supported {

    # generate /etc/resolv.conf
    file {
      'etc.resolv_conf':
      ensure  => 'present',
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
      path    => '/etc/resolv.conf',
      content => template('network/resolv.conf.erb');
    }

  }

}
