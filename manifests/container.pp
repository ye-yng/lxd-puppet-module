## LXD container define
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.
# Copyright 2020 The LXD Puppet module Authors. All rights reserved.

define lxd::container(
    $image,
    $type,
    $set_ip,
    $config = {},
    $devices = {},
    $profiles = ['default'],
    $state = 'started',
    $ensure = 'present',
    $ip_address = undef,
    $netmask = undef,
    $gateway = undef,
    $dns1 = undef,
    $dns2 = undef,
    $dns3 = undef,
) {
    # creating lxd container

    lxd_container { $name:
        ensure   => $ensure,
        state    => $state,
        config   => $config,
        devices  => $devices,
        profiles => $profiles,
        image    => $image,
        type     => $type,
    }
   
    -> lxd::network { 'set ip':
        set_ip => $set_ip,
        ip_address => $ip_address,
        netmask => $netmask,
        gateway => $gateway,
        dns1 => $dns1,
        dns2 => $dns2,
        dns3 => $dns3,
    }
 
    case $ensure {
        'present': {
            Lxd::Image[$image]
            -> Lxd::Container[$name]
        }
        'absent': {
            Lxd::Container[$name]
            -> Lxd::Image[$image]
        }
        default : {
            fail("Unsuported ensure value ${ensure}")
        }
    }
}
