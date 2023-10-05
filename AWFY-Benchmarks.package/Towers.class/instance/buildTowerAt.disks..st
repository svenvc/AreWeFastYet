as yet unclassified
buildTowerAt: pile disks: disks

    disks to: 0 by: -1 do: [ :i |
      self pushDisk: (TowersDisk new: i) onPile: pile ]
