as yet unclassified
pauseCapture

    captureBuffer := captureBuffer concatenate: (
      input copyFrom: captureStart to: index - 1).
    captureStart := -1
