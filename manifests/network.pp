define lxd::network (
    $set_ip,
    $ip_address = undef,
    $netmask = undef,
    $gateway = undef,
    $dns1 = undef,
    $dns2 = undef,
    $dns3 = undef,

){
    if $set_ip == 'true' {
      if $ip_address == undef {
        fail("No ip_address given.")
      } elsif $netmask == undef {
        fail("No netmask given.")
      } elsif $gateway == undef {
        fail("No gateway given.")
      } elsif $dns1 == undef {
        fail("No default DNS server given.")
      }

      if $dns3 {
       exec { 'lxd-network':
         command => 'systemctl daemon-reload',
         path    => '/usr/local/AS/bin',
       }

     } elsif $dns2 {
       exec { 'systemctl_daemon_reload':
         command => 'systemctl daemon-reload',
         path    => '/usr/local/AS/bin',
       }
     } else {
       exec { 'systemctl_daemon_reload':
         command => 'systemctl daemon-reload',
         path    => '/usr/local/AS/bin',
       }
     }

    } elsif $set_ip == 'false' {
      #do nothing
    } else {
      fail("Invalid set_ip value. Expected 'true' or 'false', got ${set_ip}")
    }
}
