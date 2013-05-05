String extend [
    includesSubstring: aString caseSensitive: aCase [
        "Phexample unit testing"
        "MIT licensed"
        <category: '*PharoCompat'>

        ^(self indexOf: aString matchCase: aCase startingAt: 1) isNil not
    ]
]
