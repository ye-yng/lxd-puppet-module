define lxd::network (
    $set_ip,
    $instance_name,
    $ip_address = undef,
    $netmask = undef,
    $gateway = undef,
    $dns = [],
){
    if $set_ip == 'true' {
      if $ip_address == undef {
        fail("No ip_address given.")
      } elsif $netmask == undef {
        fail("No netmask given.")
      } elsif $gateway == undef {
        fail("No gateway given.")
      } elsif length($dns) == 0 {
        fail("No default DNS server given.")
      }

      if length($dns) > 3 {
        notify{"warning":
          message => "Warning: Maximum number of DNS servers accepted is 3.",
        }
      }

      $parsed_dns = join($dns,' ')

      exec { 'lxd-network':
        command => "/usr/local/AS/bin/lxd-network.sh ${instance_name} ${ip_address} ${netmask} ${gateway} ${parsed_dns}",
      }
    } elsif $set_ip == 'false' {
      #do nothing
    } else {
      fail("Invalid set_ip value. Expected 'true' or 'false', got ${set_ip}")
    }
}
