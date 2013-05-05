TestCase subclass: TestString [
    <category: 'PharoCompat-Tests'>

    testIncludesSubstring [
        self assert: ('ABC' includesSubstring: 'ab' caseSensitive: false).
        self assert: ('ABC' includesSubstring: 'bc' caseSensitive: false).
        self assert: ('ABC' includesSubstring: 'c' caseSensitive: false).
        self deny: ('ABC' includesSubstring: 'ab' caseSensitive: true).
        self deny: ('ABC' includesSubstring: 'bc' caseSensitive: true).
        self deny: ('ABC' includesSubstring: 'c' caseSensitive: true).
    ]
]
