
class coralnexus::portal::default::apache {

  $web_home = $coralnexus::portal::default::web_home

  #---

  $modules = [
    "alias",
    "autoindex",
    "deflate",
    "env",
    "mime",
    "proxy",
    "proxy_http",
    "rewrite",
    "ssl",
    "vhost_alias"
  ]
}
