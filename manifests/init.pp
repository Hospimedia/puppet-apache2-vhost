define passenger_vhost(
  $rails_env          = "${name}",
  $server_name        = "${name}.${domain}",
  $server_aliases     = "${name}.${fqdn}",
  $server_admin       = "admin@${domain}",
  $base_dir           = "/apps",
  $app_root           = "${base_dir}/${name}/current",
  $port               = 80,
  $priority           = 999)
{
  include apache

  File {
    owner => root,
    group => root,
    mode => 644,
    require => Package["httpd"],
    notify => Service["httpd"]
  }

  file {
    "/etc/apache2/sites-available/${name}":
      ensure => file,
      content => template("passenger_vhost/passenger_vhost.erb");
    "/etc/apache2/sites-enabled/${priority}-${name}":
      ensure => link,
      target => "/etc/apache2/sites-available/${name}";
  }
}
