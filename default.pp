
class coralnexus::portal::default {

  $apache_drupal_classes = [
    "php::mod::apc",
    "php::mod::curl",
    "php::mod::gd",
    "php::mod::xmlrpc",
    "php::mod::uploadprogress",
    "php::mod::xdebug"
  ]

  #---

  $web_home = '/var/www'
}

