Class {
	#name : #Mandelbrot,
	#superclass : #Benchmark,
	#category : 'AWFY-Benchmarks'
}

{ #category : #'as yet unclassified' }
Mandelbrot >> innerBenchmarkLoop: innerIterations [

    ^ self verify: (self mandelbrot: innerIterations) inner: innerIterations

]

{ #category : #'as yet unclassified' }
Mandelbrot >> mandelbrot: size [

      | sum byteAcc bitNum y |
      sum     := 0.
      byteAcc := 0.
      bitNum  := 0.

      y := 0.

      [y < size] whileTrue: [
          | ci x |
          ci := (2.0 * y / size) - 1.0.
          x  := 0.

          [x < size] whileTrue: [
              | zrzr zi zizi cr escape z notDone |
              zrzr := 0.0.
              zizi := zi := 0.0.
              cr   := (2.0 * x / size) - 1.5.

              z := 0.
              notDone := true.
              escape := 0.
              [notDone and: [z < 50]] whileTrue: [
                  | zr |
                  zr := zrzr - zizi + cr.
                  zi := 2.0 * zr * zi + ci.

                  "preserve recalculation"
                  zrzr := zr * zr.
                  zizi := zi * zi.

                  (zrzr + zizi > 4.0) ifTrue: [
                      notDone := false.
                      escape  := 1.
                  ].
                  z := z + 1.
              ].

              byteAcc := (byteAcc << 1) + escape.
              bitNum  := bitNum + 1.

              " Code is very similar for these cases, but using separate blocks
                ensures we skip the shifting when it's unnecessary,
                which is most cases. "
              bitNum = 8
                  ifTrue: [
                    sum := sum bitXor: byteAcc.
                    byteAcc := 0.
                    bitNum  := 0. ]
                  ifFalse: [
                    (x = (size - 1)) ifTrue: [
                        byteAcc := byteAcc << (8 - bitNum).
                        sum := sum bitXor: byteAcc.
                        byteAcc := 0.
                        bitNum  := 0. ]].
              x := x + 1.
          ].
          y := y + 1.
      ].

      ^ sum

]

{ #category : #'as yet unclassified' }
Mandelbrot >> verify: result inner: innerIterations [

    innerIterations = 500 ifTrue: [ ^ result = 191 ].
    innerIterations = 750 ifTrue: [ ^ result = 50  ].
    innerIterations = 1   ifTrue: [ ^ result = 128 ].

    ScriptConsole println: ('No verification result for ', innerIterations asString, ' found').
    ScriptConsole println: ('Result is: ', result asString).
    ^ false

]
