as yet unclassified
endCapture

    | captured |
    '' = captureBuffer
      ifTrue:  [ captured := input copyFrom: captureStart to: index - 1 ]
      ifFalse: [
        self pauseCapture.
        captured := captureBuffer.
        captureBuffer := '' ].
    captureStart := -1.
    
    ^ captured
