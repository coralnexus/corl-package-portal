/**
 * Apache powered Drupal web server profile.
 */
class coralnexus::portal::profile::apache_drupal {

  $base_name = 'coralnexus_apache_drupal'
  anchor { $base_name: }

  #-----------------------------------------------------------------------------
  # Required systems

	if ! defined('coralnexus::portal::profile::apache_server') {
  	class { 'coralnexus::portal::profile::apache_server': }
  }
  if ! defined('coralnexus::portal::profile::php') {
  	class { 'coralnexus::portal::profile::php': }
  }

  class { 'drupal': require => Class['coralnexus::portal::profile::php'] }

  #-----------------------------------------------------------------------------
  # Optional systems

  corl::include { 'apache_drupal_classes': require => Class['drupal'] }

  #-----------------------------------------------------------------------------
  # Resources

  corl_resources('coralnexus::portal::profile::apache_drupal::site', 'drupal::site', 'drupal::site_defaults')
}

#-------------------------------------------------------------------------------
# Resource definitions

define coralnexus::portal::profile::apache_drupal::site (
  $domain                   = $name,
  $build_dir                = $drupal::params::build_dir,
  $release_dir              = $drupal::params::release_dir,
  $aliases                  = $drupal::params::aliases,
  $site_ip                  = $drupal::params::site_ip,
  $databases                = $drupal::params::databases,
  $admin_email              = $drupal::params::admin_email,
  $use_make                 = $drupal::params::use_make,
  $repo_name                = $drupal::params::repo_name,
  $git_user                 = $git::params::user,
  $source                   = $drupal::params::source,
  $revision                 = $drupal::params::revision,
  $make_file                = $drupal::params::make_file,
  $include_repos            = $drupal::params::include_repos,
  $dir_mode                 = $drupal::params::dir_mode,
  $site_dir                 = $drupal::params::site_dir,
  $site_dir_mode            = $drupal::params::site_dir_mode,
  $settings_template        = $drupal::params::settings_template,
  $files_dir                = $drupal::params::files_dir,
  $base_url                 = $drupal::params::base_url,
  $cookie_domain            = $drupal::params::cookie_domain,
  $session_max_lifetime     = $drupal::params::session_max_lifetime,
  $session_cookie_lifetime  = $drupal::params::session_cookie_lifetime,
  $pcre_backtrack_limit     = $drupal::params::pcre_backtrack_limit,
  $pcre_recursion_limit     = $drupal::params::pcre_recursion_limit,
  $ini_settings             = $drupal::params::ini_settings,
  $conf                     = $drupal::params::conf,
  $apache_vhost_ip          = $apache::params::vhost_ip,
  $apache_priority          = $apache::params::priority,
  $apache_options           = $apache::params::options,
  $apache_http_port         = $apache::params::http_port,
  $apache_https_port        = $apache::params::https_port,
  $apache_use_ssl           = $apache::params::use_ssl,
  $apache_ssl_cert          = $apache::params::ssl_cert,
  $apache_ssl_key           = $apache::params::ssl_key,
  $apache_error_log_level   = $apache::params::error_log_level,
  $apache_rewrite_log_level = $apache::params::rewrite_log_level
) {

  $drupal_home_dir = "${apache::params::web_home}/drupal/${domain}"

  #---

  corl::file { $name:
    resources => {
      drupal_dir => {
        path    => "${apache::params::web_home}/drupal",
        ensure  => 'directory',
        require => File['apache_web_home']
      }
    }
  }

  #---

  drupal::site { $name:
    home_dir                => $drupal_home_dir,
    build_dir               => $build_dir,
    release_dir             => $release_dir,
    domain                  => $domain,
    aliases                 => $aliases,
    git_user                => $git_user,
    server_group            => $apache::params::group,
    admin_email             => $admin_email,
    use_make                => $use_make,
    repo_name               => $repo_name,
    source                  => $source,
    revision                => $revision,
    make_file               => $make_file,
    include_repos           => $include_repos,
    site_ip                 => $site_ip,
    dir_mode                => $dir_mode,
    site_dir                => $site_dir,
    site_dir_mode           => $site_dir_mode,
    settings_template       => $settings_template,
    files_dir               => $files_dir,
    databases               => $databases,
    base_url                => $base_url,
    cookie_domain           => $cookie_domain,
    session_max_lifetime    => $session_max_lifetime,
    session_cookie_lifetime => $session_cookie_lifetime,
    pcre_backtrack_limit    => $pcre_backtrack_limit,
    pcre_recursion_limit    => $pcre_recursion_limit,
    ini_settings            => $ini_settings,
    conf                    => $conf,
    require                 => Corl::File[$name]
  }

  #---

  apache::vhost::file { $name:
    doc_root          => $drupal_home_dir,
    server_name       => $domain,
    aliases           => $aliases,
    admin_email       => $admin_email,
    vhost_ip          => $apache_vhost_ip,
    priority          => $apache_priority,
    options           => $apache_options,
    http_port         => $apache_http_port,
    https_port        => $apache_https_port,
    use_ssl           => $apache_use_ssl,
    ssl_cert          => $apache_ssl_cert,
    ssl_key           => $apache_ssl_key,
    error_log_level   => $apache_error_log_level,
    rewrite_log_level => $apache_rewrite_log_level,
    require           => [ A2mod['php5'], Drupal::Site[$name] ],
  }
}
