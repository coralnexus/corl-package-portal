
class coralnexus::drupal::default::percona {

  $configurations = {
    "mysqld" => {
      "key_buffer_size"                 => "256M",
      "max_allowed_packet"              => "24M",
      "table_open_cache"                => "256M",
      "sort_buffer_size"                => "5M",
      "read_buffer_size"                => "5M",
      "read_rnd_buffer_size"            => "10M",
      "myisam_sort_buffer_size"         => "64M",
      "thread_cache_size"               => "8",
      "thread_concurrency"              => "8",
      "innodb_buffer_pool_size"         => "256M",
      "innodb_additional_mem_pool_size" => "20M",
      "innodb_log_buffer_size"          => "8M",
      "innodb_lock_wait_timeout"        => "50"
    },
    "mysqldump" => {
      "max_allowed_packet" => "24M",
    },
    "myisamchk" => {
      "key_buffer_size"  => "128M",
      "sort_buffer_size" => "128M",
      "read_buffer"      => "5M",
      "write_buffer"     => "5M",
    }
  }
}
