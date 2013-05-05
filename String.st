String extend [
    includesSubstring: aString caseSensitive: aCase [
        "Phexample unit testing"
        <copyright: #MIT>

        ^(self indexOf: aString matchCase: aCase startingAt: 1) isNil not
    ]
]
