# == Class: junos
#
# Manage Juniper Switches

class junos (
  $junos_hostname = $::hostname,
  $vlans          = undef,
  $static_vlans   = '110',
) {

#  include netdev_stdlib_junos

  netdev_device { $junos_hostname: }

  # <manage vlans>
  if $vlans != undef {

    validate_hash($vlans)
    $vlans_keyvalues_array = join_keys_to_values($vlans,'_')

    # search for static vlans
    if member($vlans_keyvalues_array, 'vlan_id_110') == true {
      fail('member found vlan_id_110 :(')
    }

    if has_key($vlans, '110') {
      fail('has_key found 110 :(')
    }

    validate_slength(grep($vlans, '110'),0)

    create_resources( netdev_vlan, $vlans )
    # </manage vlans>
  }
}
