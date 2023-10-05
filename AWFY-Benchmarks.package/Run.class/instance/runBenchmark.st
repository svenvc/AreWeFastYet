as yet unclassified
runBenchmark

    ScriptConsole println: ('Starting ', name, ' benchmark ... ').
    
    self doRuns: benchmarkSuite new.
    self reportBenchmark.

    ScriptConsole println: ''
