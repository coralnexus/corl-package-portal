
class coralnexus::drupal::default::apache {

  $web_home = $coralnexus::drupal::default::web_home

  #---

  $modules = [
    "alias",
    "autoindex",
    "deflate",
    "env",
    "mime",
    "rewrite",
    "ssl",
    "vhost_alias"
  ]
}
