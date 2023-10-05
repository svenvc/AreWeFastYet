as yet unclassified
asString

      ^ 'Packet(', 
          link asString, ', ',
          identity asString, ', ',
          kind asString, ', ',
          datum asString, ', ',
          data asString,
        ')'
